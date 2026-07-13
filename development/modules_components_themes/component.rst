OXID eShop Component
====================

.. note::
    Watch a short video tutorial on YouTube: `Components & Services <https://www.youtube.com/watch?v=tgopDKPiUZE>`_.

OXID eShop component is a simple way for a project to add reusable code to the application via Composer packages.
You can write classes that have new or extended functionality and you may wire these classes together in your
Composer package by using the :doc:`Service Container </development/tell_me_about/service_container>`.

In contrast to modules, components do not need to be activated but just installed by Composer.

How it works
------------

.. _component-how-it-works:

On installation the OXID Composer plugin will include your components :file:`services.yaml` file in a file
named :file:`generated_services.yaml` that is read when the DI container is assembled.
You will find this file in :file:`var/generated` but you should not alter it manually.


Component type
--------------

.. _component-type:

It's necessary that component would have `oxideshop-component` type in `composer.json` file:

.. code:: json

    {
        "type": "oxideshop-component",
    }


Installation
--------------

.. _component-installation:

When requiring a package with Composer the `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__
checks the package type. If the type is `oxideshop-component` then the package is installed as an OXID eShop component.

.. code:: bash

    composer require vendor/package

During the installation the `services.yaml` file is imported into the :ref:`Service Container <service_container_01>`.
After that, the component is globally and permanent active.

Uninstallation
--------------

.. _component-uninstallation:

To uninstall a OXID eShop component, it's necessary to execute Composer's remove command:

.. code:: bash

    composer remove vendor/package

Database Migration
------------------

.. _component-database-migration:

Components can provide their own Doctrine database migrations by registering their migration
configuration through the Symfony service container using the ``oxid_esales.migration_path_provider``
DI tag.

Configuration
^^^^^^^^^^^^^

Place the Doctrine migration configuration file inside a ``migration`` folder in your component:

.. code:: bash

    ├── migration
    │    ├── migrations.yml
    │    └── data
    │         └── Version20240101000000.php

Example ``migrations.yml``:

.. code:: yaml

    table_storage:
      table_name: myvendor_mycomponent_migrations
    migrations_paths:
      'MyVendor\MyComponent\Migrations': data

.. tip::
    To prevent database table name conflicts, include your component's name in ``table_name``.

Creating a migration version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To generate a blank migration class, call the Doctrine Migrations CLI directly with your
component's configuration (see also :ref:`doctrine_migrations_directly`):

.. code:: bash

    vendor/bin/doctrine-migrations migrations:generate \
        --configuration=<path-to-component>/migration/migrations.yml

Migration path provider
^^^^^^^^^^^^^^^^^^^^^^^

Implement ``MigrationPathProviderInterface`` to point the executor at your configuration file:

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

Register the provider in your component's ``services.yaml`` with the
``oxid_esales.migration_path_provider`` tag:

.. code:: yaml

    services:
      MyVendor\MyComponent\MyComponentMigrationPathProvider:
        tags:
          - { name: 'oxid_esales.migration_path_provider' }

Running migrations
^^^^^^^^^^^^^^^^^^

All registered component migrations run together with the shop migrations via:

.. code:: bash

    vendor/bin/oe-console oe:database:migrate
