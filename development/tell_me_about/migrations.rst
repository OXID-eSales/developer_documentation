Migrations
==========

OXID eShop uses `Doctrine Migrations <https://www.doctrine-project.org/projects/migrations.html>`__ for database schema and data changes.
Migrations can be provided by:

- eShop editions (CE, PE, EE)
- Project-specific code
- :ref:`Components <component-database-migration>`
- :ref:`Modules <module_migrations>`

.. _migrations_running:

Running migrations
------------------

The standard command to apply all pending migrations is:

.. code:: bash

    vendor/bin/oe-console oe:database:migrate

This runs migrations from all sources in a single pass:

- eShop edition migrations (CE, and PE/EE when applicable)
- Project-specific migrations
- Component migrations registered via the :ref:`tagged provider system <tagged_migrations>`
- Module migrations via the `OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__

.. note::

    Migrations registered via ``oxid_esales.migration_path_provider`` execute through
    ``oe:database:migrate``, during shop setup, and when the deprecated
    ``oe-eshop-db_migrate migrations:migrate`` script runs without a suite argument.
    They do not run when the deprecated ``Migrations`` class is used programmatically.

``oe:database:migrate`` supports the common options of the underlying Doctrine
``migrations:migrate`` command, such as ``--dry-run``, and forwards them to every migration
source. Check the `Doctrine Migrations documentation
<https://www.doctrine-project.org/projects/doctrine-migrations/en/current/reference/managing-migrations.html>`__
for the available options.

Example:

.. code:: bash

    vendor/bin/oe-console oe:database:migrate --dry-run

.. _doctrine_migrations_directly:

Calling Doctrine Migrations directly
--------------------------------------

You can call the Doctrine Migrations executable directly to work with a specific configuration,
for example to generate a blank migration class:

.. code:: bash

    vendor/bin/doctrine-migrations migrations:generate --configuration=<path-to-migrations.yml>

This places a new ``Version<YYYYMMDDHHMMSS>.php`` class in the directory configured under
``migrations_paths`` in the given ``migrations.yml``.

.. _tagged_migrations:

Tagged migrations
-----------------

Migrations can be registered through the Symfony service container using the
``oxid_esales.migration_path_provider`` DI tag. The shop collects all tagged providers and runs
their migrations as part of ``oe:database:migrate``. This is how components provide their
migrations; project-specific code can register migration paths the same way.

To register a migration path provider, implement ``MigrationPathProviderInterface`` and tag the
service in ``services.yaml``.

Registration for a component
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Component services are always active, so their migrations are available immediately after
``composer require``.

.. code:: php

    <?php

    use OxidEsales\EshopCommunity\Internal\Framework\Migration\MigrationPathProviderInterface;

    class MyComponentMigrationPathProvider implements MigrationPathProviderInterface
    {
        public function getMigrationConfigPath(): string
        {
            return __DIR__ . '/../migration/migrations.yml';
        }
    }

.. code:: yaml

    # services.yaml
    services:
      MyVendor\MyComponent\MyComponentMigrationPathProvider:
        tags:
          - { name: 'oxid_esales.migration_path_provider' }

See :ref:`component-database-migration` for the full component migration setup including the
``migrations.yml`` configuration.

Registration for a module
^^^^^^^^^^^^^^^^^^^^^^^^^^

Modules can also register tagged migrations. This is an alternative to the standard module
migration setup described in :ref:`module_migrations`, which discovers module migrations
automatically.

.. note::

    Module services are only loaded after the module is activated. A migration path provider
    registered in a module's ``services.yaml`` will therefore only be picked up by
    ``oe:database:migrate`` once the module has been activated via ``oe:module:activate``.

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

The ``migrations.yml`` file is placed in the ``migration`` folder of the module:

.. code:: bash

    ├── migration
    │    ├── migrations.yml
    │    └── data
    │         └── Version20240101000000.php

Example ``migrations.yml``:

.. code:: yaml

    table_storage:
      table_name: myvendor_mymodule_migrations
    migrations_paths:
      'MyVendor\MyModule\Migrations': data

.. tip::

    To prevent database table name conflicts, include your module's ID in ``table_name``.

See :ref:`module_migrations` for the full module migration setup.
