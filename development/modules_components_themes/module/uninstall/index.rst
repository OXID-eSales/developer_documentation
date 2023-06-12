Uninstall
=========

Uninstall module completely
---------------------------

You can easily uninstall module using composer and
`OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__ will do the following steps before composer uninstalling module:

* Deactivate the module if it is already active.
* Remove module configurations from shop configuration file and remove module classes from module chain.
   .. todo: #HR: what does the following todo mean?
   .. todo: (see below)

* Remove module source files

Then, composer will remove module from autoloader and rebuild the autoloader.

Uninstall module without composer
---------------------------------

To just uninstall the module without removing it via composer, use the following command:

.. code:: bash

    vendor/bin/oe-console oe:module:uninstall <module-id>

Unless a module is removed via composer, it still can be installed again via console.