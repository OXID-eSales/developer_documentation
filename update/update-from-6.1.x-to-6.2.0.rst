Update from 6.1.x to 6.2.0
==========================

This page describes how you can update from OXID eShop version 6.1.x to 6.2.0. If you want to update to any other
version, please switch to the appropriate version of the documentation.


Depending on your existing OXID eShop installation, you need to perform one or more of the following actions:

.. contents ::
    :local:
    :depth: 1

1. Composer update
------------------

#. Please edit your root :file:`composer.json` file by updating contents of `require` and `require-dev` nodes:

       .. code:: json

        {
            "require": {
                "oxid-esales/oxideshop-metapackage-ce": "v6.2.0"
            },
            "require-dev": {
                "oxid-esales/testing-library": "^v7.0.1",
                "incenteev/composer-parameter-handler": "^v2.0.0",
                "oxid-esales/oxideshop-ide-helper": "^v3.1.2",
                "oxid-esales/azure-theme": "^v1.4.2"
            },
        }

    `Example: updated values for OXID eShop CE v6.2.0`
    
    Adapt the metapackage according to your edition.


    .. note::
        New version of testing-library requires php-zip extension.
        You might need to install it to be able to update OXID eShop from oxvm_eshop.

#. Clean up the :file:`tmp` folder

   .. code:: bash

      rm -rf source/tmp/*

#. For updating dependencies (necessary to update all libraries), in the project folder run:

   .. code:: bash

      composer update --no-plugins --no-scripts

#. Copy the file :file:`overridablefunctions.php` from the :file:`vendor` directory to the OXID eShop :file:`source` directory:

   .. code:: bash

      cp vendor/oxid-esales/oxideshop-ce/source/overridablefunctions.php source/

#. For executing all necessary scripts to actually gather the new compilation, in the project folder run:

   .. code:: bash

      composer update #(You will be prompted whether to overwrite existing code for several components. The default value is N [no] but of course you should take care to reply with y [yes].)

   .. important::

      Composer will ask you to overwrite module and theme files. E.g.: "Update operation will overwrite oepaypal files in
      the directory source/modules. Do you want to overwrite them? (y/N)"
      If you include modules by ``"type": "path",`` in your :file:`composer.json` file like described in
      :doc:`Best practice module setup </development/modules_components_themes/module/tutorials/module_setup>`, answer ``No`` to this question..


#. For executing possible database migrations, in the project folder run:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate

2. Update of the module configurations
--------------------------------------

The outcome of the following steps is that you are able to configure, activate and deactivate your current modules again.
Therefore the :doc:`new module configuration .yaml </development/modules_components_themes/project/module_configuration/modules_configuration>` files need
to be synchronized with the configuration and
activation status of your current modules.
:doc:`Read here for background information </development/modules_components_themes/module/installation_setup/index>`.

1. Install the `update component <https://github.com/OXID-eSales/oxideshop-update-component>`__ via composer:

   .. code:: bash

       composer require --no-interaction oxid-esales/oxideshop-update-component:"^1.0"

2. Clean up the :file:`tmp` folder

   .. code:: bash

      rm -rf source/tmp/*

3. Install a default configuration for all modules which are currently inside the directory :file:`source/modules`.
   On the command line, execute the :doc:`console command </development/tell_me_about/console>`:

   .. code:: bash

      vendor/bin/oe-console oe:oxideshop-update-component:install-all-modules

4. Transfer the existing configuration (module setting values, class extension chain, which modules are active) from the
   database to the :file:`.yaml` configuration files.

   .. code:: bash

      vendor/bin/oe-console oe:oxideshop-update-component:transfer-module-data

5. Remove modules data which already presents the yaml files from the database to avoid duplications and errors
   during the module activation.

   .. code:: bash

      vendor/bin/oe-console oe:oxideshop-update-component:delete-module-data-from-database

   After this step, modules data should be removed from the database so modules functionality should not work anymore.

6. Activate all configured modules which were previously active .
   On the command line, execute the :doc:`console command </development/tell_me_about/console>`:

   .. code:: bash

      vendor/bin/oe-console oe:module:apply-configuration

   After this step, all modules which were previously active, should be active and have the correct configuration set.

7. Uninstall the `update component via composer <https://github.com/OXID-eSales/oxideshop-update-component>`__

3. Remove old files
-------------------

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
    :doc:`the metadata documentation of settings </development/modules_components_themes/module/skeleton/metadataphp/amodule/settings>`.

* **The extension chain in the OXID eShop admin in** :menuselection:`Extension -->  Modules --> Installed Shop Modules` **is
  partly highlighted red and crossed out.**

  * This must not be an error. Up to OXID eShop 6.1, only extensions of active modules were shown. OXID eShop 6.2 shows
    extensions of all installed modules (active and inactive). If a module is inactive, the extensions of this module
    are highlighted red and crossed out. This new behavior means, you can configure the extension chain of modules which
    are not activated yet.
