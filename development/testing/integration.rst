Integration tests
=================

Integration tests are a bit more complicated:

 1. Setup: it interacts with other units (components) and with the database. Therefore we need to create database and
    bootstrap the shop.
 2. Tear down: Tests must do not affect each other. When tests interact with a database,
    they may change the data inside it, which would eventually lead to data inconsistency.
    To avoid test failures, the database should be brought back to its initial state before each test.

Before running integration tests please setup shop:

.. code::

  vendor/bin/oe-console oe:database:reset --db-host= --db-port= --db-name= --db-user= --db-password= --force

To run shop integration tests call:

.. code::

  vendor/bin/phpunit -c phpunit.xml --bootstrap tests/bootstrap.php tests/Integration

To run shop integration tests with an active module, first activate it:

.. code::

  vendor/bin/oe-console oe:module:activate <module-id>

And later run integration tests:

.. code::

  vendor/bin/phpunit -c phpunit.xml --bootstrap tests/bootstrap.php tests/Integration

Populating shop database for tests
----------------------------------

You can setup the shop with initial data using oe:database:reset command from the developer-tools package.
It installs shop and adds the initial data to run the shop:

.. code::

  vendor/bin/oe-console oe:database:reset --db-host= --db-port= --db-name= --db-user= --db-password= --force

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

Clearing shop cache
-------------------

There is quite a lot of caching going on:
 - Compile directory
 - Registry
 - var directory
 - and more…

If cache has to be cleared after the tests are run, you can use the `CachingTrait` trait:

.. code::

    use CachingTrait;

    public function setUp(): void
    {
        parent::setUp();
        $this->cleanupCaching();
    }

    public function tearDown(): void
    {
        $this->cleanupCaching();
        parent::tearDown();
    }

Or you can extend `IntegrationTestCase` class which does it for you.

At the moment it cleans compile directory, `Registry` and some classes,
like `DatabaseProvider` and `ModuleVariablesLocator`.


(Test-) Container
-----------------

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
