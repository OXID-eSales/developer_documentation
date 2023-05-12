Extending an active theme block
===============================

.. todo: #Igor: urgent: must be updated to APEX theme

Learn how to extend or overwrite an active OXID eShop theme block.

|prerequisites|

* You have installed the module.
  |br|
  For more information about the module installation, see :ref:`development/modules_components_themes/module/tutorials/module_setup:Best practice module setup for development with composer`.
* You have activated the `Twig theme <https://github.com/OXID-eSales/twig-theme>`__.


Overwriting 'mini basket' actions
---------------------------------

In the following example, replace the original mini basket buttons with a new checkout button.

To accomplish this goal, extend :technicalname:`widget_minibasket_total.html.twig`.

**Twig theme structure**
::

    ├── twig // eShop theme
        └── tpl
            └── twig
                └── widget
                    └── minibasket
                        └── minibasket.html.twig // Location of the original widget

**Module views structure**
::

    ├── module-1 // The module where we want to extend the block
        └── views
            └── twig
                └── extensions
                    └── themes
                        └── twig
                            └── widget
                                └── minibasket
                                    └── minibasket.html.twig


|procedure|

1. Extend :technicalname:`widget/minibasket/minibasket.html.twig`, then use :technicalname:`dd_layout_page_header_icon_menu_minibasket_functions` block to add the new button to :technicalname:`minibasket`.

.. note::

  For more information about Twig block and extends tags, see

  * `extends <https://twig.symfony.com/doc/2.x/tags/extends.html>`__
  * `block <https://twig.symfony.com/doc/2.x/tags/block.html>`__

.. code::

    {% extends 'widget/minibasket/minibasket.html.twig' %}

    {% block dd_layout_page_header_icon_menu_minibasket_functions %}

        <p class="functions clear text-right">
            <a href="{{ seo_url({ ident: oViewConf.getSelfLink()|cat("cl=payment") }) }}" class="btn btn-info">{{ translate({ ident: "CHECKOUT" }) }}</a>
        </p>

    {% endblock %}

2. (Re)activate the module.
3. To make the basket actions visible, add at least one product to the basket.

|result|

The new button appears instead of the original two.


Extending 'mini basket' actions
-------------------------------

In the following example, based on the previous example, keep the original buttons with the newly added button.

To do so, call the :technicalname:`parent()` method inside a block.

For more information about the method, see `parent() <https://twig.symfony.com/doc/2.x/tags/extends.html#parent-blocks>`__).

|procedure|

Add the :technicalname:`parent()` method to :technicalname:`minibasket.html.twig`.

.. code::

    {% extends 'widget/minibasket/minibasket.html.twig' %}

    {% block dd_layout_page_header_icon_menu_minibasket_functions %}

        {{ parent() }}

        <p class="functions clear text-right">
            <a href="{{ seo_url({ ident: oViewConf.getSelfLink()|cat("cl=payment") }) }}" class="btn btn-info">{{ translate({ ident: "CHECKOUT" }) }}</a>
        </p>

    {% endblock %}