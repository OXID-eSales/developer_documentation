Standard update
===============

This document describes patches and minor updates of OXID eShop. Follow the steps below to update the compilation from
an existing version to a newer version.

.. note::
    Updates should always be installed in a test or development environment. Backup the shop files and the database
    before updating. :doc:`Disable all modules </development/modules_components_themes/module/deactivation/index>` and check whether the shop works in general. After updating, test the shop
    again, paying special attention to the ordering process as well as payment and shipping methods.

.. note::
   To execute commands via the command line, open a shell in the shop root directory and run commands in there.

.. |schritt| image:: ../media/icons/schritt.jpg
               :class: no-shadow

|schritt| Optional: Update Composer
-----------------------------------------------------
Please read the `Composer documentation <https://getcomposer.org/doc/03-cli.md#self-update-selfupdate>`_ for more information.

.. hint::

    The version of the composer must correspond to the supported one in the metapackage.

|schritt| Specifying the target version of the update
-----------------------------------------------------
In the :file:`composer.json` file, the version of the metapackage must be updated.

Example of an update for a Community Edition 7.0.0 to 7.1.0:

.. code:: bash

   composer require --no-update oxid-esales/oxideshop-metapackage-ce:v7.1.0

.. hint::

   The name of the metapackage must be adapted to the used shop edition.

|schritt| Updating dependencies
-------------------------------
Specify the :command:`--no-dev` parameter if the development-related files are not required.

.. code:: bash

   composer update --no-plugins --no-scripts --no-dev

|schritt| Obtaining new compilation
-----------------------------------
The following command executes all scripts to obtain the new compilation. For shop files, themes and modules, you will
need to confirm that the update will overwrite the existing files.

.. code:: bash

   composer update --no-dev

|schritt| Deleting cache files
----------------------------------

.. code:: bash

   rm -rf source/tmp/*

|schritt| Migrating database
-----------------------------

.. code:: bash

   ./vendor/bin/oe-eshop-db_migrate migrations:migrate

|schritt| Optional: Generating views
------------------------------------
Depending on changes and shop edition you might see the maintenance mode in the shop as long as the views are not
generated again.

.. code:: bash

   ./vendor/bin/oe-eshop-db_views_generate

.. hint::

   Usually required when updating an Enterprise Edition.

This completes the updating process.


.. Intern: oxbaix, Status:
