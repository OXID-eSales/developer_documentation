Migrations
==========

OXID eShop uses database migrations for eShop setup and updates. Migration tool can be used for project
specific migrations too.

.. _migrations_infrastructure-20160920:

Infrastructure
--------------

At the moment OXID eShop uses "Doctrine 2 Migrations" and it's integrated via OXID eShop migration components.

Doctrine Migrations runs migrations with a single configuration. There is a need to run several configurations (suites)
of migrations for OXID eShop project. For example one for Community Edition, one for Enterprise Edition and one for a project.
For this reason `OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__
was created.

Doctrine Migration Wrapper needs some information about the OXID eShop installation like:

- what edition is active
- what are credentials for database

This information is gathered from `OXID eShop Facts <https://github.com/OXID-eSales/oxideshop-facts>`__.
Facts has a class which can provide an information about OXID eShop and it's environment. This component is Shop
independent and can be used without bootstrap. The only restriction is to have config.inc.php file configured.

Usage
-----

Running migrations - CLI
^^^^^^^^^^^^^^^^^^^^^^^^

Script to run migrations is registered to composer bin directory. It accept two parameters:

- Doctrine Command
- :ref:`Suit Type <suit_types>`

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:migrate

This command will run all the migrations which are in OXID eShop specific directories. For example if you have
OXID eShop Enterprise edition, migration tool will run migrations in this order:

* Community Edition migrations
* Professional Edition migrations
* Enterprise Edition migrations
* Project specific migrations
* Module specific migrations

.. _suit_types:

Suit Types
^^^^^^^^^^

It is also possible to run migrations for specific suite by defining environment variable - **MIGRATION_SUITE**.
This variable defines what type of migration it is. There are 5 types:

* **PR** - For project specific migrations. It should be always used for project development.
* **CE** - Generates migration file for OXID eShop Community Edition. **It's used for product development only**.
* **PE** - Generates migration file for OXID eShop Professional Edition. **It's used for product development only**.
* **EE** - Generates migration file for OXID eShop Enterprise Edition. **It's used for product development only**.
* **<moduleId>** - Generates migration file for OXID eShop specific module. **It's used for product development only**.

Configure module migration for a single module
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are a few steps need to done:

- create a migration folder inside the root directory of the module

.. important::
    migration folder name is case sensitive and must be all lower case.

- create a migration.yaml file and put the following configuration inside. Check `doctrine-migration document <https://www.doctrine-project.org/projects/doctrine-migrations/en/2.2/reference/configuration.html#configuration>`__.

Example:

.. code:: bash

    name: Oxid Migrations Wysiwyg Module
    migrations_namespace: OxidEsales\WysiwygModule\Migrations
    table_name: oxmigrations_wysiwygModule
    migrations_directory: data

Generate migration
^^^^^^^^^^^^^^^^^^

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate

This command generates migration versions for all the :ref:`suit types <suit_types>`.

Generate migration for a single suite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate suit type

This command generates migration versions for the specified suit in its migration folder.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate PR

In this case it will be generated in `source/migration/project_data/` directory.

.. note::
    To generate migration versions for a specific module, we must use module_id for suit type. Then all the module migration versions will be generated based on the configuration from migrations.yml file in module migration folder.

Run Doctrine 2 Migrations commands
----------------------------------

Sometimes there will be a need to run doctrine specific commands. To do so run Doctrine Migrations command:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate DOCTRINE_COMMAND

For example, you would like to get the list of doctrine migrations available commands:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate

More information on how to use Doctrine 2 Migrations can be found in official documentation page:
http://docs.doctrine-project.org/projects/doctrine-migrations/en/latest/

Using Doctrine Migrations Wrapper
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Doctrine Migration Wrapper is written in PHP and could be used without command line interface.
To do so:

- Create ``Migrations`` object with ``MigrationsBuilder->build()``
- Call ``execute`` method with needed parameters
