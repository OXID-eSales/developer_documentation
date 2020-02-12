Uninstall
=========

You can easily uninstall module using composer and
`OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__ will do the following steps before composer uninstalling module:

* Deactivate the module if it is already active
* Remove module configurations from shop configuration file and remove module classes from module chain
* Remove module source files

then composer will remove module from autoloader and rebuild the autoloader.
