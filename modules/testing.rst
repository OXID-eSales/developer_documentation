.. _test_module-20170217:

Testing
=======

It is recommended to write tests by using `OXID Testing Library. <https://github.com/OXID-eSales/testing_library/>`__

OXID Testing Library helps to test single module by:

- Adding helpers to write tests.
- Adding communication with OXID eShop layer.
- Ensuring that tests do not affect each other due to database usage.
- Stabilizing Selenium tests.
- Allows to test compilation intercompatibility:
    OXID eShop allows several modules to work at the same time and they might interact with each other.
    Testing Library allows to easily run tests for each module to check intercompatibility.

Module tests structure
----------------------

Default Testing Library behavior is to run all tests which are defined in one of the test classes:

- AllTestsUnit
- AllTestsSelenium

These classes define default directories to store tests for a module:

- Unit
- Integration
- Acceptance

Possible structure of module tests:

::

  <module_id>/tests/Acceptance/testData/fileNeededToBeCopiedToShop
  <module_id>/tests/Acceptance/testSql/demodata.sql
  <module_id>/tests/Acceptance/testSql/demodata_PE_CE.sql
  <module_id>/tests/Acceptance/testSql/demodata_EE.sql
  <module_id>/tests/Acceptance/testSql/demodata_EE_mall.sql
  <module_id>/tests/Acceptance/moduleAcceptanceTest.php
  <module_id>/tests/Integration/moduleIntegrationTest.php
  <module_id>/tests/Unit/moduleUnitTest.php
  <module_id>/tests/additional.inc.php
  <module_id>/tests/phpunit.xml

Possible example in `PayPal GitHub repository. <https://github.com/OXID-eSales/paypal/tree/a4770a7da0d1b13dc4e8be4f8bc30abf7d418d03/tests>`__

Testing library and it's documentation `in GitHub. <https://github.com/OXID-eSales/testing_library/>`__

Acceptance tests with Codeception
---------------------------------

You can use `Codeception <https://codeception.com/>`__ for writing module's acceptance tests.

To start with acceptance tests using Codeception you have to initialize them with running the following command:
::

  php vendor/bin/codecept init acceptance --path source/modules/<vendor_name>/<module_name>/<tests_folder>/

Example:
::

  php vendor/bin/codecept init acceptance --path source/modules/oe/zugferd/tests/

Enter :guilabel:`Codeception` as test folder's name, :guilabel:`firefox` as webdriver and http://www.oxideshop.local as :guilabel:`url`. You should enter data which is suitable in your case.

This command creates configuration file :guilabel:`codeception.yml` and tests directory (with name provided by you - in current case :guilabel:`Codeception`) and acceptance test suites.

`Note: Run this command in case you want to initialize the tests for first time.`


The structure of the module's test folder looks as follows:
::

  <vendor_name>/<module_name>/tests/Codeception/_data/
  <vendor_name>/<module_name>/tests/Codeception/_output/
  <vendor_name>/<module_name>/tests/Codeception/_support/
  <vendor_name>/<module_name>/tests/Codeception/acceptance
  <vendor_name>/<module_name>/tests/Codeception/config
  <vendor_name>/<module_name>/tests/Codeception/acceptance.suite.yml
  <vendor_name>/<module_name>/tests/codeception.yml

To run all Codeception tests go to the shop directory and run:
::

  cd <shop_dir> && PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception

Example:
::

  cd /var/www/oxideshop && PARTIAL_MODULE_PATHS=oe/geoblocking ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception

How to run single test file:
::

  cd <shop_dir> && PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception <test_file_name_without_extension>

Example:
::

  cd /var/www/oxideshop && PARTIAL_MODULE_PATHS=oe/geoblocking ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception FrontendCest

How to run test group:
::

  cd <shop_dir> && PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception -g <group_name>

How to run tests excluding a group:
::

  cd <shop_dir> && PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception -x <group_name>

Users predefined in demo data
-----------------------------

If you are running tests or using ``reset-shop`` functionality of testing library, it's possible to use these credentials
in OXID eShop:

::

  Rights: admin
  User name: admin
  Password: admin

::

   Rights: buyer
   User name: user@oxid-esales.com
   Password: user
