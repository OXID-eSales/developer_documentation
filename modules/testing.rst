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
