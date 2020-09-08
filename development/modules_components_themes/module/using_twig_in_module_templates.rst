Using Twig in module templates
==============================

OXID support for Twig template engine allows to:

 * register own (original) module templates
 * extend existing templates

just by following the directory structure conventions.

.. note::
    Having such conventions means that module developers won't have to register their Twig templates or
    template extensions explicitly (in `metadata.php`).

.. _registering-a-new-module-template:

Registering a new module's  template
------------------------------------

To register new Twig templates, simply put them into corresponding directory structure inside your module:

::

    └── module-1
        └── views
            └── twig
                ├── module_1_own_template.html.twig
                └── page
                    └── module_1_own_template.html.twig

After module activation, templates will be automatically registered with namespace matching the module's ID:

.. code:: shell

    @<module-id>/modules_own_template.html.twig
    @<module-id>/page/modules_own_template.html.twig

.. warning::
    Please note that the word `"extensions"` when used in the following directory structure:
    ::

        └── module-1
                └── views
                    └── twig
                        └── extensions
                            └── // <- special location for templates that extend other templates

    is reserved for template extensions (see :ref:`extending-existing-templates`) and as such is not recommended
    to be used for registration of original (non-extending) module templates.

.. _extending-existing-templates:

Extending existing templates
----------------------------

In addition to the out-of-box Twig functionality for template inheritance and reuse
(see `Twig documentation for extends tag <https://twig.symfony.com/doc/3.x/tags/extends.html>`__)
OXID eSales supports **multiple inheritance** for Twig templates which allows to have more than one `{% extends %}`
tag called per rendering.

.. warning::

    Multiple inheritance with
    `dynamic <https://twig.symfony.com/doc/3.x/tags/extends.html#dynamic-inheritance>`__ or
    `conditional inheritance <https://twig.symfony.com/doc/3.x/tags/extends.html#conditional-inheritance>`__
    is not implemented and usage of these Twig features in OXID eShop templates is discouraged!

**Multiple inheritance** is an advanced feature that can be used to combine modifications added to a certain template
from multiple modules into an "inheritance chain".

Depending on type of original template, module template extension can be one of the following:

 * module extensions for OXID eShop templates
 * module extensions of OXID module templates

.. note::
    The type of template extension can be easily determined by its directory structure (see examples below).

.. _extending-shop-templates:

Module extensions for OXID eShop templates
******************************************

This type of template extensions are located in the `themes/` sub folder of `extensions/`:

::

    ├── module-1
       └── views
           └── twig
               ├── extensions
                  └── themes
                      ├── default
                         └── shop-template.html.twig //put theme-unaware templates here
                      └── some-twig-theme
                          └── shop-template.html.twig //put theme-specific templates here

In the example above, result of rendering  *shop-template.html.twig* will depend on active theme's ID:

* when **some-twig-theme** theme is active:

    * extensions/themes/**some-twig-theme**/shop-template.html.twig will be used in template chain

* when **some-other-twig-theme** theme is active

    * extensions/themes/**default**/shop-template.html.twig will be used

.. warning::
    Please note that:

        * `extensions/themes`
        * `extensions/themes/default`

    are reserved paths which have special meaning inside of OXID eShop application (e.g. you should not use "default" as your
    theme ID if you want to avoid running into problems with template inheritance).

.. note::
    Inheritance for **admin templates** is similar to the theme-specific inheritance, because admin is a theme as well,
    you just need to use a corresponding ID when creating admin template extensions (e.g. *twig_admin*).

.. _extending-module-templates:

Module extensions for OXID module templates
*******************************************

When your module needs to extend a template, originating in other module, the extension template should be placed into
`modules/` sub folder of `extensions/`:

::

    ├── module-1 // module-1 file structure
       └── views
           └── twig
               ├── module_1_template.html.twig // original module-1 template
               └── page
                   └── module_1_template.html.twig // original module-1 template


    └── module-2  // module-2 file structure
        └── views
            └── twig
                └── extensions
                    └── modules
                        └── module-1
                            ├── module_1_template.html.twig // extension of module-1 template
                            └── page
                                └── module_1_template.html.twig // extension of module-1 template

.. note::
    Theme-specific template extensions, similar to :ref:`extending-shop-templates` won't work with module template
    extensions!

.. warning::
    Same as for the previous template extension type: `extensions/modules`
    is a path, reserved for placing module template extensions and it's not expected to contain any other templates!

Fine-tuning the template inheritance process
********************************************

Controlling the template rendering engine that utilizes multiple inheritance can be a daunting task by itself.
The situation might get even more complicated if you face the necessity to control the order in which each module template
joins the inheritance chain.

.. note::
    By default module template loading order (template chain) will depend to the order of modules installation.

If your template architecture has to challenge similar problems, inheritance chain can be fine-tuned by usage of a
specific keys in your shop configuration file (*var/configuration/shops/1.yaml*):

::

    modules: {  }
    moduleChains:
        classExtensions: {  }
        templateExtensions: //configuration key
            'page/some-template.html.twig': //name of the extended template
            - module-id-3 //highest-priority module ID (template will be loaded last in chain)
            - module-id-2
            - module-id-4//lowest-priority module ID (template will be loaded earlier in chain)

For the example above, having an OXID eShop application with 4 modules active and extending the same eShop template
*page/some-template.html.twig*
will result in the following template chain:

* CHAIN START
* shop-template
* module-1-template
* module-4-template
* module-2-template
* module-3-template*
* CHAIN END

.. note::
    * Templates for modules, which IDs were not specified in the `templateExtensions` will be put to the chain start (will have the lowest priority).
    * Any template that closes the inheritance chain have the most of decisive "power", comparing to its predecessors, because it can go as far as to stop the contents of "parent" templates from being displayed!
