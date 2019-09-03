Creating Codeception acceptance tests from scratch
==================================================

We will use a simple example module to explain how to write a Codeception acceptance test.

.. _codeception-example-module:

Example module
--------------

Let's assume we have a simple test module ``myvendor/mymodule`` with the following structure:

::

    myvendor
    └── mymodule
        ├── composer.json
        ├── metadata.php
        └── ShopControl.php


Example module's composer.json
::

    {
        "name": "myvendor/mymodule",
        "description": "This package contains myvendor/mymodule source code.",
        "type": "oxideshop-module",
        "keywords": [
            "oxid",
            "modules",
            "eShop"
        ],
        "license": "GPL-3.0-only",
        "require": {
            "php": ">=7.0"
        },
        "autoload": {
            "psr-4": {
                "MyVendor\\MyModule\\": "../../../source/modules/myvendor/mymodule"
            }
        },
        "extra": {
            "oxideshop": {
                "target-directory": "myvendor/mymodule"
            }
        }
    }


Example module's metadata.php


.. code:: php

    <?php

    $sMetadataVersion = '2.1';

    $aModule = [
        'id'           => 'myvendor/mymodule',
        'title'        => 'MyModule',
        'description'  => [
            'de' => 'OXID Example Modul.',
            'en' => 'OXID Example Module.',
        ],
        'thumbnail'    => 'logo.png',
        'version'      => '0.0.1',
        'author'       => 'myvendor',
        'url'          => 'https://github.com/myvendor',
        'email'        => 'myvendor@mymodule.com',
        'extend'       => [
            \OxidEsales\Eshop\Core\ShopControl::class => \MyVendor\MyModule\ShopControl::class,
        ],
        'controllers' => [],
        'events' => [],
        'templates' => [],
        'blocks' => [],
        'settings' => [],
        'smartyPluginDirectories' => []
    ];

The module chain extends the ShopControl class and adds some information to output.

.. code:: php

    <?php

    namespace MyVendor\MyModule;

    class ShopControl extends ShopControl_parent
    {
        protected function processOutput($view, $output)
        {
            $output = parent::processOutput($view, $output);

            $message = 'Hello, my shopid is ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId();
            $user = \OxidEsales\Eshop\Core\Registry::getSession()->getUser();
            if ($user && $user->getId()) {
                $message .= ' and you are ' . $user->getFieldData('oxusername') . ' ;) ';
            } else {
                $message .= '! ';
            }
            $output = !isAdmin() ? $message . $output : $output;

            return $output;
        }
    }

.. _codeception_initialization:

Creating test structure in a module
-----------------------------------

To start with acceptance tests using Codeception you have to initialize them with running the following command:
::

  cd <shop_dir>
  vendor/bin/codecept init ModuleAcceptance --path source/modules/<vendor_name>/<module_name>/<tests_folder>

Example:
::

  cd <shop_dir>
  vendor/bin/codecept init ModuleAcceptance --path source/modules/myvendor/mymodule/Tests



When prompted confirm :guilabel:`Codeception` as test folder's name, :guilabel:`firefox` as webdriver or change to
better suited values in case you need it.

`Note: Run this command in case you want to initialize the tests for the first time.`

This command creates a configuration file :guilabel:`codeception.yml`, tests directory (in our current case :guilabel:`Tests/Codeception`)
and acceptance test suites. The acceptance tests come with their own configuration file named :guilabel:`acceptance.suite.yml`.


The general structure of the module's test folder looks as follows:
::

  <vendor_name>/<module_name>/Tests/Codeception/acceptance
  <vendor_name>/<module_name>/Tests/Codeception/acceptance/_data/
  <vendor_name>/<module_name>/Tests/Codeception/acceptance/_output/
  <vendor_name>/<module_name>/Tests/Codeception/acceptance/_support/
  <vendor_name>/<module_name>/Tests/Codeception/acceptance/config/
  <vendor_name>/<module_name>/Tests/Codeception/acceptance.suite.yml
  <vendor_name>/<module_name>/Tests/codeception.yml


Example:
    ::

        myvendor
        └── mymodule
            ├── composer.json
            ├── metadata.php
            ├── ShopControl.php
            └── Tests
                ├── Codeception
                │   ├── acceptance
                │   │   ├── _bootstrap.php
                │   │   └── ExampleCest.php
                │   ├── acceptance.suite.yml
                │   ├── config
                │   │   └── params.php
                │   ├── _data
                │   │   ├── dump.sql
                │   │   └── fixtures.php
                │   ├── _output
                │   └── _support
                │       ├── _generated
                │       └── Helper
                │           └── Acceptance.php
                └── codeception.yml


An example Cest named ``ExampleCest`` is created automatically which verifies that the shop frontend is working.
We'll come to actually writing tests in the next section.

Codeception configuration
-------------------------

The codeception main configuration file for the newly created module tests is the **codeception.yaml** which is
located in the ``<vendor_name>/<module_name>/Tests`` directory:

::

    params:
      - Codeception/config/params.php
    paths:
      tests: Codeception
      output: Codeception/_output
      data: Codeception/_data
      support: Codeception/_support
      envs: Codeception/_envs
      actor_suffix: Tester

    settings:
      colors: true
      log: true
      bootstrap: _bootstrap.php

    extensions:
      enabled:
        - Codeception\Extension\RunFailed


Then there is an additional configuration file (we only have **acceptance.suite.yml** for now) for each suite
containing information like enabled Codeception modules.

::

    # suite config
    actor: AcceptanceTester
    modules:
      enabled:
        - Asserts
        - WebDriver:
            url: '%SHOP_URL%'
            browser: firefox
            port: '%SELENIUM_SERVER_PORT%'
            window_size: 1920x1080
            clear_cookies: true
        - Db:
            dsn: 'mysql:host=%DB_HOST%;dbname=%DB_NAME%;charset=utf8'
            user: '%DB_USERNAME%'
            password: '%DB_PASSWORD%'
            port: '%DB_PORT%'
            dump: '%DUMP_PATH%'
            populate: true # run populator before all tests
            cleanup: true # run populator before each test
            populator: '%PHP_BIN% %VENDOR_PATH%/bin/reset-shop'
        - \OxidEsales\Codeception\Module\Oxideshop:
            depends:
              - WebDriver
              - Db
        - \OxidEsales\Codeception\Module\Database:
            config_key: 'fq45QS09_fqyx09239QQ'
            depends: Db
        - \OxidEsales\Codeception\Module\Translation\TranslationsModule:
            shop_path: '%SHOP_SOURCE_PATH%'
            paths: 'Application/views/flow'


For further details regarding the configuration of Codeception tests please refer to the
`Codeception documentation <https://codeception.com/docs/reference/Configuration>`__.
