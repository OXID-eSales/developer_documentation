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
        ├── StartController.php


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
                "MyVendor\\MyModule\\": ""
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
            \OxidEsales\Eshop\Application\Controller\StartController::class => \MyVendor\MyModule\StartController::class,
        ],
        'controllers' => [],
        'events' => [],
        'settings' => [],
        ];

The module chain extends the StartController class and adds a greeting message.

.. code:: php

    <?php

    namespace MyVendor\MyModule;

    class StartController extends StartController_parent
    {
        public function getMyModuleGreeting()
        {
            $message = 'Hello, my shopid is ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId();
            $user = \OxidEsales\Eshop\Core\Registry::getSession()->getUser();
            if ($user && $user->getId()) {
                $message .= ' and you are ' . $user->getFieldData('oxusername') . ' ;) ';
            } else {
                $message .= '! ';
            }

            return $message;
        }
    }


.. _codeception_initialization:

Creating test structure in a module
-----------------------------------

To start with acceptance tests using Codeception in your module for the first time, you have to initialize
it by running the following command:
::

  cd <shop_dir>
  vendor/bin/codecept init Acceptance --path <module_source_directory>/<tests_folder>

When prompted, you can use :guilabel:`Codeception` as test folder's name and :guilabel:`chrome` as a webdriver.

This command creates basic structure for starting with Codeception Acceptance tests for your module: tests directory (in
our current case :guilabel:`<tests_folder>/Codeception`), a configuration file :guilabel:`codeception.yml` and default
acceptance test suite :guilabel:`Acceptance.suite.yml`.

For quick Codeception info please refer to the
`Codeception documentation <https://codeception.com/docs/GettingStarted>`__.
The next step would be to check one of our repositories to get a hands-on information
about how OXID configures and tests with Codeception:

    - `OXID eShop Module Template <https://github.com/OXID-eSales/module-template>`__
    - `OXID eShop <https://github.com/OXID-eSales/oxideshop_ce>`__.
