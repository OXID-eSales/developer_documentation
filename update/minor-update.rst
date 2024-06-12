:orphan:

Installing a minor update
=========================

For example, update the compilation from an existing version 6.3.x to version 6.5.4.

.. include:: /_static/reuse/note_dataloss.rst

Ensuring the compatibility of third-party modules
-------------------------------------------------

If you use third-party modules or themes, ask the third-party vendor if these themes and modules are compatible with the new version of OXID eShop.

Background: Typically, a minor update does not contain any breaking changes. All third-party modules will work as before after the update.

However, in exceptional cases, changes can have such an impact that third-party modules no longer work.

Ensuring the prerequisites
--------------------------

Before you can perform a minor update to the desired target version of OXID eShop, ensure that you meet the technical prerequisites for the update.

To do this, check the following:

* Do I need to perform one or more incremental updates?
  |br|
  Incremental update means: You do not perform an update directly to the target version, but in a previous step you perform an update to a version between your source version and your target version.
  |br|
  Only in a following update you perform the update from the intermediate version to the target version.
* In the update or incremental update, do I have a version of :emphasis:`Composer` that supports both my respective source and target versions?
* When updating or incrementally updating, do I have a version of :emphasis:`PHP` that supports both my respective source and target versions?

|procedure|

Check step by step which incremental update you need to perform to finally get to the target version of OXID eShop.

Before each update step, make sure that you have versions of Composer and PHP that are supported by both the source and the target versions.


1. if you have OXID eShop version 5.x or lower, follow the instructions at `docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html <https://docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html>`_.
   |br|
   Alternatively: Install the latest version of OXID eShop and port only the important data.

   .. note::

      **Porting modules**

      Your modules do not work under OXID eShop version 6 anymore.

      To learn how to port your modules to OXID eShop version 6, visit https://docs.oxid-esales.com/developer/en/6.0/modules/tutorials/porting_tool.html.

   .. note::

      **Azure theme obsolete**.

      The Azure theme is still supported in OXID eShop version 6, but is no longer maintained.

#. If you have OXID eShop version :emphasis:`6.0.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.0.
   #. Perform an initial update from version 6.0.x to version 6.1.x.
      |br|
      For more information, see https://docs.oxid-esales.com/eshop/en/6.1/installation/installing-updates/installing-updates.html

#. If you have OXID eShop version :emphasis:`6.1.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.1.
   #. Update from version 6.1.x to version 6.2.4.
      |br|
      For more information, see https://docs.oxid-esales.com/eshop/en/6.2/installation/update/update-from-6.1.x-to-6.2.0.html

#. If you have OXID eShop version :emphasis:`6.2.0`, :emphasis:`6.2.1` or :emphasis:`6.2.2`, do the following:

   a. Perform a patch update to OXID eShop version :emphasis:`6.2.4`.
   #. Optional: Perform an update to from PHP version 7.1 to version 7.4.
      |br|
      Alternatively: Perform the update to PHP version 7.4 on the following OXID eShop updates.
   #. Perform an update from Composer version 1 to Composer version 2.

#. If you have OXID eShop version :emphasis:`6.2.3` or :emphasis:`6.2.4`, do the following:

   a. Make sure you have Composer version to 2.2.23

      Install Composer version 2.2.23 as follows:

      .. code:: bash

            composer selfupdate 2.2.23

   #. Make sure you have PHP version 7.4.
   #. Without any further intermediate steps, perform the update to the desired target version.

#. If you have OXID eShop version 6.2.5 or higher, perform the update to the current version directly as described below in :ref:`update/minor-update:Performing the update`.

.. todo: #VL: dito 6.2.5 required for update to 7.0? 7.0 requires PHP 8.0; or update only from 6.5 to 7.0?

Performing the update
---------------------

Update your OXID eShop to the latest version.

|prerequisites|

You have performed the necessary incremental updates (see :ref:`update/minor-update:Ensuring the prerequisites`).

|procedure|

1. Update Composer to version 2.7.

   Install Composer 2.7 as follows, for example:

   .. code:: bash

      composer selfupdate 2.7.1

#. Update the metapackage version in the :file:`composer.json` file.
   |br|
   To do this, match the name of the metapackage to the desired store edition, as in the following example.
   |br|
   Example for an update of a community edition with the metapackage name ``6.4.4``:

   .. code:: bash

      composer require --no-update oxid-esales/oxideshop-metapackage-ce:v6.4.4

#. Update the dependencies.
   |br|
   Open a shell in the main store directory and run the composer command below.
   |br|
   This will update all the required libraries.
   |br|
   Specify the :command:`--no-dev` parameter if you don't need the development related files.

   .. code:: bash

      composer update --no-plugins --no-scripts --no-dev

#. To get the new compilation and perform the update, run the scripts.
   |br|
   To do this, run the following command.
   |br|

   .. note::

      The update will overwrite any changes you may have made to modules or themes in the :file:`source` directory.

      Background: During a store update, Composer first loads the new data into the :file:`vendor` directory. Then the data is copied to the :file:`source` directory. This replaces the files of the store, the modules and the themes.

      Your individual customizations of the OXID store or changes to third-party modules are only safe from being overwritten by the update if you have made the changes through one of the OXID eShop's extension options (component, module, child theme).

      For more information, see the developer documentation under

      * `Module skeleton: metadata, composer, and structure <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/module/skeleton/index.html>`_
      * `How to create a theme installable via composer? <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/theme/theme_via_composer.html>`_

   .. attention::

      **Confirming queries**

      During the update you will be asked which packages may be overwritten.

      To ensure that only compatible and tested packages are installed and to avoid inconsistencies and malfunctions caused by incorrectly implemented modules or themes, you have to confirm the queries with :technicalname:`Yes`.


      Recommendations:

      * If you use the extension capabilities of OXID eShop, follow the instructions in the `developer documentation <https://docs.oxid-esales.com/developer/en/latest/>`_.
      * To create modules or child themes, get support from an OXID partner agency. This will make any future updates easier for you.
        |br|
        For a list of OXID certified partner agencies, visit `oxid-esales.com/partner/partner-find/ <https://www.oxid-esales.com/partner/partner-finden/>`_.
      * If you use third-party modules or themes, ask the third-party provider if these themes and modules are compatible with the new version of OXID eShop.
        |br|
        Background: Normally a minor update does not contain any breaking changes. All third-party modules will work as before after the update.
        |br|
        However, in exceptional cases (for example, when updating from OXID eShop 6.1 to 6.2), changes can have an impact such that third-party modules no longer work.

   .. code:: bash

      composer update --no-dev

#. To ensure that the cached items do not contain incompatibilities, empty the :file:`tmp` directory.
   |br|
   To do this, run the following command.

   .. code:: bash

      rm -rf source/tmp/*

#. Migrate the database.
   |br|
   To do this, run the following command.

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views.
   |br|
   Background: Depending on the changes and store edition, the store may go into maintenance mode after the update.
   |br|
   To prevent this, regenerate the database views with the following command:

   .. code:: bash

      vendor/bin/oe-eshop-db_views_generate

.. Intern: oxbajz, Status:
