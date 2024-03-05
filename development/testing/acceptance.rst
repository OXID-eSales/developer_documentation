Acceptance tests
================

The acceptance (Codeception) tests are even more complicated then integration tests. Here we need not only an existing
shop database, but also some data fixtures. For the database population and for the cleaning up we use by the
codeception framework provided standard tools and best practice.

To run all tests:

.. code::

  vendor/bin/codecept run Acceptance -c tests/codeception.yml

To run all admin area tests:

.. code::

  vendor/bin/codecept run Acceptance -c tests/codeception.yml -g admin

To run with activated module:

.. code::

  MODULE_IDS= vendor/bin/codecept run Acceptance -c tests/codeception.yml

Populating test data
--------------------

The population of the fixture data has a very specific workflow:
- Setup the database of the shop with some initial data
- Import a sql file with data fixtures
- Create a dump file to populate and to restore the test data
- Assign the generated dump file to the codeception Db module

ShopSetup codeception module
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All these steps are already implemented in the ShopSetup codeception module and cann be activated
by adding it to your codeception suite configurations:

.. code::

    modules:
      enabled:
        - \OxidEsales\Codeception\Module\ShopSetup:
            dump: '%DUMP_PATH%'
            fixtures: '%FIXTURES_PATH%'
            license: '%license_key%'
        - Db:
        .....

**Important: The ShopSetup codeception module has to be activated before Db codeception module.**

Manual shop setup
^^^^^^^^^^^^^^^^^

Of course you can setup shop with testing data manually:

- Use the database reset command to bring your shop database into its initial state:

    .. code:: bash

        vendor/bin/oe-console oe:database:reset

- Insert data fixtures
- Create a dump file
- Assign this generated dump file to the `dump` parameter of the codeception Db module.

Cleaning up the database automatically before each test
-------------------------------------------------------

Tests should not affect each other. A test may try to insert a record that has already been inserted,
or retrieve a deleted record. We recommend to bring the database to its initial state before each test
by using `the Db codeception module <https://codeception.com/docs/modules/Db>`__ and setting the cleanup
parameter to true:

.. code::

    - Db:
        user: '%DB_USERNAME%'
        password: '%DB_PASSWORD%'
        port: '%DB_PORT%'
        dump: '%DUMP_PATH%'
        mysql_config: '%MYSQL_CONFIG_PATH%'
        populator: 'mysql --defaults-file=$mysql_config --default-character-set=utf8 $dbname < $dump'
        populate: true # run populator before all tests
        cleanup: true # run populator before each test

Rebuilding the database from scratch is not the best way, but in this case it is
the only one.
