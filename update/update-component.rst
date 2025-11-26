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
    Modernize module code

Shop Update
~~~~~~~~~~~

``oe:update:config-file``
    Migrate config.inc.php to new format

``oe:update:config-database``
    Migrate configurations from the database

``oe:update:update-templates``
    Update Twig templates

``oe:update:update-module``
    Update module code

``oe:update:migrate-product-images``
    Migrate product images to new tables

For detailed usage instructions, see:

* :doc:`Module Modernization <module-modernization>`
* :doc:`Update to 8.0 <update-to-8-0>`

