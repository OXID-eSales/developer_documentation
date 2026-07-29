Update Component
================

The OXID Update Component provides tools for modernizing modules and updating your shop to version 8.0.

Installation
------------

Install the component using Composer:

.. code:: bash

    composer require oxid-esales/oxideshop-update-component:^v3.0.0

Available Commands
------------------

Module Modernization
~~~~~~~~~~~~~~~~~~~~

``oe:update:refactor-module``
    Applies general code refactoring to a module

``oe:update:upgrade-module``
    Upgrades module code to be compatible with OXID eShop 8

Shop Update
~~~~~~~~~~~

``oe:update:migrate-config-file``
    Migrates config.inc.php to .env and parameters.yaml files

``oe:update:migrate-config-database``
    Migrates configuration values from the database to parameters.yaml files

``oe:update:migrate-template-filters``
    Migrates Twig filter usage in template files (e.g. date_format() to date())

``oe:update:migrate-product-images``
    Migrates product images data from oxarticles to the new tables

``oe:update:drop-legacy-oxarticles-image-columns``
    Drops legacy image columns (OXPIC1-12, OXTHUMB, OXICON) from oxarticles table

For detailed usage instructions, see:

* :doc:`Module Modernization <module-modernization>`
* :doc:`Update to 8.0 <update-to-8-0>`

