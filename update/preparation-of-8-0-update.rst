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

.. note::
    Modules in OXID eShop are heavily reliant on the `Facts` component being removed in version 8.0.
    To ensure backward compatibility and ease the transition process, `BC-Facts` has been introduced.
    It provides a temporary replacement for the `Facts` component, allowing modules to continue working during the update. Note that `BC-Facts` will depend on the Community Edition (CE).

Prerequisites
-------------

Ensure you have installed the :doc:`OXID Update Component <update-component>`.

Update Configuration Files
--------------------------

The configuration system has been updated in OXID eShop 8. You need to migrate your existing configuration
from `config.inc.php` to the new `.env` and `parameters.yaml` files:

.. code:: bash

    bin/oe-console oe:update:migrate-config-file

This command will:

* Convert your existing configuration to the new format
* Create/update the `.env` file with environment-specific settings
* Create/update `var/configuration/shops/parameters.yaml` with shop parameters
* Preserve your existing configuration values

.. note::
    After verifying that the migration was successful, you can remove the `config.inc.php` file.

Migrate dynamic configurations
------------------------------

The following configuration parameters will be migrated from the database to their corresponding container parameters:

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

    bin/oe-console oe:update:migrate-config-database {remove-old-configuration}

Parameters:

* `remove-old-configuration` (optional):

  - Accepts ``true`` or ``false``

  - Default: ``false``

  - If set to ``true``, the old configuration parameters will be deleted from the database

Example:

.. code-block:: bash

    bin/oe-console oe:update:migrate-config-database true

Update Twig Templates
---------------------

To update your Twig templates to meet the latest shop requirements, run:

.. code:: bash

    bin/oe-console oe:update:migrate-template-filters {target-templates-path}

The parameter `target-templates-path` specifies the path to the templates that need to be updated.
Note that the default OXID templates are already updated.

Update Module Code
------------------

This command updates specific aspects of your module code to be compatible with OXID eShop 8:

.. code:: bash

    bin/oe-console oe:update:upgrade-module {module-path} [options]

Available options:

* ``-c, --config``: Update configuration parameter calls to new format
* ``-f, --facts``: Update Facts and Edition related code
* ``-t, --transaction``: Update database transaction handling code to use new connection factory
* ``-d, --database``: Update database access code to new Doctrine DBAL standards

Example:

.. code:: bash

    bin/oe-console oe:update:upgrade-module source/modules/mymodule -c -f

.. note::
    It's recommended to run all update commands on a test system first and thoroughly test the results
    before applying them to your production environment.
