.. _override_eshop_functionality-20170227:

Overriding existing OXID eShop functionality
============================================

Override default OXID eShop functionality.

.. note::

   The examples described here assume that the module is already installed.

   The module installation procedure is described under :doc:`Best practice module setup for development with composer <module_setup>`.

.. note::

   **Alternative: Loading dynamic content via AJAX**

   Consider adjusting themes with dynamic content.

   For more information, see :ref:`development/modules_components_themes/theme/twig/loading-dynamic-content:Loading dynamic content via AJAX`.

.. _extending-add-to-basket-functionality-20170228:

Extending 'add to basket' functionality
---------------------------------------

In this section, the existing `"module-template" module <https://github.com/OXID-eSales/module-template>`__ will be used which logs
a product's ID when it is added to the basket.

Overriding functionality
^^^^^^^^^^^^^^^^^^^^^^^^

To override functionality, create a class in the model.

In the following, we use the "moduletemplate" module as an example.

Create a child class - ``OxidEsales\ModuleTemplate\Model\Basket`` - which should override OXID eShop class
``OxidEsales\EshopCommunity\Application\Model\Basket`` method ``addToBasket``:

.. code::

         └──moduletemplate
            └── src
               └── Model
                       └── Basket.php

.. note::

  ``moduletemplate`` - This is the root directory of the module-template.

.. note::

  You can also extend module classes, just like shop classes:
  ``\OxidEsales\ModuleTemplate\Controller\GreetingController::class => \ExampleVendor\ExampleModule\Controller\GreetingController::class``

The ``OxidEsales\ModuleTemplate\Model\Basket`` class could have contents like this:

.. code:: php

  namespace OxidEsales\ModuleTemplate\Model;
  use OxidEsales\ModuleTemplate\Service\BasketItemLogger;
  use OxidEsales\ModuleTemplate\Traits\ServiceContainer;

  class Basket extends Basket_parent
  {
      use ServiceContainer;

     /**
      * Method overrides eShop method and adds logging functionality.
      * {@inheritDoc}
      */
      public function addToBasket(
            $productID,
            $amount,
            $sel = null,
            $persParam = null,
            $override = false,
            $bundle = false,
            $oldBasketItemId = null
      ) {
            $logger = $this->getServiceFromContainer(BasketItemLogger::class);
            $logger->log($productID);

            return parent::addToBasket($productID, $amount, $sel, $persParam, $override, $bundle, $oldBasketItemId);
      }
  }

In this example, the ``addToBasket`` method is overridden and it adds logging functionality.

To override the method one needs to:

- Extend a :ref:`Unified Namespace <modules-unified_namespaces-20170526>` class - ``<className>_parent``, in this case it is ``Basket_parent``.
- Call parent method, so the chain would not be broken.

Overriding templates or blocks
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For examples of how to add/modify the template, see our Tutorials and recipes section under
:doc:`Extending a frontend user form</development/modules_components_themes/module/tutorials/frontend_user_forms>`.

Don't forget to register the files to the ``metadata.php`` as described under :ref:`development/modules_components_themes/module/tutorials/override_functionality:Adding an entry to the module metadata file`.

Autoloading module classes
^^^^^^^^^^^^^^^^^^^^^^^^^^

The `composer.json`file in the module's root directory must be created,
:ref:`the modules namespace and autoloading must be defined <module_autoload-20170926>`.

The `composer.json` file in module's root directory could look like this:

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

To register a namespace and download dependencies, in the project root directory, run the ``composer update`` command:

.. code:: bash

  composer update

Composer will generate the PSR-4 autoload file with included module. At this point OXID eShop will be able to autoload
classes.

Adding an entry to the module metadata file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OXID eShop needs to know which class should be extended. To do this, add a record in the `metadata.php`
file:

.. code:: php

  'extend' => [
    \OxidEsales\Eshop\Application\Model\Basket::class => \OxidEsales\ModuleTemplate\Model\Basket::class,
  ],

For overwriting the shop templates, or some parts of them (blocks), register your module templates in the
templates/blocks sections.

For more informtion about the ``metadata.php`` file, see :doc:`metadata.php </development/modules_components_themes/module/skeleton/metadataphp/index>`.
