Upgrade to OXID eShop 7.0
=========================

If you have OXID eShop 6.3 or higher, to upgrade to OXID eShop v. 7.0, perform the following instructions.

|prerequisites|

* You have OXID eShop 6.3 or higher.


Ensuring the compatibility of third-party modules
-------------------------------------------------

If you use third-party modules or themes, ask the third-party vendor if these themes and modules are compatible with version 7 of OXID eShop.

Ensuring the prerequisites
--------------------------

Before you upgrade to OXID eShop version 7, make sure that you meet the technical requirements for the update.

To do so, check the following:

* Do I need to do one or more incremental updates?
  |br|
  Incremental update means: you do not make an update directly to OXID eShop version 7 but in a previous step you make an update to a version between your initial version and OXID eShop version 7.
  |br|
  Only in a following update you do the update from the intermediate version to OXID eShop version 7.
* During the update or incremental update, do I have a version of :emphasis:`Composer` that supports both my respective source and target versions?
* When updating or incrementally updating, do I have a version of :emphasis:`PHP` that supports both my respective source and target versions?

|procedure|

Check step by step which incremental update you need to do to finally get to OXID eShop version 7.

In doing so, before each update step, make sure that you have versions of Composer and PHP that are supported by both the source and target versions.

1. If you have OXID eShop version 5.x or lower, follow the instructions at `docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html <https://docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html>`_.
   |br|
   Alternatively: install the latest version of OXID eShop and port only the important data.

   .. note::

      **Porting the modules**

      Your modules do not work under OXID eShop version 6 anymore.

      To learn how to port your modules to OXID eShop version 6, see https://docs.oxid-esales.com/developer/en/6.0/modules/tutorials/porting_tool.html.

   .. note::

      **Azure theme obsolete**

      The Azure theme is still supported in OXID eShop version 6, but is no longer maintained.

#. If you have OXID eShop version :emphasis:`6.0.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.0.
   #. Do an initial update from version 6.0.x to version 6.1.x.
      |br|
      For more information, visit https://docs.oxid-esales.com/eshop/de/6.1/installation/update-installation/update-installation.html

#. If you have OXID eShop version :emphasis:`6.1.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.1.
   #. Update from version 6.1.x to version 6.2.4.
      |br|
      For more information, please visit https://docs.oxid-esales.com/eshop/de/6.2/installation/update/von-6.1.x-auf-6.2.0-aktualisieren.html

#. If you have OXID eShop version :emphasis:`6.2.0`, :emphasis:`6.2.1` or :emphasis:`6.2.2`, do the following:

   a. Make a patch update to OXID eShop version :emphasis:`6.2.4`.
   #. Optional: Make an update to from PHP version 7.1 to version 7.4.
      |br|
      Alternatively: Make the update to PHP version 7.4 on the following OXID eShop updates.
   #. Make an update from Composer version 1 to Composer version 2.

#. If you have OXID eShop version :emphasis:`6.2.3` or :emphasis:`6.2.4`, do the following:

   a. Make sure you have Composer version 2.0 to 2.2.x.

      .. attention::

         Composer version 2.3.x is not supported.

         For example, if you have Composer version 2.3.x, install Composer version 2.2.x as follows:

         .. code:: bash

            composer selfupdate 2.2.12

   #. Make sure you have PHP version 7.4.
   #. Update from version 6.2.5 to version 6.5.

      .. code:: bash

         composer require --no-update oxid-esales/oxideshop-metapackage-ce:v6.5.2

         composer update --no-plugins --no-scripts --no-dev

#. If you have OXID eShop version 6.2.5 or higher, update to version 6.5:

   a. Make sure you have Composer version 2.4.
   #. Make sure you have PHP version 8.0.
   #. Update to version 6.5:

      .. code:: bash

         composer require --no-update oxid-esales/oxideshop-metapackage-ce:v6.5.2

         composer update --no-plugins --no-scripts --no-dev


Executing the upgrade
---------------------

Upgrade your OXID eShop to OXID eShop version 7.

|prerequisites|

* You have Oxid eShop Version 6.5.

  To get to Oxid eShop Version 6.5, you have performed the necessary incremental updates (see :ref:`update/upgrade-to-7.0:Ensuring the prerequisites`).


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

      .. figure:: ../media/screenshots/upgrade7001.png
         :alt: Copying the moduleChains:classExtensions content
         :width: 650
         :class: with-shadow

         Fig.: Copying the moduleChains:classExtensions content

      In the :file:`class_extension_chain.yaml` file, make sure the lines are indented correctly (:ref:`upgrade7002`).

      .. _upgrade7002:

      .. figure:: ../media/screenshots/upgrade7002.png
         :alt: Indenting the pasted moduleChains:classExtensions content
         :width: 650
         :class: with-shadow

         Fig.: Indenting the pasted moduleChains:classExtensions content

   d. For each module (GDPR Opt-in, in our following example), do the following:

      1. From the :file:`<shop-id>.yaml` file, copy the :code:`moduleSettings` block (:ref:`upgrade7003`, item 2) and replace the corresponding block in the corresponding :file:`source/var/configuration/shops/<shop-ID>/modules/<module name>.yaml` module configuration file (:file:`oegdproptin.yaml`, in our example).

         .. _upgrade7003:

         .. figure:: ../media/screenshots/upgrade7003.png
            :alt: Copying the moduleSettings block
            :width: 650
            :class: with-shadow

            Fig.: Copying the moduleSettings block

      In the :file:`<module name>.yaml` file, make sure the lines are indented correctly (:ref:`upgrade7004`, item 2).

         .. _upgrade7004:

         .. figure:: ../media/screenshots/upgrade7004.png
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

#. Optional: To use the Smarty template engine, do the following:

   a. Uninstall Twig.
   b. Install the following components:

      * :technicalname:`smarty-component`
      * :technicalname:`smarty-admin-theme`
      * Depending on your installation: :technicalname:`smarty-component-pe`
      * Depending on your installation: :technicalname:`smarty-component-ee`
      * a smarty-compatible theme, :technicalname:`flow_theme` or :technicalname:`wave-theme`, for example

