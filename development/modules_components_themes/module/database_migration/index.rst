.. _module_migrations:

Database Migration
==================

Modules can have their own migrations. To get comprehensive information about migrations in OXID eShop,
check :doc:`database migrations documentation <../../../tell_me_about/migrations>`.

Configuration
-------------
Put the migration configuration file into the `migration` folder inside the module's root directory:

.. code:: bash

    ├── migration
         └── migrations.yml

Example of `migrations.yml`:

.. code:: yaml

    table_storage:
      table_name: oxmigrations_ddoewysiwyg
    migrations_paths:
      'OxidEsales\WysiwygModule\Migrations': data

.. tip::
    To prevent database table name conflicts, include your module's ID in `table_name`.

Migration Classes
-----------------

Most recent info on requirements and structure of Migration Classes can be found in
`Doctrine Migrations documentation <https://www.doctrine-project.org/projects/doctrine-migrations/en/current/reference/migration-classes.html>`__.

Module migrations can also be generated and executed via
`OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__.

.. warning::
    When planning your Migration's structure, remember that certain
    `SQL statements <https://mariadb.com/kb/en/sql-statements-that-cause-an-implicit-commit>`__
    will issue
    `Implicit commits <https://www.doctrine-project.org/projects/doctrine-migrations/en/current/explanation/implicit-commits.html>`__
    which will affect the transaction functionality and may have unexpected side-effects.

Usage
-----

To generate migration versions for a specific module, we must use module_id for `<Suite_Type>` parameter.
Then all the module migration versions will be generated based on the configuration from migrations.yml file in migration folder of the given module.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate ddoewysiwyg

In this case it will be generated only for WYSIWYG module.
