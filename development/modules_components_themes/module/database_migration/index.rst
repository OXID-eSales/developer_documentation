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

Module migrations placed in the ``migration`` folder as described above are discovered
automatically: the shop scans the ``migration/migrations.yml`` of every installed module and
executes the migrations via ``oe:database:migrate``.

.. note::

    Auto-discovery only covers installed **modules**, and only at the fixed path
    ``migration/migrations.yml``. A :doc:`component <../../component>` is never scanned, and a
    module that keeps its migration configuration elsewhere is not discovered either — both must
    register their migrations through the DI tag shown below.

Migrations can also be registered explicitly through the Symfony service container using the
``oxid_esales.migration_path_provider`` DI tag (see :ref:`tagged_migrations`). This is the way to
expose migrations that auto-discovery does not cover — those of a component, or of a module whose
migration configuration lives outside the auto-discovered ``migration/migrations.yml`` path.

Place the configuration in a folder that is **not** the auto-discovered ``migration`` one (for
example ``di_migrations``), implement ``MigrationPathProviderInterface`` and register the service:

.. code:: php

    <?php

    use OxidEsales\EshopCommunity\Internal\Framework\Migration\MigrationPathProviderInterface;

    class MyModuleMigrationPathProvider implements MigrationPathProviderInterface
    {
        public function getMigrationConfigPath(): string
        {
            return __DIR__ . '/../di_migrations/migrations.yaml';
        }
    }

.. warning::

    Do not register the same migrations through both mechanisms. Migrations from an installed
    module's auto-discovered ``migration/migrations.yml`` are already registered automatically.
    Adding a DI tag for the same path registers them twice.

    Use the DI tag only for paths outside ``migration/`` or for components, never for an
    auto-discovered module path.

.. code:: yaml

    services:
      MyVendor\MyModule\MyModuleMigrationPathProvider:
        tags:
          - { name: 'oxid_esales.migration_path_provider' }

.. note::

    Where you register the provider decides when it is available:

    - In ``services.yaml`` it is only picked up by ``oe:database:migrate`` once the module has
      been activated via ``oe:module:activate``.
    - In :ref:`bootstrap-services.yaml <module_bootstrap_services>` it is available for every
      installed module, so the migrations can be run before the module is activated.

Usage
-----

To apply all pending migrations including module migrations, run:

.. code:: bash

   vendor/bin/oe-console oe:database:migrate

.. note::

    ``oe:database:migrate`` is the supported entry point. The older doctrine-migration wrapper
    (``vendor/bin/oe-eshop-doctrine_migration``, backed by the ``Migrations`` / ``MigrationsBuilder``
    classes) is deprecated in favour of it.

For more details on how the migration system works, see :doc:`Migrations <../../../tell_me_about/migrations>`.
