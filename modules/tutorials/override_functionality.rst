.. _override_eshop_functionality-20170227:

Override existing OXID eShop functionality
==========================================

This page describes how to override default OXID eShop functionality.

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
  └── source
      └── modules
          └── oe
             └──loggerdemo
                └── Model
                    └── Basket.php

.. note::

  Here ``oe`` - module developer vendor name, ``loggerdemo`` - module name.

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
        "OxidEsales\\LoggerDemo\\": "../../../source/modules/oe/loggerdemo"
      }
    },
    "minimum-stability": "dev",
    "prefer-stable": true,
    "extra": {
      "oxideshop": {
        "target-directory": "oe/loggerdemo"
      }
    }
  }

The project `composer.json` file should have entries looking like this:

.. code:: json

  "repositories": {
      "oxid-esales/logger-demo-module": {
          "type": "path",
          "url": "source/modules/oe/loggerdemo"
      }
  },
  "require": {
      "oxid-esales/logger-demo-module": "dev-master"
  }

To register a namespace and download dependencies there is a need to run composer update command in project root directory:

.. code:: bash

  composer update

Composer will generate the PSR-4 autoload file with included module. So at this point OXID eShop will be able to autoload
classes.

Add entry to module metadata file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OXID eShop needs to know which class should be extended, to do this there is a need to add a record in `metadata.php`
file:

.. code:: php

  'extend' => [
    \OxidEsales\Eshop\Application\Model\Basket::class => \OxidEsales\LoggerDemo\Model\Basket::class,
  ],
