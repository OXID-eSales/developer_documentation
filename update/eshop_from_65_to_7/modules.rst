Updating modules
================

To update existing modules from OXID eShop 6.5.x to OXID eShop 7, check the following sections.

Overview
--------

* :ref:`Adjust PHP version <port_to_v7-php-20221123>`
* :ref:`Adjust MySQL version <port_to_v7-mysql-20221123>`
* :ref:`Adjust Symfony components <port_to_v7-symfony-20221123>`
* :ref:`Adjust module migrations <port_to_v7-migrations-20221123>`
* :ref:`Adjust removed functionality <port_to_v7-removed-functions-20221123>`
* :ref:`Move the module under a module namespace <port_to_v7-add-namespaces-20221123>`
* :ref:`Update composer file <port_to_v7-composer-20221123>`
* :ref:`Update metadata file <port_to_v7-metadata-20221123>`
* :ref:`Adjust entry points <port_to_v7-entry-point-20221123>`
* :ref:`Adjust module templates path <port_to_v7-template-path-20221123>`
* :ref:`Locate module assets correctly <port_to_v7-assets-20221123>`
* :ref:`Add twig engine support <port_to_v7-twig-20221123>`
* :ref:`Adjust module tests <port_to_v7-tests-20221123>`
* :ref:`Check HTML-escaping <port_to_v7-html-escaping-20221123>`
* :ref:`Check changes in the module handler <port_to_v7-module-handler-20221123>`

Update steps
------------

.. _port_to_v7-php-20221123:

Adjust PHP version
^^^^^^^^^^^^^^^^^^

As of version 7.0, we do not support PHP version lower 8.0.

Update your source code to work with the `required PHP
versions <https://docs.oxid-esales.com/eshop/en/7.0/installation/new-installation/server-and-system-requirements.html#php>`_.

.. _port_to_v7-mysql-20221123:

Adjust MySQL version
^^^^^^^^^^^^^^^^^^^^

We have added MySQL 8 support and dropped MySQL 5.5 and 5.6 support.

Note also that we dropped encoding of database
values as the functionality is no longer supported by `MySQL v8.0 <https://dev.mysql.com/doc/refman/8.0/en/mysql-nutshell.html#mysql-nutshell-removals>`_.

.. _port_to_v7-symfony-20221123:

Adjust Symfony components
^^^^^^^^^^^^^^^^^^^^^^^^^

We have updated Symfony components to v6.

Adjust your code to work with the required `Symfony version <https://symfony.com/components>`_.

.. _port_to_v7-migrations-20221123:

Adjust module migrations
^^^^^^^^^^^^^^^^^^^^^^^^

After doctrine update, you adjust your module migrations to a new configuration format.

For more information, see `github.com/doctrine/migrations/blob/3.5.1/UPGRADE.md <https://github.com/doctrine/migrations/blob/3.5.1/UPGRADE.md>`_.

.. _port_to_v7-removed-functions-20221123:

Adjust removed functionality
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 * Make sure your module does not use any of the functionality that has been removed in OXID eShop 7.0.

   You can find a list of changes in the `OXID eShop 7.0 Release Notes <https://docs.oxid-esales.com/eshop/en/7.0/releases/releases-70/oxid-eshop-700.html>`_.
 * Besides removed functionality, we have also removed `deprecated methods and classes <https://github.com/OXID-eSales/oxideshop_ce/blob/b-7.0.x/CHANGELOG.md#removed>`_.
 * Based on the `PSR-12: Extended Coding Style <https://www.php-fig.org/psr/psr-12>`_, all method names MUST NOT be prefixed with a single underscore to indicate protected or private visibility.

   So, we renamed all the underscore method by removing
   their prefix underscore.

   Your module also has to be updated accordingly.

   We also recommend making your module
   compatible with psr-12 by renaming the modules underscore methods too.
   |br|
   You can do so either manually or via
   `rector <https://github.com/OXID-eSales/rector>`_ which helps us to do it faster.
   |br|
   We already have provided a rector
   for this purpose.
   To run it, perform the following steps:

    1. Update composer with adding ``rector/rector`` package:

       .. code::

            "require-dev": {
                "rector/rector": "dev-master"
            },
            "repositories": {
                "rector/rector": {
                    "type": "vcs",
                    "url": "https://github.com/OXID-eSales/rector"
                }
            }

    2. Rename the underscore methods:

       .. code::

            # for the oxid-esales/paypal-module, for example
            cp vendor/rector/rector/templates/oxidEsales/oxid_V7_underscored_methods_renamer_rector.php.dist  ./rector.php && sed -i 's/MODULE_VENDOR_PATH/<module-vendor>\/<module-ID>/g' rector.php && vendor/bin/rector process

.. _port_to_v7-add-namespaces-20221123:

Move the module under a module namespace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We do not support `not namespaced classes`.

So as the next step, refactor the module to use only namespaced classes.

For more information, see :ref:`Extending an OXID eShop class with a module <namespaces_for_modules-20221123>`.

.. _port_to_v7-composer-20221123:

Update composer file
^^^^^^^^^^^^^^^^^^^^

As of OxXID eShop version 7.0, we do not copy modules files and folder from vendor folder to the source/modules directory anymore.

Therefore, to make your modules compatible with it, do the following:

 * To point to the module root directory in vendor, in the :file:`composer.json` file, refactor Composer autoloader.
 * From the :file:`composer.json` file, remove `blacklist-filter`, `target-directory`, and `source-directory`.

For more information, see :ref:`Composer.json for an OXID eShop module <copy_module_via_composer-20170217>`.

.. _port_to_v7-metadata-20221123:

Update metadata file
^^^^^^^^^^^^^^^^^^^^

In version 7.0 we only support metadata version >= 2.0.

So, as the first step, change your metadata structure
to use the proper version.

For more information, see :ref:`Metadata 2.0 <metadata_version2-20170427>`.

.. _port_to_v7-entry-point-20221123:

Adjust entry points
^^^^^^^^^^^^^^^^^^^

If the module has entry points (direct calls to php files), refactor it to use controllers instead.

For more information, see :ref:`Controllers <module-controllers-20170427>`

.. _port_to_v7-template-path-20221123:

Adjust module templates path (only for smarty)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Change the paths for the module **Smarty** templates in the :file:`metadata.php` file to be relative to the module root directory.

For more information, see :ref:`Templates (Smarty only) <module-templates-20170427>`.

.. _port_to_v7-assets-20221123:

Locate module assets correctly
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Copy assets to the :file:`<module-root-directory>/assets` folder.

Copy module thumbnails also to the :file:`assets` directory.

For more information, see :ref:`File and folder structure <modules_structure-20170217>`.

.. _port_to_v7-twig-20221123:

Add Twig engine support
^^^^^^^^^^^^^^^^^^^^^^^

As of version 7.0, `Twig <https://twig.symfony.com>`_ is the default template engine.

Update your modules in order to work with it:

 1. Update to templating-engine agnostic names in all module controllers, e.g.:

    .. code::

       Controller::$_sThisTemplate = 'page/content'` instead of `'page/content.tpl'

 #. Add Twig templates for a twig specific theme.

For more information about converting existing templates from Smarty to Twig and how to use it, see :doc:`Twig Template Engine </development/modules_components_themes/module/using_twig_in_module_templates>`.

.. _port_to_v7-tests-20221123:

Adjust module tests
^^^^^^^^^^^^^^^^^^^

The `Testing Library <https://github.com/OXID-eSales/testing_library>`__ is deprecated in version 7.0. We recommend
updating your module tests to use the default PHPUnit or Codeception test framework functionality.

For more information about OXID best practices for testing, see :ref:`Testing <testing-20221123>`.

.. _port_to_v7-html-escaping-20221123:

Check HTML-escaping
^^^^^^^^^^^^^^^^^^^

The class `Core\Field` does not escape HTML special characters anymore, Twig template engine is automatically escaping
these characters and printing them out safely.

But if your module renders some content that may have been filled in by
the user, you need to escape it in order to prevent cross-site scripting attacks.

In some cases, you may need to actually
print out some content unescaped. To do this, just use the handy raw filter:

    .. code::

       {{ pageData.summary|raw }}

For backwards compatibility reasons, we have created the configuration parameter `oxid_esales.templating.engine_autoescapes_html`.

This parameter delegates HTML-escaping to the template engine.

As Smarty do not escape html special characters by default, we activate
HTML-escaping in `Core\Field` by deactivating this configuration parameter.

.. _port_to_v7-module-handler-20221123:

Check changes in the module handler
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Notice also some changes in the module handler:

 * It does not store module controllers in the database anymore.
 * The information about active modules state is located in the module configuration (:file:`yml` files), not in the database
   (`activeModules` config option is completely removed).
 * It reads the module class extensions chain directly from the shop configuration (:file:`yml` files). It does not store the active module chain in the database (the `aModules` config option is completely removed).
 * It does not store module settings in the database anymore. So, you can't receive a module setting from Config class
   or oxconfig table.

   To receive module setting, use the settings service ``ModuleSettingServiceInterface``.

   For more information, see :doc:`Module settings </development/modules_components_themes/module/module_settings>`.
