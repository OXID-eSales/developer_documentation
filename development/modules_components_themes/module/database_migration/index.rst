.. _module_migrations:

Database Migration
==================

Modules can have their own migrations. To get comprehensive information about migrations in OXID eShop,
check the database migrations documentation under :doc:`Migrations <../../../tell_me_about/migrations>`.

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

To generate a blank migration class for your module, call the Doctrine Migrations CLI directly
with your module's configuration (see also :ref:`doctrine_migrations_directly`):

.. code:: bash

    vendor/bin/doctrine-migrations migrations:generate \
        --configuration=<path-to-module>/migration/migrations.yml

.. warning::
    When planning your Migration's structure, remember that certain
    `SQL statements <https://mariadb.com/kb/en/sql-statements-that-cause-an-implicit-commit>`__
    will issue
    `Implicit commits <https://www.doctrine-project.org/projects/doctrine-migrations/en/current/explanation/implicit-commits.html>`__
    which will affect the transaction functionality and may have unexpected side-effects.

Registration
------------

Module migrations can be generated and executed via the deprecated
`OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__.
The recommended way is to register migrations through the Symfony service container using the
``oxid_esales.migration_path_provider`` DI tag. Implement ``MigrationPathProviderInterface``
and register the service in the module's ``services.yaml``:

.. code:: php

    <?php

    use OxidEsales\EshopCommunity\Internal\Framework\Migration\MigrationPathProviderInterface;

    class MyModuleMigrationPathProvider implements MigrationPathProviderInterface
    {
        public function getMigrationConfigPath(): string
        {
            return __DIR__ . '/../migration/migrations.yml';
        }
    }

.. code:: yaml

    # services.yaml
    services:
      MyVendor\MyModule\MyModuleMigrationPathProvider:
        tags:
          - { name: 'oxid_esales.migration_path_provider' }

.. note::

    Module services are only loaded after the module is activated. The migration path provider
    will therefore only be picked up by ``oe:database:migrate`` once the module has been
    activated via ``oe:module:activate``.

Usage
-----

To apply all pending migrations including module migrations, run:

.. code:: bash

   vendor/bin/oe-console oe:database:migrate

For more details on how the migration system works, see :doc:`Migrations <../../../tell_me_about/migrations>`.
