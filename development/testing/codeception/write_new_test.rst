Creating Codeception acceptance tests from scratch
==================================================

We will use a simple example module to explain how to write a Codeception acceptance test.

.. _codeception_example_module:

Example module
--------------

The example module has the following directory structure:

.. code::

    examplemodule
    ├── src
    .   └── Controller
    .        └── StartController.php
    ├── views
    .   └── twig
    .        └── extensions
    .            └── themes
    .                └── default
    .                    └── layout
    .                        └── header.html.twig
    ├── composer.json
    └── metadata.php


The module is named **examplevendor/examplemodule** which leads to the following **composer.json** file:

.. code:: json

    {
        "name": "examplevendor/examplemodule",
        "description": "This package contains example code.",
        "type": "oxideshop-module",
        "autoload": {
            "psr-4": {
                "ExampleVendor\\ExampleModule\\": "src/"
            }
        }
    }


It extends the **StartController** which results in the following **metadata.php** file:

.. code:: php

    <?php

    $sMetadataVersion = '2.1';

    $aModule = [
        'id' => 'examplevendor_examplemodule',
        'title' => 'Example Module',
        'description' => 'An OXID example module.',
        'extend' => [
            \OxidEsales\Eshop\Application\Controller\StartController::class => \ExampleVendor\ExampleModule\Controller\StartController::class,
        ],
    ];


Its own **StartController** builds the greeting message and sets it as a template parameter. To implement a little bit logic, it adds the user's name to the message if a user is logged in:

.. code:: php

    <?php

    declare(strict_types=1);

    namespace ExampleVendor\ExampleModule\Controller;

    use OxidEsales\Eshop\Core\Registry;

    class StartController extends StartController_parent
    {
        public function init()
        {
            parent::init();
            
            $this->addTplParam('greeting', $this->getGreetingMessage());
        }

        private function getGreetingMessage(): string
        {
            $user = Registry::getSession()->getUser();

            if ($user && $user->getId()) {
                return 'Hello ' . $user->getFieldData('oxusername') . '!';
            } else {
                return 'Hello customer!';
            }
        }
    }


It extends the template block **layout_header_bottom** from the template **layout/header.html.twig** to output the greeting message if available:

.. code:: twig

    {% extends 'layout/header.html.twig' %}

    {% block layout_header_bottom %}

        {% if greeting %}
            {{ greeting }}
        {% endif %}

        {{ parent() }}

    {% endblock %}


.. _codeception_initialization:

Creating test structure in a module
-----------------------------------

To start with acceptance tests using Codeception in your module for the first time, you have to initialize
it by running the following command:

.. code:: shell
    
    cd <shop_dir>
    ./vendor/bin/codecept init Acceptance --path <module_directory>/<tests_directory>

**Example**

.. code:: shell
    
    cd /var/www/oxideshop
    ./vendor/bin/codecept init Acceptance --path examplemodule/tests

When prompted, you should use **Codeception** as test directory's name and **chrome** as a webdriver.

This command creates basic structure for starting with Codeception Acceptance tests for your module:

* A tests directory: In our case **tests/Codeception**.
* A configuration file **codeception.yml**.
* And a default acceptance test suite **Acceptance.suite.yml**.

For quick Codeception info please refer to the
`Codeception documentation <https://codeception.com/docs/GettingStarted>`__.

The next step would be to check one of our repositories to get a hands-on information about how OXID configures and tests with Codeception:

* `OXID Module Template <https://github.com/OXID-eSales/module-template>`__
* `OXID Example Module <https://github.com/OXID-eSales/examples-module>`__
* `OXID eShop <https://github.com/OXID-eSales/oxideshop_ce>`__
