.. _override_eshop_functionality-20170227:

Override existing OXID eShop functionality
==========================================

This page describes how to override default OXID eShop functionality.

.. _extending-add-to-basket-functionality-20170228:

Extending add to basket functionality
-------------------------------------

In this section it will be used existing `demo module <https://github.com/OXID-eSales/loggerdemo>`__ which logs
product id when product is added to basket.

Override functionality
^^^^^^^^^^^^^^^^^^^^^^

To override functionality there is a need to create a module class. Logger demo module example will be used as an example:

There is a need to create a child class - ``OxidEsales\LoggerDemo\Model\Basket`` which should override OXID eShop class
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

``OxidEsales\LoggerDemo\Model\Basket`` class could have contents like this:

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

In this example method ``addToBasket`` is overrided and it adds additional functionality - logging.
To override class method there is a need:

- To extend a virtual class - ``className_parent``, in this case it is ``Basket_parent``.
- To call parent method, so the chain would not be broken.

Autoload module classes
^^^^^^^^^^^^^^^^^^^^^^^

`composer.json` in module root directory must be created as described :ref:`here <copy_module_via_composer-20170217>`
and module namespace must be defined as described :ref:`here <namespace-20170218>`.

`composer.json` file in module root directory could look like this:

.. code:: json

  {
    "name": "oxid-esales/logger-demo-module",
    "description": "This package contains demo module for OXID eShop.",
    "type": "oxideshop-module",
    "keywords": ["oxid", "modules", "eShop", "demo"],
    "homepage": "https://www.oxid-esales.com/en/home.html",
    "license": [
      "GPL-3.0",
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

Project composer.json file should have an entries looking like this:

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

Composer will generate psr 4 autoload file with included module. So at this point OXID eShop will be able to autoload
classes.

Add entry to metadata.php
^^^^^^^^^^^^^^^^^^^^^^^^^

OXID eShop needs to know which class should be extended, to do this there is a need to add a record in `metadata.php`
file:

.. code:: php

  'extend' => [
    \OxidEsales\Eshop\Application\Model\Basket::class => \OxidEsales\LoggerDemo\Model\Basket::class,
  ],
