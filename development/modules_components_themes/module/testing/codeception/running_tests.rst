.. _running-codeception-tests:

Running Codeception Tests
-------------------------

To run Codeception tests go to the shop directory and adapt the test_config.yml file to your needs.
For example to only run your module codeception tests, check these parameters:

::

  module_ids = <moduleId-1>,<moduleId-2>
  activate_all_modules = 1
  run_tests_for_shop = 0
  run_tests_for_modules = 1
  additional_test_paths = ''

Then go to the shop directory (cd ``<shop_dir>``) and run:
::

  vendor/bin/runtests-codeception


Alternatively the parameters can be supplied via commandline. Commandline parameters override the parameters which are set in the test_config.yaml.
::

  MODULE_IDS=<moduleId-1>,<moduleId-2> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception

Example:
::

  MODULE_IDS=oegeoblocking \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception

**How to run a single test file:**
::

  MODILE_IDS=<moduleId-1>,<moduleId-2> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception <test_file_name_without_extension>

Example:
::

  MODILE_IDS=oegeoblocking ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests-codeception FrontendCest

**How to run a single test:**
::

  MODILE_IDS=<moduleId-1>,<moduleId-2> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception <test_file_name_without_extension>:<test_method_name>

Example:
::

  MODILE_IDS=oegeoblocking \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception FrontendCest:registerUserWithCountryWhichIsInvoiceOnly


**How to run a test group:**
::

  MODILE_IDS=<moduleId-1>,<moduleId-2> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception -g <group_name>

**How to run tests excluding a group:**
::

  MODILE_IDS=<moduleId-1>,<moduleId-2> \
  ADDITIONAL_TEST_PATHS='' \
  RUN_TESTS_FOR_SHOP=0 \
  RUN_TESTS_FOR_MODULES=1 \
  ACTIVATE_ALL_MODULES=1 \
  vendor/bin/runtests-codeception -x <group_name>


Run with PHPStorm
^^^^^^^^^^^^^^^^^

The description how to setup Codeception on PHPStorm you can find `here <https://www.jetbrains.com/help/phpstorm/using-codeception-framework.html>`__.

**Note:** The default configuration file for the test runner is located in ``<shop_dir>/tests/codeception.yml``.