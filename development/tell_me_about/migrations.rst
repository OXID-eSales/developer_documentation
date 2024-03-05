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

Prior to v3.0, Doctrine Migrations was not able to collect migrations from multiple folders/namespaces and to specify dependencies between them.
But there was a need to run migration for one or all the projects and modules (CE, PE, EE, PR and a specific module).
For this reason, we have created the `OXID eShop Doctrine Migration Wrapper <https://github.com/OXID-eSales/oxideshop-doctrine-migration-wrapper>`__.

The Doctrine Migration Wrapper will utilize the database connection that is configured in the active environment


Using migrations
----------------

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

This command will run all the migrations which are in OXID eShop specific directories.
If you have the OXID eShop Enterprise edition, for example, the migration tool will run migrations in this order:

* Community Edition migrations (executed always)
* Professional Edition migrations (executed when eShop has PE or EE)
* Enterprise Edition migrations (executed when eShop has EE)
* Project specific migrations (executed always)
* Module migrations (executed when eShop has at least one module with migration)

.. _suite_types:

Suite Types (Generate migration for a single suite)
"""""""""""""""""""""""""""""""""""""""""""""""""""

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

Calling Doctrine Migrations directly:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

*OXID Migration Wrapper* makes it easy to manage complete sets of project's migrations with a single command.
You can always bypass this component and just call *Doctrine Migration's* executable directly
to use migrations in any other scenario:

.. code:: bash

    # calling OXID Migration Wrapper's executable vs.
    vendor/bin/oe-eshop-db_migrate

    # calling Doctrine Migration's executable
    vendor/bin/doctrine-migrations

For example:

-  to execute a single migration file, run:

.. code:: bash

    vendor/bin/doctrine-migrations execute \
        --up \
        'OxidEsales\EshopCommunity\Migrations\Version1234567890' \
        --db-configuration 'vendor/oxid-esales/oxideshop-doctrine-migration-wrapper/src/migrations-db.php' \
        --configuration source/migration/migrations.yml

Using Migrations Wrapper without CLI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Doctrine Migration Wrapper is written in PHP and also could be used without command line interface. To do so:

- Create ``Migrations`` object with ``MigrationsBuilder->build()``
- Call ``execute`` method with needed parameters
