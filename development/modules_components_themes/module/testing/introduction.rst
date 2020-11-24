Module tests structure
----------------------

Default Testing Library behavior is to run all tests which are defined in one of the following  test classes and
are based on PHPUnit.

- AllTestsUnit
- AllTestsIntegration
- AllTestsSelenium

Unit and Integration are running by calling
===========================================
::

   vendor/bin/runtests

Selenium tests are running by calling
======================================
::

   vendor/bin/runtests-selenium


Module tests
=============

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

If you want to run only module tests, you should use these parameters in test_config.yml file:

::

  module_ids = <moduleId-1>,<moduleId-2>
  activate_all_modules = 1
  run_tests_for_shop = 0
  run_tests_for_modules = 1
  additional_test_paths = ''

then run
::

   vendor/bin/runtests

For more information check testing library documentation `<https://github.com/OXID-eSales/testing_library/>`__

.. note::

    We also have the possibility to run shop acceptance tests based on codeception which is the recommended way to
    write acceptance tests for OXID eShop and modules. This will be explained in detail in :ref:`Running Codeception Tests <running-codeception-tests>` sections.






