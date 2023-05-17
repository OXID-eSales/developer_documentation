.. _override_eshop_functionality-20170227:

Override existing OXID eShop functionality
==========================================

This page describes how to override default OXID eShop functionality.


.. note::

  Examples described here are made in the already installed module. Module installation procedure is described :doc:`here <module_setup>`.

.. _extending-add-to-basket-functionality-20170228:

Extending 'add to basket' functionality
---------------------------------------

In this section the existing `"loggerdemo" module <https://github.com/OXID-eSales/logger-demo-module>`__ will be used which logs
a product's id when it is added to the basket.

Override functionality
^^^^^^^^^^^^^^^^^^^^^^

To override functionality there is a need to create a module class.
Here, the "loggerdemo" module will be used as an example.

There is a need to create a child class - ``OxidEsales\LoggerDemo\Model\Basket`` - which should override OXID eShop class
``OxidEsales\EshopCommunity\Application\Model\Basket`` method ``addToBasket``:

.. code::

  .
         └──loggerdemo
            └── Model
                └── Basket.php

.. note::

  ``loggerdemo`` - module name.

.. note::

  You can also extend module classes, just like shop classes:
  ``\OxidEsales\ModuleTemplate\Controller\GreetingController::class => \ExampleVendor\ExampleModule\Controller\GreetingController::class``

The class ``OxidEsales\LoggerDemo\Model\Basket`` could have contents like this:

.. code:: php

  namespace OxidEsales\LoggerDemo\Model;
  use OxidEsales\EventLoggerDemo\BasketItemLogger;

  class Basket extends Basket_parent
  {
      public function addToBasket(
          $productID,
          $amount,
          $sel = null,
          $persParam = null,
          $override = false,
          $bundle = false,
          $oldBasketItemId = null
      ) {
          $basketItemLogger = new BasketItemLogger($this->getConfig()->getLogsDir());
          $basketItemLogger->logItemToBasket($productID);
          return parent::addToBasket($productID, $amount, $sel, $persParam, $override, $bundle, $oldBasketItemId);
      }
  }

In this example method ``addToBasket`` is overridden and it adds logging functionality.
To override the method one needs to:

- Extend a :ref:`Unified Namespace <modules-unified_namespaces-20170526>` class - ``<className>_parent``, in this case it is ``Basket_parent``.
- Call parent method, so the chain would not be broken.

Override templates or blocks
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For some example how to add/modify the template, check our Tutorials and recipes section
:doc:`here</development/modules_components_themes/module/tutorials/frontend_user_forms>`

Don't forget to register the files to the ``metadata.php`` like described :ref:`here<add_entry_to_module_metadata-20220211>`.

Autoload module classes
^^^^^^^^^^^^^^^^^^^^^^^

The file `composer.json` in module root directory must be created,
:ref:`the modules namespace and autoloading must be defined <module_autoload-20170926>`.

The `composer.json` file in module root directory could look like this:

.. code:: json

  {
    "name": "oxid-esales/logger-demo-module",
    "description": "This package contains demo module for OXID eShop.",
    "type": "oxideshop-module",
    "keywords": ["oxid", "modules", "eShop", "demo"],
    "homepage": "https://www.oxid-esales.com/en/home.html",
    "license": [
      "GPL-3.0-only",
      "proprietary"
    ],
    "require": {
      "oxid-esales/event_logger_demo": "dev-master"
    },
    "autoload": {
      "psr-4": {
        "OxidEsales\\LoggerDemo\\": ""
      }
    },
    "minimum-stability": "dev",
    "prefer-stable": true
  }

The project `composer.json` file should have entries looking like this:

.. code:: json

    {
      "repositories": {
          "oxid-esales/logger-demo-module": {
              "type": "path",
              "url": "loggerdemo-source-path"
          }
      },
      "require": {
          "oxid-esales/logger-demo-module": "dev-master"
      }
    }

To register a namespace and download dependencies there is a need to run composer update command in project root directory:

.. code:: bash

  composer update

Composer will generate the PSR-4 autoload file with included module. So at this point OXID eShop will be able to autoload
classes.

.. _add_entry_to_module_metadata-20220211:

Add entry to module metadata file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OXID eShop needs to know which class should be extended, to do this there is a need to add a record in `metadata.php`
file:

.. code:: php

  'extend' => [
    \OxidEsales\Eshop\Application\Model\Basket::class => \OxidEsales\LoggerDemo\Model\Basket::class,
  ],

For overwriting the shop templates, or some parts of them (blocks), register your module templates in the
templates/blocks sections. Read more about the ``metadata.php`` under the link for the
latest version here: :doc:`here </development/modules_components_themes/module/skeleton/metadataphp/index>`.
