Migrations
==========

OXID eShop uses database migrations for:

- eShop editions migration (CE, PE and EE)
- Project specific migrations
- :ref:`Modules migrations <module_migrations>`

.. _migrations_infrastructure-20160920:

Infrastructure
--------------

OXID eShop uses `Doctrine  Migrations <https://www.doctrine-project.org/projects/migrations.html>`__ integrated via OXID eShop migration components.

Prior to v3.0, Doctrine Migrations was not able to collect migrations from multiple folders/namespaces and to specify dependencies between them. But there was a need to run migration for one or all the projects and modules (CE, PE, EE, PR and a specific module). For this reason, we have created the `OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__.

The Doctrine Migration Wrapper needs some information about the OXID eShop installation like:

- what edition is active
- what are credentials for database

This information is gathered from `OXID eShop Facts <https://github.com/OXID-eSales/oxideshop-facts>`__.

OXID eShop Facts has a class which can provide an information about OXID eShop and its environment. This component is shop-independent and can be used without bootstrap. The only restriction is to have the `config.inc.php` file configured.

Usage
-----

Running migrations - CLI
^^^^^^^^^^^^^^^^^^^^^^^^

The script to run migrations is installed within Composer's `bin` directory. It accepts two parameters:

- Doctrine Command
- :ref:`Suite Type <suite_types>` (CE, PE, EE, PR or a specific module_id)

.. code:: bash

   vendor/bin/oe-eshop-db_migrate <Doctrine_Command> <Suite_Type>

.. important::

    For the comprehensive and up-to-date info, consult the `Doctrine Migrations official documentation <https://www.doctrine-project.org/projects/doctrine-migrations/en/current/index.html>`__.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:migrate

This command will run all the migrations which are in OXID eShop specific directories. If you have the OXID eShop Enterprise edition, for example, the migration tool will run migrations in this order:

* Community Edition migrations (executed always)
* Professional Edition migrations (executed when eShop has PE or EE)
* Enterprise Edition migrations (executed when eShop has EE)
* Project specific migrations (executed always)
* Module migrations (executed when eShop has at least one module with migration)

.. _suite_types:

Suite Types (Generate migration for a single suite)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is also possible to run migrations for a specific suite by defining `<Suite_Type>` parameter in the command.
This variable defines what type of migration it is. There are 5 suite types:

* **PR** - For project specific migrations. It should be always used for project development.
* **CE** - Generates migration file for OXID eShop Community Edition. **It's used for product development only**.
* **PE** - Generates migration file for OXID eShop Professional Edition. **It's used for product development only**.
* **EE** - Generates migration file for OXID eShop Enterprise Edition. **It's used for product development only**.
* **<module_id>** - Generates migration file for OXID eShop specific module. **It’s used for module development only**.

Example 1:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate

This command generates migration versions for all the :ref:`suite types <suite_types>`.

Example 2:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate EE

In this case, it will be generated only for Enterprise Edition in `vendor/oxid-esales/oxideshop_ee/migration` directory.

.. _module_migrations:

Module migrations
-----------------

Configuration
^^^^^^^^^^^^^
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


Usage
^^^^^

To generate migration versions for a specific module, we must use module_id for `<Suite_Type>` parameter.
Then all the module migration versions will be generated based on the configuration from migrations.yml file in migration folder of the given module.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate ddoewysiwyg

In this case it will be generated only for WYSIWYG module.

Use Migrations Wrapper without CLI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Doctrine Migration Wrapper is written in PHP and also could be used without command line interface. To do so:

- Create ``Migrations`` object with ``MigrationsBuilder->build()``
- Call ``execute`` method with needed parameters
