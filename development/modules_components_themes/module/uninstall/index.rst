Uninstall
=========

Uninstall module
---------------------------------

To uninstall a module without removing the files from the vendor directory, use the following command:

.. code:: bash

    ./vendor/bin/oe-console oe:module:uninstall <module-id>

Unless a module is removed via Composer, it can be installed via :doc:`oe-console </development/tell_me_about/console>` again.

Remove module
---------------------------

.. code:: bash

    composer remove vendor/package

By executing the Composer command to remove a package, the
`OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__ does a couple of steps to
remove module information, if the package is of type :ref:`oxideshop-module <module_type-20160524>`:

* Deactivate the module if it is active.
* Remove module configurations from shop configuration files.
* Remove module classes from module chain.
* Clear the cache.
* Rebuild the :ref:`Service Container <service_container_01>`.

After that, Composer will remove the module from the vendor directory and its autoloader.
