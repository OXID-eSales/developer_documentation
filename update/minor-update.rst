Installing a minor update
=========================

Update the compilation from an existing version 7.1.x to version 7.2.x.

.. include:: /_static/reuse/note_dataloss.rst

Ensuring the compatibility of third-party modules
-------------------------------------------------

If you use third-party modules or themes, ask the third-party vendor if these themes and modules are compatible with the new version of OXID eShop.

Background: Typically, a minor update does not contain any breaking changes. All third-party modules will work as before after the update.

However, in exceptional cases, changes can have such an impact that third-party modules no longer work.

Performing the update
---------------------

Update your OXID eShop to the latest version.

|prerequisites|

You have :productname:`OXID eShop` 7.1.x.

|procedure|

1. Deactivate all modules.
#. Update Composer to version 2.7.

   Install Composer 2.7 as follows, for example:

   .. code:: bash

      composer selfupdate 2.7.1

#. Update the metapackage version in the :file:`composer.json` file.
   |br|
   To do this, match the name of the metapackage to the desired store edition, as in the following example.
   |br|
   Example for an update of a community edition with the metapackage name ``7.2.0``:

   .. code:: bash

      composer require --no-update oxid-esales/oxideshop-metapackage-ce:v7.2.0

#. Update the dependencies.
   |br|
   Open a shell in the main store directory and run the composer command below.
   |br|
   This will update all the required libraries.
   |br|
   If you need the development-related files, omit the :command:`--no-dev` parameter.

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
        However, in exceptional cases, changes can have an impact such that third-party modules no longer work.

   .. code:: bash

      composer update --no-dev

#. To ensure that the cached items do not contain incompatibilities, empty the :file:`tmp` directory.
   |br|
   To do this, run the following command.

   .. code:: bash

      rm -rf source/tmp/*

#. Migrate the database.
   |br|
   To do so, run the following command.

   .. code:: bash

      ./vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views.
   |br|
   Background: Depending on the changes and store edition, the store may go into maintenance mode after the update.
   |br|
   To prevent this, regenerate the database views with the following command:

   .. code:: bash

      ./vendor/bin/oe-eshop-db_views_generate

#. Activate all modules.

.. Intern: oxbajz, Status: