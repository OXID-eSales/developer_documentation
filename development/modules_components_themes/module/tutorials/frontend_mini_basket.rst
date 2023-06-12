Extending an active theme block
===============================

Learn how to extend or overwrite an active OXID eShop theme block.

|prerequisites|

* You have installed the module.
  |br|
  For more information about the module installation, see :ref:`development/modules_components_themes/module/tutorials/module_setup:Best practice module setup for development with composer`.
* You have activated the `Apex theme <https://github.com/OXID-eSales/apex-theme>`__.


Overwriting 'mini basket' actions
---------------------------------

In the following example, replace the original mini basket display button with a new checkout button.

To accomplish this goal, extend :technicalname:`widget_minibasket_total.html.twig`.

**Apex theme structure**
::

    ├── apex // eShop theme
        └── tpl
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
                        └── apex
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

        <a href="{{ seo_url({ ident: oViewConf.getSelfLink()|cat("cl=payment") }) }}" class="btn btn-outline-primary w-100">{{ translate({ ident: "CHECKOUT" }) }}

    {% endblock %}

2. (Re)activate the module.
3. To make the basket actions visible, add at least one product to the basket.

|result|

The new button appears instead of the original one.


Extending 'mini basket' actions
-------------------------------

In the following example, based on the previous example, keep the original button with the newly added button.

To do so, call the :technicalname:`parent()` method inside a block.

For more information about the method, see `parent() <https://twig.symfony.com/doc/2.x/tags/extends.html#parent-blocks>`__).

|procedure|

Add the :technicalname:`parent()` method to :technicalname:`minibasket.html.twig`.

.. code::

    {% extends 'widget/minibasket/minibasket.html.twig' %}

    {% block dd_layout_page_header_icon_menu_minibasket_functions %}

        {{ parent() }}

        <a href="{{ seo_url({ ident: oViewConf.getSelfLink()|cat("cl=payment") }) }}" class="btn btn-outline-primary w-100">{{ translate({ ident: "CHECKOUT" }) }}

    {% endblock %}