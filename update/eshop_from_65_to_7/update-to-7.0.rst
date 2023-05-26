Updating from OXID eShop 6.5 to OXID eShop 7.0
===============================================

Update your OXID eShop to OXID eShop version 7.


|prerequisites|

Before you update to OXID eShop version 7, you have make sure that you meet the technical requirements for the update:

* You have OXID eShop Version 6.5.

  To get to OXID eShop Version 6.5, you have performed the required incremental updates.

  For more information, see :ref:`update/eshop_from_65_to_7/update-to-6.5:Updating to OXID eShop 6.5`.

* If you use third-party modules or themes, you have ensured the compatibility of the third-party modules.

  To do so, you have asked the third-party vendor if these themes and modules are compatible with version 7 of OXID eShop.

  For updating existing modules from OXID eShop 6.5.x to OXID eShop 7, see :ref:`update/eshop_from_65_to_7/modules:Modules`.

|procedure|

0. .. important:: Make a backup of your database. Make a backup of your current shop installation (all files etc.). We recommend to test the update procedure on a copy/development installation
      of your shop first, in order to become familiar with the process.

   .. note:: To execute commands via commandline, please open a shell  in the shop root directory and run commands in there.

1. In the :file:`var/configuration` folder, make a backup of the :file:`shops` folder that contains a :file:`<shop-id>.yaml` file for each subshop.
   |br|
   If your OXID eShop has no subshops, there is only the :file:`var/configuration/shops/1.yaml` file to back up.
   Backup the folder/file to where it cannot be overwritten by the following update process.

#. Decode the values in the following data table columns:

   * table :code:`oxuserpayments`: column :code:`oxvalue`
   * table :code:`oxconfig`: column :code:`oxvarvalue`

   This can be done automatically as described in the following steps:

     .. important::
        **Make sure that you follow the order of the steps.**

        Background: After executing the :code:`decode-config-values` command, the shop and console will be down until it is fully updated to OXID 7.

     (1.) Install the `OXID eShop update component <https://github.com/OXID-eSales/oxideshop-update-component>`_.

          .. code:: bash

             composer require --no-interaction oxid-esales/oxideshop-update-component:^v2.0.0

     (2.) Clean the shop cache by calling the appropriate console command from shop root directory. Please keep in mind, that the path to console command will be :code:`./bin/oe-console` in case shop was installed with CE as root package, and :code:`./vendor/bin/oe-console` in case shop was installed from metapackage.

          .. code:: bash

            ./vendor/bin/oe-console oe:cache:clear

     |br|
     (2.) Execute the :code:`oe:oxideshop-update-component:decode-user-payment-values` command:

          .. code:: bash

            ./vendor/bin/oe-console oe:oxideshop-update-component:decode-user-payment-values

     |br|
     (3.) Execute the :code:`oe:oxideshop-update-component:decode-config-values` command:

          .. code:: bash

            ./vendor/bin/oe-console oe:oxideshop-update-component:decode-config-values

     |br|
     (4.) To uninstall the OXID eShop update component, execute the following command:

          .. code:: bash

            composer remove --update-no-dev --no-plugins --no-interaction oxid-esales/oxideshop-update-component

#. Delete the :file:`var/generated/generated_services.yaml` file.

#. In the :file:`composer.json` file, update the metapackage version depending on your current Edition of OXID eShop.
   In case of Enterprise Edition, please register PE and EE metapackage repositories via composer.
   In case of Professional Edition, only PE metapackage repository needs to be registered. For Community Edition,
   packagist will automatically handle the requirement.

   .. code:: bash

      composer config repositories.oxid-esales/oxideshop-metapackage-pe \
                --json '{"type":"git", "url":"https://github.com/OXID-eSales/oxideshop_metapackage_pe.git"}'

      composer config repositories.oxid-esales/oxideshop-metapackage-ee \
                --json '{"type":"git", "url":"https://github.com/OXID-eSales/oxideshop_metapackage_ee.git"}'

      composer config repositories.oxid-esales/oxideshop-demodata-pe \
                --json '{"type":"git", "url":"https://github.com/OXID-eSales/oxideshop_demodata_pe.git"}'

      composer config repositories.oxid-esales/oxideshop-demodata-ee \
                --json '{"type":"git", "url":"https://github.com/OXID-eSales/oxideshop_demodata_ee.git"}'


   .. code:: bash

      composer require --no-update oxid-esales/oxideshop-metapackage-<ce/pe/ee>:v7.0.0

   .. important:: Please remove or update the following packaged from require-devs section of your composer.json.
      Those packages as given in OXID eSHop 6.5 metapackages are not compatible with OXID eShop 7.

   .. code::

        "oxid-esales/testing-library": "^v8.2.0",
        "incenteev/composer-parameter-handler": "^v2.0.0",
        "oxid-esales/oxideshop-ide-helper": "^4.2.0",
        "oxid-esales/azure-theme": "^v1.4.2"

#. Update the dependencies.
   |br|
   Please run the composer command below to update all the required libraries.
   |br|
   Specify the :command:`--no-dev` parameter if you do not need the development-related files.

   .. code:: bash

      composer update --no-plugins --no-scripts --no-dev

   .. note:: This command will ensure all required libraries are updated by composer. The shop is not yet fully updated to OXID 7 at this point. For this we need to complete the next steps as well.

#. To fully install the new compilation for OXID eShop 7, composer now also needs to run the scripts and plugins.

   To do so, execute the command given below the following notes.

   .. note::

      The update overwrites any changes you may have made to themes in the :file:`source` directory.

      Background: During an update, Composer first loads the new data into the :file:`vendor` directory. Then the data is copied to the :file:`source` directory. This replaces the files of the store and the themes.

      Your individual customizations of the OXID eShop or changes to third-party modules are only safe from being overwritten by the update if you have made the changes through one of the OXID eShop’s extension options (component, module, child theme).

      For more information, see the developer documentation under

      * `Module skeleton: metadata, composer, and structure <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/module/skeleton/index.html>`_
      * `How to create a theme installable via composer? <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/theme/theme_via_composer.html>`_

   .. attention::

      **Confirming queries**.

      During the update you will be asked which packages may be overwritten.

      To ensure that only compatible and tested packages are installed and to avoid inconsistencies and malfunctions caused by incorrectly implemented modules or themes, you must confirm the queries with :technicalname:`Yes`.


      Recommendations:

      * If you use the extension capabilities of OXID eShop, follow the instructions in the `developer documentation <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/>`_.

   .. code:: bash

      composer update --no-dev

   .. important:: After this step, OXID eShop Compilation 7 and all modules delivered with the compilation will be installed but not yet activated.

#. Migrate the database.
   |br|
   To do so, execute the following command.

   .. code:: bash

      ./vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views.
   |br|
   Background: This is a safety precaution. After database changes like done in previous step by migrations, views need to be updated.
   Otherwise you risk the shop going into Maintenance Mode.
   |br|
   To prevent this, regenerate the database views with the following command:

   .. code:: bash

      ./vendor/bin/oe-eshop-db_views_generate

#. Doublecheck php error reporting settings. With OXID eShop 7 , error_reporting() calls have been removed from bootstrap.php.
   We recomment to set

   .. code:: bash

      error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE);
      ini_set('display_errors', '0');

#. To clean up your system, from the :file:`source/modules` folder, remove the subfolders containing the previously installed, now unused module files.
   |br|
   Do not delete the :file:`functions.php.dist` file.

#. To ensure that the cached items do not contain incompatibilities, clear the cache files in :file:`tmp` directory.
   |br|
   To do so, execute the following command.

   .. code:: bash

      ./vendor/bin/oe-console oe:cache:clear

#. The OXID eShop Compilation 7 comes with the Twig template engine and the APEX theme. PLease ensure that you theme is compatible with twig engine.
   In the Admin panel, under :menuselection:`Extensions --> Themes`, activate your Twig compatible theme (APEX Theme in default installation case).

#. If the shop doesn't work, update your code and modules according to the information under :ref:`update/eshop_from_65_to_7/modules:Adjust removed functionality`.


Module configuration and class chain
------------------------------------

.. important:: The structure of the :file:`./var` folder is different in OXID eShop 6.5 and 7. New structure example:

    .. code::

          .
          └── var
              └── configuration
                  └── shops
                     └──1
                        └──class_extension_chain.yaml
                        └──modules
                           └──oxps_usercentrics.yaml
                           └──oegdproptin.yaml


.. important:: Please keep in mind that in the current state of the Shop update only OXID eShop 7 compilation modules are installed.
   So now please install additionally needed compatible modules for OXID eShop 7 if necessary.

.. important:: The default class extension chains are depending on the order in which composer installed those modules. In case you need a customized order
   for class extensions, you can use you customized class chains from :file:`<shop-id>.yaml` file that you have backed up in step 1 as an example.

In case you would like to reuse modules settings from the :file:`<shop-id>.yaml` file that you have backed up in step 1, please refer to
:ref:`Configuring modules via providing configuration files<configuring_module_via_configuration_files-20190829>`.


