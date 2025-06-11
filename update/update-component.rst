:orphan:

Update Component
================

The OXID Update Component provides tools for modernizing modules and updating your shop to version 8.0.

Installation
------------

The component currently needs to be installed into an OXID eShop 8.0-alpha.1 installation to provide
the 7 to 8 migration features. Please put modules you'd like to modernize in a local repository beside the shop
installation. Modules do not need to be installed via composer in order to be converted.

Install the component using Composer:

.. code:: bash

    composer require oxid-esales/oxideshop-update-component dev-b-8.0.x

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

For detailed usage instructions, see:

* :doc:`Module Modernization <module-modernization>`
* :doc:`Update to 8.0 <update-to-8-0>`

