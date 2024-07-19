Extend twig compatible theme with a child theme
===============================================

It is possible to create a child theme for an existing (and installed) theme in OXID eShop.
There's only one level of inheritance possible, and depending on the use case, it's possible to achieve the same
inheritance results with a module.

We'll show both cases in the following section.

Create a child theme
^^^^^^^^^^^^^^^^^^^^

Create a Composer-installable child theme of APEX. To mark a theme as a child theme,
add `parentTheme` and `parentVersions` into theme.php as in the following example:

.. code:: php

   $aTheme = [
        'id'          => 'apex_child',
        'title'       => 'APEX child',
        'description' => 'APEX child is OXID`s demo child of APEX theme.',
        'thumbnail'   => 'theme.jpg',
        'version'     => '0.0.1',
        'author'      => '<a href="http://www.oxid-esales.com" title="OXID eSales AG">OXID eSales AG</a>',
        'settings'    => [],
        'parentTheme' => 'apex',
        'parentVersions' => ['1.1.0', '1.2.2'],
    ];

For a child theme, it's not necessary to copy the entire parent theme. Only copy the templates you need to adapt,
maintaining the same file structure as the parent theme.

.. code:: bash

        |-- composer.json
        |-- theme.php
         `-- tpl
            `-- page
                `-- shop
                    `-- start.html.twig

The child theme's `start.html.twig` template might, for example, get an additional block.

.. _childtheme_template-20240717:

.. code:: twig

    {% capture append = "oxidBlock_content" %}

    {% block child_theme_block %}
        <div>
            This is APEX child theme!!!!
        </div>
    {% endblock %}

    {% include_content 'oxstartslot1' ignore missing  %}

     ...

The template engine renders the child theme's `start.html.twig` file while using all other templates from the parent theme.

.. image:: ../../../../media/screenshots/twig_child_theme_001.png
   :alt: Twig child theme example
   :height: 228
   :width: 400


Extend a theme via module
^^^^^^^^^^^^^^^^^^^^^^^^^

All you can achieve with a child theme can also be done with a module. In all OXID eShop Version 7 installations,
module settings fully reside in YAML configuration files, which are much easier to deploy than theme configurations that are
still stored in the database (oxconfig table).

.. note:: With the twig extension mechanism you can only extend existing template blocks.
        Regarding the 'I want to completely exchange a template by child theme' case. That's also possible via module,
        you need to add a module own template and chain extend the shop controller in question using the module's template
        instead of the original theme template.

A module can extend templates for each theme, but we also have a 'one size fits all' approach by using the special directory name `default`.

To learn more about theme extensions for modules, check the following documentation:

* :ref:`extending-existing-templates`
* :ref:`using-twig-in-module-templates`
* :ref:`extending-an-active-theme-block`
