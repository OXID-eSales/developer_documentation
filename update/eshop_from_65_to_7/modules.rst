Modules
=======

For updating existing modules from OXID eShop 6.5.x to OXID eShop 7, please have a look at the following sections.

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
* :ref:`Adjust entry point <port_to_v7-entry-point-20221123>`
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

Since version 7.0 we do not support PHP version lower 8.0. Please update your source code to work with `required PHP
versions. <https://docs.oxid-esales.com/eshop/en/7.0/installation/new-installation/server-and-system-requirements.html#php>`_

.. _port_to_v7-mysql-20221123:

Adjust MySQL version
^^^^^^^^^^^^^^^^^^^^

We added MySQL 8 support and dropped MySQL 5.5 and 5.6 support. Please also note that we dropped encoding of database
values as functionality is no longer supported by `MySQL v8.0 <https://dev.mysql.com/doc/refman/8.0/en/mysql-nutshell.html#mysql-nutshell-removals>`__

.. _port_to_v7-symfony-20221123:

Adjust Symfony components
^^^^^^^^^^^^^^^^^^^^^^^^^

We updated Symfony components to v6. Please adjust your code to work with required `Symfony version <https://symfony.com/components>`__

.. _port_to_v7-migrations-20221123:

Adjust module migrations
^^^^^^^^^^^^^^^^^^^^^^^^

After doctrine update, you need to adjust your module migrations to a new configuration format.

    `More information <https://github.com/doctrine/migrations/blob/3.5.1/UPGRADE.md>`__

.. _port_to_v7-removed-functions-20221123:

Adjust removed functionality
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   .. todo: #tbd: replace 7.0-prelim with 7.0

 * Make sure your module does not use any of the functionality that has been removed in OXID eShop 7.0.
   You can find a list of changes in the `OXID eShop 7.0 Release Notes <https://docs.oxid-esales.com/eshop/en/7.0-prelim/releases/releases-70/oxid-eshop-700.html>`_.
 * Besides removed functionality, we also removed `deprecated methods and classes. <https://github.com/OXID-eSales/oxideshop_ce/blob/b-7.0.x/CHANGELOG.md#removed>`__.
 * Based on the psr-12 (`more info <https://www.php-fig.org/psr/psr-12>`__), all method names MUST NOT be prefixed with a
   single underscore to indicate protected or private visibility. So, we renamed all the underscore method by removing
   their prefix underscore. Your module also has to be updated accordingly. We also recommend to make your module
   compatible with psr-12 by renaming the modules underscore methods too. It can be done either manually or via
   `rector <https://github.com/OXID-eSales/rector>`__ which helps us to do it faster. We already have provided a rector
   for this purpose and it can be run with the following steps:

    - Update composer with adding ``rector/rector`` package:

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

    - Renaming underscore methods:

    .. code::

        # e.g. for oxid-esales/paypal-module
        cp vendor/rector/rector/templates/oxidEsales/oxid_V7_underscored_methods_renamer_rector.php.dist  ./rector.php && sed -i 's/MODULE_VENDOR_PATH/<module-vendor>\/<module-ID>/g' rector.php && vendor/bin/rector process

.. _port_to_v7-add-namespaces-20221123:

Move the module under a module namespace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We do not support `not namespaced classes`. So as the next step, the module should be refactored to use only namespaced classes.

 :ref:`More information <namespaces_for_modules-20221123>`

.. _port_to_v7-composer-20221123:

Update composer file
^^^^^^^^^^^^^^^^^^^^

In eshop version 7.0 we do not copy modules files and folder from vendor folder to the source/modules directory anymore,
therefore to make your modules compatible with it:

 * Composer autoloader in composer.json should be refactored to point to the module root directory in vendor
 * `blacklist-filter`, `target-directory`, and `source-directory` should be removed from composer.json

 :ref:`More information <copy_module_via_composer-20170217>`

.. _port_to_v7-metadata-20221123:

Update metadata file
^^^^^^^^^^^^^^^^^^^^

In version 7.0 we only support metadata version >= 2.0. So as the first step you should change your metadata structure
to use the proper version.

 :ref:`More information <metadata_version2-20170427>`

.. _port_to_v7-entry-point-20221123:

Adjust entry point
^^^^^^^^^^^^^^^^^^

If the module has entry points (direct calls to php files), it should be refactored to use controllers instead.

 :ref:`More information <module-controllers-20170427>`

.. _port_to_v7-template-path-20221123:

Adjust module templates path (only for smarty)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Paths for module **smarty** templates in the metadata.php should be changed to be relative to the module root directory.

 :ref:`More information <module-templates-20170427>`

.. _port_to_v7-assets-20221123:

Locate module assets correctly
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Assets should be copied to <module-root-directory>/assets folder. Module thumbnails also should be copied to the
`assets` directory.

  :ref:`More information <modules_structure-20170217>`

.. _port_to_v7-twig-20221123:

Add Twig engine support
^^^^^^^^^^^^^^^^^^^^^^^

Since version 7.0 `Twig <https://twig.symfony.com>`__ is a default template engine. Please update your modules in order
to work with it:

 * Update to templating-engine agnostic names in all module controllers, e.g.:

    .. code::

        Controller::$_sThisTemplate = 'page/content'` instead of `'page/content.tpl'

 * Add Twig templates for twig specific theme.

Information about converting existing templates from Smarty to Twig and how to use it can be found in

    :doc:`Twig Template Engine </development/modules_components_themes/module/using_twig_in_module_templates>`

.. _port_to_v7-tests-20221123:

Adjust module tests
^^^^^^^^^^^^^^^^^^^

We deprecated `Testing Library <https://github.com/OXID-eSales/testing_library>`__ in version 7.0 and recommend to
update your module tests to use default PHPUnit or Codeception test framework functionality. You can read OXID best
practice for testing :ref:`here. <testing-20221123>`

.. _port_to_v7-html-escaping-20221123:

Check HTML-escaping
^^^^^^^^^^^^^^^^^^^

The class `Core\Field` does not escape HTML special characters anymore, Twig template engine is automatically escaping
these characters and printing them out safely. But if your module renders some content that may have been filled in by
the user, you need to escape it in order to prevent cross-site scripting attacks. In some cases, you may need to actually
print out some content unescaped. To do this, just use the handy raw filter:

    .. code::

        {{ pageData.summary|raw }}

For backwards compatibility reasons we created the configuration parameter `oxid_esales.templating.engine_autoescapes_html`
that delegates HTML-escaping to template engine. As Smarty do not escape html special characters by default, we activate
HTML-escaping in `Core\Field` by deactivating this configuration parameter.

.. _port_to_v7-module-handler-20221123:

Check changes in the module handler
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Please also notice some changes in the module handler:

 * Does not store module controllers in the database anymore
 * The information about active modules state is located in the module configuration (yml files), not in the database
   (`activeModules` config option is completely removed)
 * Reads module class extensions chain directly from the shop configuration (yml files). It does not store active
   module chain in the database (`aModules` config option is completely removed)
 * Does not store module settings in the database anymore. You can't receive a module setting from Config class
   or oxconfig table. To receive module setting please use settings service ``ModuleSettingServiceInterface``. :doc:`More information </development/modules_components_themes/module/module_settings>`
