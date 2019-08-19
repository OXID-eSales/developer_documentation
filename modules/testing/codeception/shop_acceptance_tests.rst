(Shop) Codeception acceptance tests
===================================

The structure of the (shop's) Codeception acceptance test folder looks as follows:

::

  <shop_or_module_dir>/tests/Codeception/_data/
  <shop_or_module_dir>/tests/Codeception/_output/
  <shop_or_module_dir>/tests/Codeception/_support/
  <shop_or_module_dir>/tests/Codeception/acceptance
  <shop_or_module_dir>/tests/Codeception/config
  <shop_or_module_dir>/tests/Codeception/acceptance.suite.yml
  <shop_or_module_dir>/tests/codeception.yml


The global codeception configuration file for the shop tests is the **codeception.yaml** which is
located in the ``<shop_dir>/tests`` directory.

::

    namespace: <test_namespace>
    params:
        - Codeception/config/params.php
    paths:
        # where the tests are stored
        tests: Codeception

        # directory for output
        output: Codeception/_output

        # directory for fixture data
        data: Codeception/_data

        # directory for support code
        support: Codeception/_support

        # directory for environment configuration
        envs: Codeception/_envs

    actor_suffix: Tester
    settings:
        bootstrap: _bootstrap.php
        colors: true
        log: true
    extensions:
        enabled:
            - Codeception\Extension\RunFailed

The shop's Codeception acceptance test suite's configuration file is the ``<shop_dir>/tests/Codeception/acceptance.suite.yml``.
Each suite configuration is named like suitename.suite.yml. For example Codeception module configuration goes here.

For further details regarding the configuration of Codeception tests please refer to the
`Codeception documentation <https://codeception.com/docs/reference/Configuration/>`__.
