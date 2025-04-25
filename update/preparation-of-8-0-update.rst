Preparation of 8.0 update
=========================

This document provides the steps to update your shop from version 7.x to the new version 8.0.

.. note::
    Before starting the update process, consider :doc:`modernizing your modules <module-modernization>` for better
    compatibility with OXID eShop 8.0.

.. note::
    To avoid any issues during the update process, please back up your shop files and data.

.. note::
    The ``config.inc.php`` file was removed; here is the list of configuration parameters:
    :ref:`See details <configIncParamsChanges>`

Prerequisites
-------------

You will need a (local development) installation of OXID eShop 8.0-alpha.1. Please refer to your
OXID eShop Docker SDK resp. our SDK recipes.

Ensure you have installed the :doc:`OXID Update Component <update-component>` into your OXID eShop 8.0-alpha.1.

Update Configuration Files
--------------------------

The configuration system has been updated in OXID eShop 8. You need to migrate any existing 7.x configuration
from `config.inc.php` to the new `.env` and `parameters.yaml` files.
In order to achieve this, please copy any config.in.php you'd like to convert into your 8.0-alpha.1 development
installation's source path. Then run below listed command:

.. code:: bash

    vendor/bin/oe-console oe:update:config-file

This command will:

* Convert your existing configuration to the new format
* Create/update the `.env` file with environment-specific settings
* Create/update `var/configuration/shops/parameters.yaml` with shop parameters
* Preserve your existing configuration values

.. note::
    After verifying that the migration was successful, you can remove the `config.inc.php` file.
    PLease verify that you do not have parameter duplications in .env.

Migrate dynamic configurations
------------------------------

The following configuration parameters will be migrated from the database to their corresponding container parameters.
In order to do so, you need to update your alpha.1 installation's database table `oxconfig` with the actual 7.x data you need to convert.

.. list-table::
    :header-rows: 1
    :width: 100%
    :widths: 50 50

    * - Dynamic Configuration
      - Container Parameter
    * - ``blCacheActive``
      - ``oxid_esales.enable_data_cache``
    * - ``blUseContentCaching``
      - ``oxid_esales.enable_content_cache``

Command Syntax:

.. code-block:: bash

    vendor/bin/oe-console oe:update:config-database {remove-old-configuration}

Parameters:

* `remove-old-configuration` (optional):
  - Accepts ``true`` or ``false``
  - Default: ``false``
  - If set to ``true``, the old configuration parameters will be deleted from the database

Example:

.. code-block:: bash

    vendor/bin/oe-console oe:update:config-database true

Update Twig Templates
---------------------

To update your Twig templates to meet the latest shop requirements, run:

.. code:: bash

    vendor/bin/oe-console oe:update:update-templates {target-templates-path}

The parameter `target-templates-path` specifies the path to the templates that need to be updated.
Note that the default OXID templates are already updated.

.. todo: #HR Add information what is migrated in templates

Update Module Code
------------------

This command updates specific aspects of your module code to be compatible with OXID eShop 8:

.. code:: bash

    vendor/bin/oe-console oe:update:update-module {module-path} [options]

Available options:

* ``-c, --config``: Update configuration parameter calls to new format
* ``-f, --facts``: Update Facts and Edition related code
* ``-t, --transaction``: Update database transaction handling code to use new connection factory

Example:

.. code:: bash

    vendor/bin/oe-console oe:update:update-module source/modules/mymodule -c -f

.. note::
    It's recommended to run all update commands on a test system first and thoroughly test the results
    before applying them to your production environment.
