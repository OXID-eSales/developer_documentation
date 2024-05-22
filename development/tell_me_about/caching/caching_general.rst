Understanding system-wide caching
#################################

Overview of the default PSR-6 caching implementation
====================================================

System-wide caching uses `PSR-6 cache standards <https://www.php-fig.org/psr/psr-6/>`__.

Cache Item Pool Interface
-------------------------

The :class:`CacheItemPoolInterface` offers functions to access, store, and remove cache items. It is utilized by all cache components throughout the system and can be accessed through the DI container.

For more information about the :class:`CacheItemPoolInterface`, see `Psr\Cache\CacheItemPoolInterface <https://www.php-fig.org/psr/psr-6/#cacheitempoolinterface>`__.

Implementation of Interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Symfony :class:`FilesystemAdapter` is used as default which is an adapter provided by Symfony that offers caching functionality and implements the `PSR-6 standards <https://www.php-fig.org/psr/psr-6/>`__.

For more information about the Symfony Filesystem adapter, see `Filesystem Cache Adapter <https://symfony.com/doc/current/components/cache/adapters/filesystem_adapter.html>`__.

Configuration
^^^^^^^^^^^^^

Default configuration is defined in the corresponding :file:`services.yaml` under :class:`Cache\\Pool` as such:

.. code-block:: yaml

    Psr\Cache\CacheItemPoolInterface:

Cache Item Pool Factory Interface
---------------------------------

This factory contract guarantees a smooth replacement of the default implementation.

.. code-block:: php

    interface CacheItemPoolFactoryInterface
    {
        public function create(int $shopId): CacheItemPoolInterface;
    }

Implementation of Factory Interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation of the interface is straightforward; the crucial aspect is to configure the `namespace` parameter properly to ensure caches are segregated between shops.
:ref:`See examples <caching-tutorials-20240514>`


Shop Cache Cleaner Interface
----------------------------

The cleaner contract provides an easy way to clear all or specific shop-related caches.

.. code-block:: php

    public function clear(int $shopId): void;
    public function clearAll(): void;

Implementation of Cleaner Interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:class:`ShopCacheFacade` implements the interface and guarantees the invocation of the appropriate services to purge all caches. It can be used via `DI`

Using the Symfony Filesystem adapter
====================================

|procedure|

1. To use the :class:`CacheItemPoolInterface` is straightforward via Dependency Injection (DI):

.. code-block:: php

    public function __construct(private readonly CacheItemPoolInterface $cache)
    {
    }

.. note::

    To change the default implementation and use, for example, Redis-based caching as the default, follow the instructions in our :ref:`Switching to Redis <redis-caching-tutorial-20240514>` tutorial.

2. To clear shop caches:

.. code-block:: php

    public function __construct(private readonly ShopCacheCleanerInterface $cacheCleaner)
    {
    }

    // Specific shop
    $this->cacheCleaner->clear($shopId);

    // All shop cache clear
    $this->cacheCleaner->clearAll();

For more information, see the tutorials under :ref:`Caching examples <caching-tutorials-20240514>`.

Area specific services
======================

Module caching
--------------

* Caching functionalities for modules

.. code-block:: yaml

    OxidEsales\EshopCommunity\Internal\Framework\Module\Cache\ModuleCacheInterface:

* Subscribing to the module cache invalidation event

.. code-block:: yaml

    oxid_esales.module.cache.invalidate_module_cache_event_subscriber:
