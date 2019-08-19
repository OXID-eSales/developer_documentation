Writing codeception test from scratch
-------------------------------------

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
