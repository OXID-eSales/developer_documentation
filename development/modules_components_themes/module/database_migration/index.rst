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

A module registers its migrations through the Symfony service container using the
``oxid_esales.migration_path_provider`` DI tag (see :ref:`tagged_migrations`).

Implement ``MigrationPathProviderInterface`` and return the path to the module's
``migrations.yml``:

.. code:: php

    <?php

    use OxidEsales\EshopCommunity\Internal\Framework\Migration\MigrationPathProviderInterface;
    use Symfony\Component\Filesystem\Path;

    class MyModuleMigrationPathProvider implements MigrationPathProviderInterface
    {
        public function getMigrationConfigPath(): string
        {
            return Path::join(__DIR__, '..', 'migration', 'migrations.yml');
        }
    }

Register the provider in the module's :ref:`bootstrap-services.yaml <module_bootstrap_services>`:

.. code:: yaml

    services:
      MyVendor\MyModule\MyModuleMigrationPathProvider:
        tags:
          - { name: 'oxid_esales.migration_path_provider' }

Services in ``bootstrap-services.yaml`` are loaded for every installed module, so the module's
migrations are executed by ``oe:database:migrate`` as soon as the module is installed, whether it
is activated or not.

.. note::

    The provider can also be registered in the module's ``services.yaml``. It is then only picked
    up by ``oe:database:migrate`` once the module has been activated via ``oe:module:activate``.

Usage
-----

To apply all pending migrations including module migrations, run:

.. code:: bash

   vendor/bin/oe-console oe:database:migrate

For more details on how the migration system works, see :doc:`Migrations <../../../tell_me_about/migrations>`.
