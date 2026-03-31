Custom Product Search
=====================

By default, OXID eShop uses its built-in SQL-based product search. You can replace it with
a custom implementation (e.g. Meilisearch, Elasticsearch) by providing a service that
implements ``ProductSearchServiceInterface``. The implementation can be shipped as part of
a :doc:`module </development/modules_components_themes/module/index>` or a
:doc:`component </development/modules_components_themes/component>`.

When the custom search is enabled and the service is not registered or throws any exception,
the shop automatically falls back to the built-in SQL search so the storefront remains functional.

Enabling custom search
----------------------

To enable the custom search, set the ``oxid_esales.product_search_enabled`` parameter to ``true``
in ``var/configuration/configurable_services.yaml``:

.. code-block:: yaml
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.product_search_enabled: true

In a multi-shop setup, you can enable the custom search for a specific shop only by placing
the file under ``var/configuration/shops/<shopId>/configurable_services.yaml`` instead.
This allows enabling a custom search engine for one shop while keeping the built-in SQL search for others.

.. note::

    The container cache must be rebuilt after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code:: bash

       ./vendor/bin/oe-console oe:cache:clear


Implementing the interface
--------------------------

Create a class implementing ``ProductSearchServiceInterface``:

.. code:: php

    namespace MySearchComponentExample\Search;

    use OxidEsales\EshopCommunity\Internal\Domain\Product\Search\ProductSearchCriteria;
    use OxidEsales\EshopCommunity\Internal\Domain\Product\Search\ProductSearchResult;
    use OxidEsales\EshopCommunity\Internal\Domain\Product\Search\ProductSearchServiceInterface;
    use OxidEsales\EshopCommunity\Internal\Framework\Database\Id;

    class CustomProductSearchService implements ProductSearchServiceInterface
    {
        public function search(ProductSearchCriteria $criteria, array $context = []): ProductSearchResult
        {
            $response = $this->externalSearch(
                $criteria->getTerm()->getValue(),
                $criteria->getPagination()->getOffset(),
                $criteria->getPagination()->getLimit()
            );

            $ids = array_map(
                fn(string $id) => Id::fromString($id),
                $response->getIds()
            );

            return new ProductSearchResult($ids, $response->getTotal());
        }
    }

``ProductSearchResult`` expects a ``list<Id>`` in the order they should appear in the
search results, preserving the relevance ranking from the external search engine.
Use ``Id::fromString()`` to wrap each product oxid string.

.. warning::

    The external search must return only IDs of products that are active and loadable
    in the shop. If the result contains IDs that the shop cannot load (e.g. inactive,
    deleted, or out-of-scope products), the total count will not match the number of
    products actually rendered, causing incorrect pagination.

.. warning::

    The shop does not apply subshop scope filtering to results returned by the custom search.
    Your implementation is solely responsible for restricting results to the correct subshop.
    Returning IDs from other subshops might lead to unexpected search results shown in the frontend.

The ``context`` parameter is an arbitrary key-value array passed through from the caller
(e.g. locale, shop ID, customer group). Its contents are defined by the module that
populates it via ``BeforeProductSearchEvent``.

Filters and sorting
-------------------

The ``ProductSearchCriteria`` object may carry filters and sorting instructions built from
the classes in ``OxidEsales\EshopCommunity\Internal\Framework\Search``.

**Filters**

Use ``EqualsFilter`` to match a single value on a field:

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Framework\Search\EqualsFilter;

    $filter = new EqualsFilter('oxmanufacturerid', 'oxid');

Use ``InFilter`` to match any of several values on a field. At least one value is required:

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Framework\Search\InFilter;

    $filter = new InFilter('oxmanufacturerid', ['2b836', '43456']);

Both implement ``FilterInterface`` and expose ``getField()``.
``EqualsFilter`` exposes ``getValue()`` for the single matched value;
``InFilter`` exposes ``getValues()`` for the list of matched values.
Retrieve all active filters from the criteria via ``$criteria->getFilters()``.

**Sorting**

Use ``Sorting`` with a ``SortDirection`` enum value (``Asc`` or ``Desc``):

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Framework\Search\Sorting;
    use OxidEsales\EshopCommunity\Internal\Framework\Search\SortDirection;

    $sorting = new Sorting('oxvarminprice', SortDirection::Asc);
    $sorting = new Sorting('oxtitle', SortDirection::Desc);

Retrieve all active sorting instructions from the criteria via ``$criteria->getSorting()``.

Registering the service
-----------------------

Register your implementation under the interface ID in the ``services.yaml`` file of your
module or component:

.. code-block:: yaml
   :caption: services.yaml

    services:
      OxidEsales\EshopCommunity\Internal\Domain\Product\Search\ProductSearchServiceInterface:
        class: MySearchComponentExample\Search\CustomProductSearchService
        autowire: true
        public: true

Then enable the custom search by setting the parameter in ``var/configuration/configurable_services.yaml``
(or in ``var/configuration/shops/<shopId>/configurable_services.yaml`` for a specific shop):

.. code-block:: yaml
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.product_search_enabled: true

.. note::

    If ``oxid_esales.product_search_enabled`` is ``true`` but no implementation is registered,
    the shop logs a warning and falls back to the built-in SQL search automatically.
    It is still recommended to keep the parameter ``false`` until your service is fully
    configured and tested.

Events
------

The shop dispatches two events for every product search **when the custom search path is active**,
allowing modules to inspect or modify the search without touching the controller.
These events are not dispatched when the built-in SQL search is used.

**BeforeProductSearchEvent**

Dispatched before the search runs. Listeners may replace the criteria or context:

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Domain\Product\Search\Event\BeforeProductSearchEvent;

    public static function getSubscribedEvents(): array
    {
        return [BeforeProductSearchEvent::class => 'onBeforeSearch'];
    }

    public function onBeforeSearch(BeforeProductSearchEvent $event): void
    {
        $event->setSearchCriteria($modifiedCriteria);
        $event->setContext(['locale' => 'de_DE']);
    }

**AfterProductSearchEvent**

Dispatched after the search runs. The criteria and context that produced the
result are available as read-only. The result itself may be replaced by listeners:

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Domain\Product\Search\Event\AfterProductSearchEvent;

    public static function getSubscribedEvents(): array
    {
        return [AfterProductSearchEvent::class => 'onAfterSearch'];
    }

    public function onAfterSearch(AfterProductSearchEvent $event): void
    {
        $criteria = $event->getSearchCriteria();   // read-only
        $context  = $event->getContext();    // read-only
        $result   = $event->getSearchResult();

        $event->setSearchResult($filteredResult);
    }
