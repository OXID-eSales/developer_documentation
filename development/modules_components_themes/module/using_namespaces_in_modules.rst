.. _namespaces_shop_and_modules-20170427:

Using namespaces
================

Topics to be covered
    - the :ref:`Unified Namespace <modules-unified_namespaces-20170526>`
    - how we marked classes that are not intended to be extended by a module
    - Module installation
    - How to extend the OXID eShop's namespaced classes
    - Use your own namespaces in a module with OXID eShop
        * Install the module via composer
        * Use own module classes
        * Add new module controllers

.. _bclayer-20170426:

Introduction
------------

The following part of the documentation will cover the namespaces and what this means for a module developer.

In order to use composer autoload, folder structure and class files needs to match the namespace (``UpperCamelCase``).


.. _modules-unified_namespaces-20170526:

The Unified Namespace (``OxidEsales\Eshop``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The :doc:`Unified Namespace </system_architecture/unified_namespace/index>` (``OxidEsales\Eshop``) provides an edition independent namespace for module and core developers.

.. important::

 Please do not use the shop classes from the edition namespaces in your code!

If you want to refer to a class name, always use the ``::class`` notation instead of using a plain string.

Example:

.. code:: php

    $articleFromUnifiedNamespace = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);


Classes that are not to be extended by a module
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We mark all classes that are not to be overwritten by a module with **@internal** but apart from that
there is currently no mechanism that prevents a module developer from trying to extend such a shop class. We do not guarantee
that the shop will work as expected if you try to do that though. What can definitely not be extended by a module is the
``OxidEsales\Eshop\Core\UtilsObject`` class.


Module installation
-------------------

Go to the shop's root directory and configure/require the module:

.. code:: bash

    composer config repositories.myvendor/mymodule vcs https://github.com/myvendor/mymodule
    composer require myvendor/mymodule:dev-main

.. _namespaces_for_modules-20221123:

Extend an OXID eShop class with a module
----------------------------------------

If you want to adjust a standard OXID eShop class with a module (let's choose ``OxidEsales\Eshop\Application\Model\Article``), you need to extend the module class (let's say ``MyVendorMyModuleArticle``) from a :ref:`Unified Namespace <modules-unified_namespaces-20170526>` parent class
(``MyVendorMyModuleArticle_parent``). The shop creates the class chain in such a way that once your module is activated, all methods
from the ``OxidEsales\Eshop\Application\Model\Article`` are available in ``MyVendorMyModuleArticle`` and can be overwritten with module functionality.

Now create a class to extend a shop class in your module's namespace:

.. code:: php

   <?php
    # Example for module with own namespace

    namespace MyVendor\MyModuleNamespace\Application\Model;

    class MyModuleArticle extends MyModuleArticle_parent
    {
        public function getSize()
        {
            $originalSize = parent::getSize();

            //double the size
            $newSize = 2 * $originalSize;

            return $newSize;
        }
    }

Register the class in the module's metadata.php:

.. code:: php

    # Register the extend class in the module's metadata.php
    //.....
    'extend'      => array(
         \OxidEsales\Eshop\Application\Model\Article::class =>
              MyVendor\MyModuleNamespace\Application\Model\MyModuleArticle::class
    )
    //.....

Install and register your module with composer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To have the composer autoloader find your module file via namespace, create a composer.json file in the module's
root directory.

.. code:: json

  {
      "name": "myvendor/mymodule",
      "autoload": {
          "psr-4": {
              "MyVendor\\MyModuleNamespace\\": "./src"
          }
      }
  }

Then in the shop's root directory do

.. code:: bash

    composer config repositories.myvendor/mymodule vcs https://github.com/myvendor/mymodule
    composer require myvendor/mymodule:dev-main

and run composer update.

Using namespaces in module classes that do not extend OXID eShop classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Add for example a model class to your module:

.. code:: php

    <?php
    namespace MyVendor\MyModuleNamespace\Application\Model;

    class MyModuleModel
    {
        public function doSomething()
        {
            //.....
            // do something
            //......
            return $someResult;
        }
    }

There is no need to register this class in the metadata.php as the composer autoloader will
do the trick.


.. code:: php

   <?php
    namespace MyVendor\MyModuleNamespace\Application\Controller;

    use MyVendor\MyModuleNamespace\Application\Model\MyModuleModel;

    class MyModulePaymentController extends MyModulePaymentController_parent
    {
        public function render()
        {
            $template = parent::render();
            //.....
            $model = new MyModuleModel;
            $someResult = $model->doSomething();
            // do something else
            //......
            return $template;
        }


or with oxNew instead of new

.. code:: php

   <?php
    namespace MyModuleNamespace/Application/Controller;

    class MyModulePaymentController extends MyModulePaymentController_parent
    {
        public function render()
        {
            $template = parent::render();
            //.....
            $model = oxNew(\MyVendor\MyModuleNamespace\Application\Model\MyModuleModel::class);
            $someResult = $model->doSomething();
            // do something else
            //......
            return $template;
        }

In the module's metadata you only need to register the class extending the shop's payment controller but not your module's
new model class.

.. code:: php

    # Register the extend class in the module's metadata.php
    //.....
    'extend'      => array(
         \OxidEsales\Eshop\Application\Controller\PaymentController::class
             => MyVendor\MyModuleNamespace\Application\Controller\MyModulePaymentController::class
    )
    //.....


Add new module controllers
^^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to introduce a new controller that handles own form data you need to register its class in the module's :file:`metadata.php`.
More information can be found `here <skeleton/metadataphp/index.html>`__.
