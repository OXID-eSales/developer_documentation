Creating Codeception acceptance tests from scratch
==================================================

We will use a simple example module to explain how to write a Codeception acceptance test.

.. _codeception_example_module:

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
  php vendor/bin/codecept init acceptance --path source/modules/<vendor_name>/<module_name>/<tests_folder>

Example:
::

  cd <shop_dir>
  php vendor/bin/codecept init acceptance --path source/modules/myvendor/mymodule/Tests


Enter :guilabel:`Codeception/Acceptance` as test folder's name, :guilabel:`firefox` as webdriver and your shop url (e.g. http://www.oxideshop.local)
as the :guilabel:`start url for tests`. You should enter data which is suitable in your case.

This command creates a configuration file :guilabel:`codeception.yml` and tests directory (with name provided by you - in current case :guilabel:`Codeception/Acceptance`) and acceptance test suites.

`Note: Run this command in case you want to initialize the tests for the first time.`


The general structure of the module's test folder looks as follows:
::

  <vendor_name>/<module_name>/Tests/Codeception/Acceptance
  <vendor_name>/<module_name>/Tests/Codeception/Acceptance/_data/
  <vendor_name>/<module_name>/Tests/Codeception/Acceptance/_output/
  <vendor_name>/<module_name>/Tests/Codeception/Acceptance/_support/
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
                │   └── Acceptance
                │       ├── _data
                │       ├── LoginCest.php
                │       ├── _output
                │       └── _support
                │           ├── AcceptanceTester.php
                │           ├── _generated
                │           │   └── AcceptanceTesterActions.php
                │           └── Helper
                │               └── Acceptance.php
                └── codeception.yml


An example Cest named ``LoginCest`` is created automatically and it can be run (though it does not test anything yet).
We'll come to actually writing tests in the next section.

Codeception configuration
-------------------------

The codeception suite configuration file for the newly created module tests is the **codeception.yaml** which is
located in the ``<vendor_name>/<module_name>/Tests`` directory.

::

    # suite config
    suites:
        acceptance:
            actor: AcceptanceTester
            path: .
            modules:
                enabled:
                    - WebDriver:
                        url: <shop-url>
                        browser: firefox
                    - \Helper\Acceptance

    extensions:
        enabled: [Codeception\Extension\RunFailed]

    params:
        - env

    gherkin: []

    # additional paths
    paths:
        tests: Codeception/Acceptance
        output: Codeception/Acceptance/_output
        data: Codeception/Acceptance/_data
        support: Codeception/Acceptance/_support
        envs: Codeception/Acceptance/_envs

    settings:
        shuffle: false
        lint: true


For further details regarding the configuration of Codeception tests please refer to the
`Codeception documentation <https://codeception.com/docs/reference/Configuration/>`__.
