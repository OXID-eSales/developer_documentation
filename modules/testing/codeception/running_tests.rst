.. _running-codeception-tests:

Running Codeception Tests
-------------------------

To run Codeception tests go to the shop directory and adapt the test_config.yml file to your needs.
For example to only run your module codeception tests, check these parameters:

::

  partial_module_paths  = <vendor_name>/<module_name>
  activate_all_modules = 1
  run_tests_for_shop = 0
  run_tests_for_modules = 1
  additional_test_paths = ''

Then go to the shop directory (cd ``<shop_dir>``) and run:
::

  vendor/bin/runtests-codeception


Alternatively the parameters can be supplied via commandline. Commandline parameters override the parameters which are set in the test_config.yaml.
::

  PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception

Example:
::

  PARTIAL_MODULE_PATHS=oe/geoblocking \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception

**How to run a single test file:**
::

  PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception <test_file_name_without_extension>

Example:
::

  PARTIAL_MODULE_PATHS=oe/geoblocking ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception FrontendCest

**How to run a single test:**
::

  PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception <test_file_name_without_extension>:<test_method_name>

Example:
::

  PARTIAL_MODULE_PATHS=oe/geoblocking \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception FrontendCest:registerUserWithCountryWhichIsInvoiceOnly


**How to run a test group:**
::

  PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception -g <group_name>

**How to run tests excluding a group:**
::

  PARTIAL_MODULE_PATHS=<vendor_name>/<module_name> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception -x <group_name>


Run with PHPStorm
^^^^^^^^^^^^^^^^^

The description how to setup Codeception on PHPStorm you can find `here <https://www.jetbrains.com/help/phpstorm/using-codeception-framework.html>`__.

**Note:** The default configuration file for the test runner is located in ``<shop_dir>/tests/codeception.yml``.