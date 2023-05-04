Upgrading from OXID eShop 6.5 to OXID eShop 7.0
===============================================

Upgrade your OXID eShop to OXID eShop version 7.


|prerequisites|

Before you upgrade to OXID eShop version 7, you have make sure that you meet the technical requirements for the update:

* You have OXID eShop Version 6.5.

  To get to OXID eShop Version 6.5, you have performed the required incremental updates.

  For more information, see :ref:`update/eshop_from_65_to_7/update-to-6.5:Updating to OXID eShop 6.5`.

* If you use third-party modules or themes, you have ensured the compatibility of the third-party modules.

  To do so, you have asked the third-party vendor if these themes and modules are compatible with version 7 of OXID eShop.

  For updating existing modules from OXID eShop 6.5.x to OXID eShop 7, see :ref:`update/eshop_from_65_to_7/modules:Modules`.

|procedure|

1. In the :file:`/source/var/configuration` folder, make a backup of the :file:`shops` folder that contains a :file:`<shop-id>.yaml` file for each subshop.
   |br|
   If you don't have subshops, there is only the :file:`source/var/configuration/shops/1.yaml` file to back up.
   |br|
   Store the folder/file where it cannot be overwritten by the following upgrade process.

#. Decode the values in the following data table columns:

   * table :code:`oxuserpayments`: column :code:`oxvalue`
   * table :code:`oxconfig`: column :code:`oxvarvalue`

   To do so, you have the following options:

   * Do it manually via an SQL query.
   * Recommended: Do it automatically as described in the following:

     .. important::
        In the following, make sure that you follow the order of the steps.

        Background: After executing the :code:`decode-config-values` command, the shop and console will be down.

     (1.) Install the `OXID eShop update component <https://github.com/OXID-eSales/oxideshop-update-component>`_.
     |br|
     (2.) Execute the :code:`oe:oxideshop-update-component:decode-user-payment-values` command.
     |br|
     (3.) Execute the :code:`oe:oxideshop-update-component:decode-config-values` command.
     |br|
     (4.) To uninstall the OXID eShop update component, execute the following command:

        .. code:: bash

           composer remove --update-no-dev oxid-esales/oxideshop-update-component

#. Delete the :file:`source/var/generated/generated_services.yaml` file.

#. In the :file:`composer.json` file, update the metapackage version.

   .. code:: bash

      composer require --no-update oxid-esales/oxideshop-metapackage-ce:v7.0.0

#. Update the dependencies.
   |br|
   To do so, in the main store directory, open a shell and run the composer command below.
   |br|
   This will update all the required libraries.
   |br|
   Specify the :command:`--no-dev` parameter if you do not need the development-related files.

   .. code:: bash

      composer update --no-plugins --no-scripts --no-dev

#. To get the new compilation and run the update, run the scripts.
   |br|
   To do so, run the following command.
   |br|

   .. note::

      The upgrade overwrites any changes you may have made to themes in the :file:`source` directory.

      Background: During a store upgrade, Composer first loads the new data into the :file:`vendor` directory. Then the data is copied to the :file:`source` directory. This replaces the files of the store and the themes.

      Your individual customizations of the OXID store or changes to third-party modules are only safe from being overwritten by the update if you have made the changes through one of the OXID eShop's extension options (component, module, child theme).

      For more information, see the developer documentation under

      * `Module skeleton: metadata, composer, and structure <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/module/skeleton/index.html>`_
      * `How to create a theme installable via composer? <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/theme/theme_via_composer.html>`_


   .. attention::

      **Confirming queries**.

      During the upgrade you will be asked which packages may be overwritten.

      To ensure that only compatible and tested packages are installed and to avoid inconsistencies and malfunctions caused by incorrectly implemented modules or themes, you must confirm the queries with :technicalname:`Yes`.


      Recommendations:

      * If you use the extension capabilities of OXID eShop, follow the instructions in the `developer documentation <https://docs.oxid-esales.com/developer/en/latest/>`_.
      * To create modules or child themes, get support from an OXID partner agency. This will make any future updates easier for you.
        |br|
        For a list of OXID certified partner agencies, visit `oxid-esales.com/partner/partner-find/ <https://www.oxid-esales.com/partner/partner-finden/>`_.

   .. code:: bash

      composer update --no-dev

#. Adjust the module configuration files. To do so, for each subshop do the following:

   a. Open the project configuration ``yaml``-files located in the project directory ``var/shops/<shop-id>/`` where ``<shop-id`` stands for the subshop ID.
      |br|
      If you don't use the subshop functionality, there is only one directory.

      Example:

      .. code::

          .
          └── var
              └── configuration
                  └── shops
                     └──1
                              └──class_extension_chain.yaml
                              └──modules
                                └──oepaypal.yaml
                                └──oegdproptin.yaml

   b. Open the corresponding :file:`<shop-id>.yaml` file that you have backed up in step 1.
   c. From the :file:`<shop-id>.yaml` file, copy and paste the content below :code:`moduleChains:classExtensions` (:ref:`upgrade7001`) into the :file:`class_extension_chain.yaml` file.

      .. _upgrade7001:

      .. figure:: ../../media/screenshots/upgrade7001.png
         :alt: Copying the moduleChains:classExtensions content
         :width: 650
         :class: with-shadow

         Fig.: Copying the moduleChains:classExtensions content

      In the :file:`class_extension_chain.yaml` file, make sure the lines are indented correctly (:ref:`upgrade7002`).

      .. _upgrade7002:

      .. figure:: ../../media/screenshots/upgrade7002.png
         :alt: Indenting the pasted moduleChains:classExtensions content
         :width: 650
         :class: with-shadow

         Fig.: Indenting the pasted moduleChains:classExtensions content

   d. For each module (GDPR Opt-in, in our following example), do the following:

      1. From the :file:`<shop-id>.yaml` file, copy the :code:`moduleSettings` block (:ref:`upgrade7003`, item 2) and replace the corresponding block in the corresponding :file:`source/var/configuration/shops/<shop-ID>/modules/<module name>.yaml` module configuration file (:file:`oegdproptin.yaml`, in our example).

         .. _upgrade7003:

         .. figure:: ../../media/screenshots/upgrade7003.png
            :alt: Copying the moduleSettings block
            :width: 650
            :class: with-shadow

            Fig.: Copying the moduleSettings block

      In the :file:`<module name>.yaml` file, make sure the lines are indented correctly (:ref:`upgrade7004`, item 2).

         .. _upgrade7004:

         .. figure:: ../../media/screenshots/upgrade7004.png
            :alt: Adjusting the module configuration file
            :width: 650
            :class: with-shadow

            Fig.: Adjusting the module configuration file

      b. Verify the activation status.
         |br|
         If the :code:`configured` parameter value in the :file:`<shop-id>.yaml` file  is :code:`true`/:code:`false` (:ref:`upgrade7003`, item 1), ensure that the :code:`configured` parameter value in the :file:`<module name>.yaml` file is set to :code:`true`/:code:`false` correspondingly (:ref:`upgrade7004`, item 1).

#. Migrate the database.
   |br|
   To do so, execute the following command.

   .. code:: bash

      vendor/bin/oe-shop-db_migrate migrations:migrate

#. Regenerate the database views.
   |br|
   Background: Depending on the changes and store edition, the store may go into maintenance mode after the update.
   |br|
   To prevent this, regenerate the database views with the following command:

   .. code:: bash

      vendor/bin/oe-eshop-db_views_generate

#. To clean up your system, from the :file:`source/modules` folder, remove the subfolders containing the previously installed, now unused module files.
   |br|
   Do not delete the :file:`functions.php.dist` file.

#. To ensure that the cached items do not contain incompatibilities, empty the :file:`tmp` directory.
   |br|
   To do so, execute the following command.

   .. code:: bash

      rm -rf source/tmp/*

#. If the shop doesn't work, update your code and modules according to the information under :ref:`update/eshop_from_65_to_7/modules:Adjust removed functionality`.

#. Optional (not recommended): To use the Smarty template engine, do the following:

   a. Uninstall Twig.
      |br|
      To do so, remove the following components in the following order:

      * :technicalname:`apex-theme`
      * :technicalname:`twig-admin-theme`

      * depending on your OXID eShop installation:

        * :technicalname:`twig-component`
        * :technicalname:`twig-component-pe`
        * :technicalname:`twig-component-ee`

   b. Install Smarty.
      |br|
      To do so, install the following components in the following order:

      * depending on your OXID eShop installation:
         * :technicalname:`smarty-component-ee`
         * :technicalname:`smarty-component-pe`
         * :technicalname:`smarty-component`
      * :technicalname:`smarty-admin-theme`
      * a smarty-compatible theme, the :technicalname:`wave-theme`, for example

