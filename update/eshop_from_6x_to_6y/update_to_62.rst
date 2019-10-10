Update from 6.1.x to 6.2.0
==========================

Depending on your existing OXID eShop installation, you need to perform one or more of the following actions:

.. contents ::
    :local:
    :depth: 1

Composer update
---------------

#. Please edit the `oxid-esales/oxideshop-metapackage` version requirement in your root :file:`composer.json` file:

   .. code:: bash

        "oxid-esales/oxideshop-metapackage-ce": "v6.2.0",

   Other editions like OXID eShop Enterprise Edition accordingly.

#. For updating dependencies (necessary to update all libraries), in the project folder run:

   .. code:: bash

      composer update --no-plugins --no-scripts

#. Copy the file :file:`overridablefunctions.php` from the :file:`vendor` directory to the OXID eShop :file:`source` directory:

   .. code:: bash

      cp vendor/oxid-esales/oxideshop-ce/source/overridablefunctions.php source/

#. For executing all necessary scripts to actually gather the new compilation, in the project folder run:

   .. code:: bash

      composer update #(You will be prompted wether to overwrite existing code for several components. The default value is N [no] but of course you should take care to reply with y [yes].)

#. For executing possible database migrations, in the project folder run:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate

Change in database connection making and queries building
---------------------------------------------------------

Following Classes have been deprecated:
   .. code:: bash

    OxidEsales\EshopCommunity\Core\DatabaseProvider
    OxidEsales\EshopCommunity\Core\Database\Adapter\Doctrine\Database
    OxidEsales\EshopCommunity\Core\Database\Adapter\Doctrine\ResultSet
    OxidEsales\EshopCommunity\Core\Database\Adapter\DatabaseInterface
    OxidEsales\EshopCommunity\Core\Database\Adapter\ResultSetInterface

So ``getDb`` method has been deprecated and ``QueryBuilderFactory`` has been provided as a new way to make database connection and build queries.

QueryBuilderFactoryInterface namespace:
   .. code:: bash

      OxidEsales\EshopCommunity\Internal\Framework\Database\QueryBuilderFactoryInterface

For more details, see :doc:`making a query </modules/using_database>` document

Update of the module configurations
-----------------------------------

The outcome of the following steps is that you are able to configure, activate and deactivate your current modules again.
Therefor the :doc:`new module configuration .yml </project/module_configuration/modules_configuration>` files need
to be synchronized with the configuration and
activation status of your current modules.
:doc:`Read here for background information </modules/installation_setup/index>`.

1. Install the `update component via composer <https://github.com/OXID-eSales/oxideshop-update-component#installation>`__

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

Remove old files
----------------

There is a list of files that are not used anymore by OXID eShop, and those files can be removed manually. If you are not using them, its recommended to remove listed files.

* source/xd_receiver.htm

Troubleshooting
---------------

* **Error message: `Module directory of ModuleX could not be installed due to The variable $sMetadataVersion must be
  present in ModuleX/metadata.php and it must be a scalar.`**

  * Up to OXID eShop 6.1, modules without a metadata version in the file :file:`metadata.php` were accepted.
    OXID eShop 6.2 requires to set a
    :ref:`metadata version <modules_skeleton_metadata_v21_structure>` in ModuleX :file:`metadata.php`.

* **Error message `The metadata key constrains is not supported in metadata version 2.0.`**

  * Up to OXID eShop 6.1, the array keys `constraints` and `constrains` were accepted in the file :file:`metadata.php`.
    OXID eShop 6.2 only allows the key `constraints`. Please refer to
    :doc:`the metadata documentation of settings </modules/skeleton/metadataphp/amodule/settings>`.

* **The extension chain in the OXID eShop admin in :menuselection:`Extension -->  Modules --> Installed Shop Modules` is
  partly highlighted red and crossed out.**

  * This must not be an error. Up to OXID eShop 6.1, only extensions of active modules were shown. OXID eShop 6.2 shows
    extensions of all installed modules (active and inactive). If a module is inactive, the extensions of this module
    are highlighted red and crossed out. This new behavior means, you can configure the extension chain of modules which
    are not activated yet.
