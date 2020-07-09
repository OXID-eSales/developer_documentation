Migrations
==========

OXID eShop uses database migrations for:

- eShop editions migration (CE, PE and EE)
- Project specific migrations
- :ref:`Modules migrations <module_migrations>`

.. _migrations_infrastructure-20160920:

Infrastructure
--------------

At the moment OXID eShop uses "Doctrine 2 Migrations" and it's integrated via OXID eShop migration components.

Doctrine Migrations runs migrations with a single configuration. But there was a need to run migration for one or all the
projects and modules (CE, PE, EE, PR and a specific module). For this reason `OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__
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

Script to run migrations is installed within composer bin directory. It accepts two parameters:

- Doctrine Command
- :ref:`Suite Type <suite_types>` (CE, PE, EE, PR or a specific module_id)

.. code:: bash

   vendor/bin/oe-eshop-db_migrate <Doctrine_Command> <Suite_Type>

.. important::

    To get comprehensive information about Doctrine 2 Migrations and available commands as well, please see `official documentation <https://www.doctrine-project.org/projects/doctrine-migrations/en/2.2/index.html>`__.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:migrate

This command will run all the migrations which are in OXID eShop specific directories. For example if you have
OXID eShop Enterprise edition, migration tool will run migrations in this order:

* Community Edition migrations (executed always)
* Professional Edition migrations (executed when eShop has PE or EE)
* Enterprise Edition migrations (executed when eShop has EE)
* Project specific migrations (executed always)
* Module migrations (executed when eShop has at least one module with migration)

.. _suite_types:

Suite Types (Generate migration for a single suite)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is also possible to run migrations for specific suite by defining `<Suite_Type>` parameter in the command.
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

In this case it will be generated only for Enterprise Edition in `vendor/oxid-esales/oxideshop_ee/migration` directory.

.. _module_migrations:

Module migrations
-----------------

Module migrations are available from 6.2.2

Configuration
^^^^^^^^^^^^^

There are a few steps need to be done:

- Create a migration folder inside the root directory of the module (migration folder name is case sensitive and must be all lower case).
- Create a migrations.yml file in migration folder and put at least the following configuration inside. To see the list of available configs, please check `official documentation <https://www.doctrine-project.org/projects/doctrine-migrations/en/2.2/reference/configuration.html#configuration>`__.


    - **name:** The name that shows at the top of the migrations console application
    - **migrations_namespace:** The PHP namespace your migration classes are located under
    - **table_name:** The name of the table to track executed migrations in
    - **migrations_directory:** The path to a directory where to look for migration classes

Example:

.. code:: bash

    name: WYSIWYG module migration (ddoewysiwyg)
    migrations_namespace: OxidEsales\WysiwygModule\Migrations
    table_name: oxmigrations_ddoewysiwyg
    migrations_directory: data

.. tip::

    - As you need to know the module_id for several migration commands we recommend to put the module_id in the `name` parameter,
      like the sample: WYSIWYG module migration (ddoewysiwyg). In fact, you will have module_id (in this case: ddoewysiwyg) in console
      result and you do not need to lookup the module_id anymore.
    - Use module_id for the `table_name` parameter to avoid conflicts with any other tables in database.


Usage
^^^^^

To generate migration versions for a specific module, we must use module_id for `<Suite_Type>` parameter.
Then all the module migration versions will be generated based on the configuration from migrations.yml file in migration folder of the given module.

Example:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:generate ddoewysiwyg

In this case it will be generated only for WYSIWYG module in `source/modules/ddoe/wysiwyg/migration` directory.

Use Migrations Wrapper without CLI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Doctrine Migration Wrapper is written in PHP and also could be used without command line interface. To do so:

- Create ``Migrations`` object with ``MigrationsBuilder->build()``
- Call ``execute`` method with needed parameters
