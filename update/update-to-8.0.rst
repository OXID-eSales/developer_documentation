Update to 8.0
=============

This document provides the steps to update your shop from version 7.x to the new version 8.0.

.. note::
    To avoid any issues during the update process, please back up your shop files and data.

.. note::
    To execute commands via the command line, open a shell in the shop root directory and run the commands from there.


Install the `oxideshop-update-component`
----------------------------------------

Many update tasks require the `oxideshop-update-component`. Install it using Composer:

.. code-block:: bash

    composer require oxid-esales/oxideshop-update-component:^v3.0.0


Update Twig Templates
---------------------

To update your Twig templates to meet the latest shop requirements, use the `oxideshop-update-component` installed earlier.

1. Run the migration command with the `target-templates-path` parameter. This specifies the path to the templates that need to be updated. Note that the default OXID templates are already updated.

   .. code-block:: bash

       php bin/oe-console oe:update:update-templates {target-templates-path}


Migrate Database Configurations to Container Parameters
-------------------------------------------------------

This section explains how to migrate database configurations to container parameters using the ``oxideshop-update-component``.

Prerequisites
^^^^^^^^^^^^^

- Ensure you have Composer installed.
- The OXID eShop environment must be set up and running.

Configuration Parameters to Migrate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following database configuration parameters will be migrated to their corresponding container parameters:

.. list-table::
   :header-rows: 1
   :widths: 50 50

   * - **Database Configuration Parameter**
     - **Container Parameter**
   * - ``blCacheActive``
     - ``oxid_esales.enable_data_cache``
   * - ``blUseContentCaching``
     - ``oxid_esales.enable_content_cache``

Running the Migration Command
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

After installing the component (see the "Install the `oxideshop-update-component`" section), you can run the migration command. The command includes an optional parameter, ``remove-old-configuration``, which determines whether the old configuration options should be deleted from the database after migration.

Command Syntax
^^^^^^^^^^^^^^

.. code-block:: bash

    php bin/oe-console oe:update:database-config {remove-old-configuration}

Parameters
^^^^^^^^^^

* ``remove-old-configuration`` (optional):

  - Accepts ``true`` or ``false``.
  - Default: ``false``.
  - If set to ``true``, the old configuration parameters will be deleted from the database after migration.

Examples
^^^^^^^^

1. Migrate configurations without deleting old parameters:

   .. code-block:: bash

       php bin/oe-console oe:update:database-config

2. Migrate configurations and delete old parameters:

   .. code-block:: bash

       php bin/oe-console oe:update:database-config true