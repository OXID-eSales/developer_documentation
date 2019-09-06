Update from 6.1.x to 6.2.0
==========================

Default update via composer
---------------------------

Execute :doc:`the default update for a minor version <update_default>` first.

Update of the module configurations
-----------------------------------

The outcome of the following steps is that you are able to configure, activate and deactivate your current modules again.
Therefor the :doc:`new module configuration .yml </project/modules_configuration_setup>` files need to be synchronized with the configuration and
activation status of your current modules. :doc:`Read here for background information. </modules/installation_setup/index>`.

1. Install `the update component via composer <https://github.com/OXID-eSales/oxideshop-update-component#installation>`__

2. Install a default configuration for all modules which are currently inside the directory :file:`source/modules`.
   On the command line, execute the :doc:`console command </modules/console>`:

   .. code:: bash

      oe-console oe:oxideshop-update-component:install-all-modules

   After this step you can visit :menuselection:`Extension -->  Modules` and make sure, all modules
   which were previously installed, are listed. Also those modules should be found in the new module configuration
   :file:`.yml` files.

3. Transfer the existing configuration (module setting values, class extension chain, which modules are active) from the
   database to the :file:`.yml` configuration files.

   .. code:: bash

      oe-console oe:oxideshop-update-component:transfer-module-data

   After this step, all modules which were previously active, should have set the option `configured` to `true` in the
   :file:`.yml` configuration files. Also settings you have done previously to your modules, should be visible in the
   OXID eShop admin and the :file:`.yml` configuration files.

4. Remove modules data which already presents the yml files from the database to avoid duplications and errors
   during the module activation.

   .. code:: bash

      oe-console oe:oxideshop-update-component:delete-module-data-from-database

   After this step modules data should be removed from the database, modules functionality should not work anymore
   and all modules should have not active state.

5. Activate all configured modules which were previously active .
   On the command line, execute the :doc:`console command </modules/console>`:

   .. code:: bash

      oe-console oe:module:activate-configured-modules

   After this step, all modules which were previously active, should be active and have the correct configuration set.

6. Uninstall the `update component via composer <https://github.com/OXID-eSales/oxideshop-update-component>`__
