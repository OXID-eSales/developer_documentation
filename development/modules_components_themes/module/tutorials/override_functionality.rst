.. _override_eshop_functionality-20170227:

Override existing OXID eShop functionality
==========================================

This page describes how to override default OXID eShop functionality.


.. note::

  Examples described here are made in the already installed module. Module installation procedure is described :doc:`here <module_setup>`.

.. _extending-add-to-basket-functionality-20170228:

Extending 'add to basket' functionality
---------------------------------------

In this section the existing `"moduletemplate" module <https://github.com/OXID-eSales/module-template>`__ will be used which logs
a product's id when it is added to the basket.

Override functionality
^^^^^^^^^^^^^^^^^^^^^^

To override functionality there is a need to create a module class.
Here, the "moduletemplate" module will be used as an example.

There is a need to create a child class - ``OxidEsales\ModuleTemplate\Model\Basket`` - which should override OXID eShop class
``OxidEsales\EshopCommunity\Application\Model\Basket`` method ``addToBasket``:

.. code::

  .
         └──moduletemplate
            └── Model
                └── Basket.php

.. note::

  ``moduletemplate`` - module name.

.. note::

  You can also extend module classes, just like shop classes:
  ``\OxidEsales\ModuleTemplate\Controller\GreetingController::class => \ExampleVendor\ExampleModule\Controller\GreetingController::class``

The class ``OxidEsales\ModuleTemplate\Model\Basket`` could have contents like this:

.. code:: php

  namespace OxidEsales\ModuleTemplate\Model;
  use OxidEsales\ModuleTemplate\Service\BasketItemLoggerInterface;
  use OxidEsales\ModuleTemplate\Traits\ServiceContainer;

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
          $basketItemLogger = $this->getServiceFromContainer(BasketItemLoggerInterface::class);
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
    "name": "oxid-esales/module-template",
    "description": "This package contains module template for OXID eShop.",
    "type": "oxideshop-module",
    "keywords": ["oxid", "modules", "eShop", "demo"],
    "homepage": "https://www.oxid-esales.com/en/home.html",
    "license": [
      "GPL-3.0-only",
      "proprietary"
    ],
    "require": {
      "php": "^8.0 | ^8.1",
      "symfony/filesystem": "^6.0"
    },
    "autoload": {
      "psr-4": {
        "OxidEsales\\ModuleTemplate\\": "src/",
        "OxidEsales\\ModuleTemplate\\Tests\\": "tests/"
      }
    },
    "minimum-stability": "dev",
    "prefer-stable": true
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

Your GitHub test job might failed due to exception (Basket extends unknown class Basket_parent). To avoid this failure create alias for basket class as shown below.

.. code:: php

  class_alias(
    \OxidEsales\Eshop\Application\Model\Basket::class,
    \OxidEsales\ModuleTemplate\Model\Basket_parent::class
  );

For overwriting the shop templates, or some parts of them (blocks), register your module templates in the
templates/blocks sections. Read more about the ``metadata.php`` under the link for the
latest version here: :doc:`here </development/modules_components_themes/module/skeleton/metadataphp/index>`.
