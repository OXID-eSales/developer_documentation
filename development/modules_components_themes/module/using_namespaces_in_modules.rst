.. _namespaces_shop_and_modules-20170427:

Using namespaces
================

Topics to be covered
    - The backwards compatibility layer
        * the :ref:`Unified Namespace <modules-unified_namespaces-20170526>`
        * find the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` equivalents for the old bc classes (like oxarticle)
        * how we marked classes that are not intended to be extended by a module
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
In short: we introduced namespaces in all the OXID eShop's core classes so that composer autoloader can be used.

You are able to extend the oxSomething classes (like oxarticle) in your module but we do not
recommend this for new code. When we moved the OXID eShop's oxSomething classes under namespace we not only removed the 'ox'
Prefix from the class name but gave some classes better suited names.
(e.g. the former ``sysreq`` class now is named ``OxidEsales\Eshop\Application\Controller\Admin\SystemRequirements``, all
controller classes now have the postfix 'Controller' in their name).  We will tell you how to find the new class names
a bit later in this documentation.

**NOTE:** We now did physically remove the deprecated oxSomething bc classes (by that we mean all the old OXID
eShop classes from before namespace era) while still offering backwards compatibility in case
your module still relies on the old style class names. This BC layer is planned to be removed at some future time but
you will have more than enough time to port your modules before that will happen.

**NOTE:** In order to use composer autoload, folder structure and class files needs to match the namespace (``UpperCamelCase``).


.. _modules-unified_namespaces-20170526:

The Unified Namespace (``OxidEsales\Eshop``)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The :doc:`Unified Namespace </system_architecture/unified_namespace/index>` (``OxidEsales\Eshop``) provides an edition independent namespace for module and core developers.

.. important::

 Please do not use the shop classes from the edition namespaces in your code!

**NOTE**: If you want to refer to a class name, always use the ``::class`` notation instead of using a plain string.

    Example:

.. code:: php

    $articleFromUnifiedNamespace = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    //which is equivalent to the old style
    $articleFromBcClass = oxNew('oxarticle');


Equivalents for the old bc classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

See CE file :file:`Core\Autoload\BackwardsCompatibilityClassMap.php`, which is an array mapping the :doc:`Unified Namespace </system_architecture/unified_namespace/index>`
class names to the pre OXID eShop namespace class names (what we call the bc class names here). If you write a new module,
please use the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` class names as the bc class names are deprecated and should not be used for new code.

The OXID eShop itself still uses the old bc class names in some places but this will change in the near future.


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
    composer require myvendor/mymodule:dev-master

.. _namespaces_for_modules-20221123:

Extend an OXID eShop class with a module
----------------------------------------

If you want to adjust a standard OXID eShop class with a module (let's chose ``OxidEsales\Eshop\Application\Model\Article``
formerly known as ``oxarticle`` for example), you need to extend the module class (let's say ``MyVendorMyModuleArticle``) from a :ref:`Unified Namespace <modules-unified_namespaces-20170526>` parent class
(``MyVendorMyModuleArticle_parent``). The shop creates the class chain in such a way that once your module is activated, all methods
from the ``OxidEsales\Eshop\Application\Model\Article`` are available in ``MyVendorMyModuleArticle`` and can be overwritten with module functionality.

**IMPORTANT**: It is only possible to extend shop BC and :ref:`Unified Namespace <modules-unified_namespaces-20170526>` classes. Directly extending classes from the shop edition
namespaces is not allowed and such a module can not be activated. Trying to activate it gives an error in the admin backend.

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
              "MyVendor\\MyModuleNamespace\\": "./"
          }
      }
  }

Then in the shop's root directory do

.. code:: bash

    composer config repositories.myvendor/mymodule vcs https://github.com/myvendor/mymodule
    composer require myvendor/mymodule:dev-master

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
More information can be found `here <skeleton/metadataphp/version20.html>`__.
