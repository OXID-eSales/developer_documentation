Integration tests
=================

Integration tests are a bit more complicated:

- they might interact with multiple system components:

    - we are required to prepare the database and bootstrap the shop.

- they need be isolated and should not alter the state of the system:

    - database, global variables, configuration files should be brought to their initial states on test tear-down.

Running integration tests
-------------------------

To run shop integration tests, execute:

.. code:: bash

  vendor/bin/phpunit -c phpunit.xml --bootstrap tests/bootstrap.php tests/Integration

Preparing the database for integration tests
--------------------------------------------

Use the database reset command to bring your shop database into its initial state before starting with testing:

.. code:: bash

  vendor/bin/oe-console oe:database:reset


Cleaning up the database automatically before each test
-------------------------------------------------------

The solution for bringing the database back to its initial state before each test without
sacrificing performance is to use transactions.

You have to begin a database transaction in setUp method of the test and roll it back in tearDown method.
For that you can use `DatabaseTrait`:

.. code::

    use DatabaseTrait;

    public function setUp(): void
    {
        parent::setUp();
        $this->beginTransaction();
    }

    public function tearDown(): void
    {
        $this->rollBackTransaction();
        parent::tearDown();
    }

Also there is a base class for integration tests `IntegrationTestCase` which does all the cleanup work for you.

.. warning::
    The mentioned approach might not work in certain circumstances. You might need to resort to using much slower
    `oe:database:reset` (see `DatabaseTrait::setupShopDatabase()` in cases when:

    1. DDL statements are executed during the test

        Because both MySQL and MariaDB do not support DDL statements
        (`CREATE TABLE`, `ALTER TABLE`, `CREATE VIEW` etc.) in transactions, issuing such
        `SQL statements <https://mariadb.com/kb/en/sql-statements-that-cause-an-implicit-commit>`__
        will commit any existing transaction implicitly.
        This means that test database restoration will not work properly and your test data may leak into your DB.
        If any DDL statement is executed between running `$this->beginTransaction()` and `$this->rollBackTransaction()`,
        your transaction will be committed before you roll it back, and you may get an PDO error:
        `There is no active transaction` as a result.

    2. Test initiates DB changes in a separate DB connection (e.g. via shell command)

Clearing shop cache
-------------------

PHPUnit has in-built mechanisms to prevent tests interfering with each other, that can be activated either

- globally with :file:`phpunit.xml` configuration file (recommended):

.. code:: xml

    <phpunit
     backupGlobals="true"
     backupStaticProperties="true"
     processIsolation="true">

- or individually, per-test/per-test-case with PHP attributes:

.. code:: php

    #[backupGlobals]
    #[backupStaticProperties]
    #[RunTestsInSeparateProcesses]

If the built-in functionality is not sufficient for your case, you can extend it with custom cleaners
(have a look at existing traits in the ``OxidEsales\EshopCommunity\Tests`` namespace).

Test Container
--------------

When running integration tests we won't be able to use the normal DI container because
most of the services are private, so we can't access them. And also in some integration
tests we want to replace them - this is also not possible in the normal DI container.
Therefore you can use a slightly modified `TestContainer` that allows for retrieving every
service and also allows for replacing certain services with stubs or mocks. It is called `TestContainerFactory`:

 - The factory returns an uncompiled container so that it still can be manipulated.
   So after obtaining the container, it is necessary to compile it.
 - All services in the container are set to public.
 - There are already several services replaced:
     * BasicContext through BasicContextStub
     * Context through ContextStub

To access this `TestContainer` in your tests, please use `ContainerTrait` trait:

.. code::

    use ContainerTrait;

    public function testSomething()
    {
        $context = $this->get(ContextInterface::class);
        $logLevel = $context->getLogLevel();
    }

You can also access `TestContainer` by extending the `IntegrationTestCase` class.
