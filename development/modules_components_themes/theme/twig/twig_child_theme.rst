Extending a Twig-compatible theme with a child theme
====================================================

Create a child theme for an existing (and installed) theme in OXID eShop.

There's only one level of inheritance possible, and depending on the use case, you can achieve the same
inheritance results with a module.

.. todo: #DK: Sounds unclear, redundant: "There's only one level of inheritance possible, and depending on the use case, you can achieve the same
inheritance results with a module." Do we mean the following?

Use the Twig extension mechanism in both child themes and modules.

In child themes, it is limited to extending or modifying existing template blocks, while in modules, you also have the ability to completely replace templates and extend the controller.

* Twig extension mechanism for child themes

  When creating a child theme, you can use the Twig extension mechanism to extend or modify existing template blocks. This allows you to change specific parts of a template without needing to copy or replace the entire template.

* Twig extension mechanism for modules

  The second approach relates to the use of modules. Here, you can also use Twig extensions, but additionally, you have the option to completely replace a template with your own module template. This means you can bypass the original theme’s template entirely by creating your own template within the module and extending the shop controller (chain extend) to use the module's template instead of the original theme's template.

We'll show both cases in the following section.

.. todo: #DK: In which case would I prefer one method rather than the other?

Creating a child theme
----------------------

|procedure|

1. Create a Composer-installable child theme of APEX.
#. To mark the theme as a child theme, add `parentTheme` and `parentVersions` into `theme.php` as in the following example:

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

#. Only copy the templates you need to adapt, maintaining the same file structure as the parent theme.

   For a child theme it's not necessary to copy the entire parent theme.

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

|result|

The template engine renders the child theme's `start.html.twig` file while using all other templates from the parent theme (:ref:`twig_child_theme_001`).

.. _twig_child_theme_001:

.. figure:: ../../../../media/screenshots/twig_child_theme_001.png
   :alt: Twig child theme example
   :height: 228
   :width: 400
   :class: with-shadow

   Fig.: Twig child theme example

Extending a theme via module
----------------------------

.. todo: #DK: check: use case/benefits described correctly?

All you can achieve with a child theme you can also do with a module.

If you want to :emphasis:`completely` replace a template using a child theme, create your own template within the :emphasis:`module` and then "chain-extend" the relevant shop controller.

Background: With the Twig extension mechanism, you can only extend existing template :emphasis:`blocks`.

Benefit of using modules: In all OXID eShop Version 7 installations, module settings fully reside in YAML configuration files, which are much easier to deploy than theme configurations that are still stored in the database (`oxconfig` table).

A module can extend templates for each theme, but we also have a 'one size fits all' approach by using the special directory called `default`.

This generalized approach simplifies the process by allowing a single set of templates in the default directory to work across multiple themes, reducing the need for redundant customization.

.. todo:  Regarding the 'I want to completely exchange a template by child theme' case: That's also possible via module, you need to add a module own template and chain extend the shop controller in question using the module's template instead of the original theme template.

To learn more about theme extensions for modules, check the following documentation:

* :ref:`extending-existing-templates`
* :ref:`using-twig-in-module-templates`
* :ref:`extending-an-active-theme-block`

