Module tests structure
----------------------

Default Testing Library behavior is to run all tests which are defined in one of the following  test classes and
are based on PHPUnit.

- AllTestsUnit
- AllTestsIntegration
- AllTestsSelenium

Tests are run by calling
::

   vendor/bin/runtests

to run unit and integration tests and
::

   vendor/bin/runtests-selenium

to run selenium tests.

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


We also have the possiblity to run shop acceptance tests based on codeception which is the recomended way to
write acceptance tests for OXID eShop and modules. This will be explained in detail in the following sections.



