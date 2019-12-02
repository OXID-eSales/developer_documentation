.. _namespaces_shop_and_modules-20170427:

Using namespaces
================

Topics to be covered
    - The backwards compatibility layer
        * the :ref:`Unified Namespace <modules-unified_namespaces-20170526>`
        * find the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` equivalents for the old bc classes (like oxarticle)
        * how we marked classes that are not intended to be extended by a module
    - Module installation
        * old style (copy & paste)
        * new style (via composer)
    - How to extend the OXID eShop's namespaced classes
        * in case your module does not yet use a namespace
        * in case your module does use it's own namespace
    - Use your own namespaces in a module with OXID eShop
        * Install the module via composer or alternatively how to register your namespace in the main composer.json
        * Use own module classes
        * Use module controllers that do not simply extend existing shop functionality

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

 Please do not use the shop classes from the edition namespaces in your code! (`More info <https://oxidforge.org/en/namespaces-in-oxid-eshop-6.html>`__)

**NOTE**: If you want to refer to a class name, always use the '::class' notation instead of using a plain string.

.. code::

    Example:

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

Installing a module can be done as before by copying the module sources into the shop's module directory (old style)
and then activating the module in the shop admin backend. With namespaces in OXID eShop we have the possibility
to let composer handle retrieving and copying the module sources to the correct location for you.
You still have to activate the module in the shop admin either way.

Just create a composer.json in the module's root directory
::

  {
      "name": "myvendor/mymodule",
      "extra": {
          "oxideshop": {
              "target-directory": "myvendor/mymodule"
          }
      }
  }


Go to the shop's root directory and configure/require the module in the shop's composer.json.
::

    composer config repositories.myvendor/mymodule vcs https://github.com/myvendor/mymodule
    composer require myvendor/mymodule:dev-master

The module sources now are located in the directory modules/myvendor/mymodule. Keep in mind that any changes made
in the module directory itself will be overwritten with the next call to composer update
(composer prompts for confirm though).


Extend an OXID eShop class with a module
----------------------------------------

If you want to adjust a standard OXID eShop class with a module (let's chose ``OxidEsales\Eshop\Application\Model\Article``
formerly known as ``oxarticle`` for example), you need to extend the module class (let's say ``MyVendorMyModuleArticle``) from a :ref:`Unified Namespace <modules-unified_namespaces-20170526>` parent class
(``MyVendorMyModuleArticle_parent``). The shop creates the class chain in such a way that once your module is activated, all methods
from the ``OxidEsales\Eshop\Application\Model\Article`` are available in ``MyVendorMyModuleArticle`` and can be overwritten with module functionality.

**IMPORTANT**: It is only possible to extend shop BC and :ref:`Unified Namespace <modules-unified_namespaces-20170526>` classes. Directly extending classes from the shop edition
namespaces is not allowed and such a module can not be activated. Trying to activate it gives an error in the admin backend.

No own module namespace
^^^^^^^^^^^^^^^^^^^^^^^

Create a module class that extends ``OxidEsales\Eshop\Application\Model\Article``, for example

.. code:: php

   <?php
    # Example for a module without own namespace
    class MyVendorMyModuleArticle extends MyVendorMyModuleArticle_parent {

        public function getSize()
        {
            $originalSize = parent::getSize();

            //double the size
            $newSize = 2 * $originalSize;

            return $newSize;
        }
    }

Backwards compatible way, not recommended when writing new code:

.. code:: php

    # Register the extend class in the module's metadata.php
    # Here we extend the shop's OxidEsales\Eshop\Application\Model\Article via the bc class name
    //.....
    'extend'      => array(
        'oxarticle' => 'myvendor/mymodule/Application/Model/MyVendorMyModuleArticle'
    )
    //.....


The **recommended way to extend a shop core class with a module** in OXID eShop when the module does not support namespaces yet
is as follows:

.. code:: php

    # Register the extend class in the module's metadata.php
    //.....
    'extend'      => array(
         \OxidEsales\Eshop\Application\Model\Article::class =>
                 'myvendor/mymodule/Application/Model/MyVendorMyModuleArticle'
    )
    //.....


Use your own namespaces with OXID eShop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now create a class like before to extend a shop class but this time give it a namespace:

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

Register the class in the module's metadata,php:

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

::

  {
      "name": "myvendor/mymodule",
      "autoload": {
          "psr-4": {
              "MyVendor\\MyModuleNamespace\\": "./"
          }
      },
      "extra": {
          "oxideshop": {
              "target-directory": "myvendor/mymodule"
          }
      }
  }

Then in the shop's root directory do

::

    composer config repositories.myvendor/mymodule vcs https://github.com/myvendor/mymodule
    composer require myvendor/mymodule:dev-master

and run composer update.

In case you do not want to handle module installation with composer but copy & paste it old style into the shop's module directory,
register your module namespace directly in the shop's main composer.json:


::

   "autoload": {
        "psr-4": {
            "OxidEsales\\EshopCommunity\\": "./source",
            ....
            "MyVendor\\MyModuleNamespace\\": "./source/modules/myvendor/mymodule"
        }
    }

And then run composer update so composer can update it's autoload file.


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


Use module controllers that do not simply extend existing shop functionality
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In case you want to not only extend shop functionality in a module but for example want to introduce
a new controller that handles own form data we recommend you have a look into what changed with module
metadata version 2.0. In short: in case you want introduce controllers in your module that support namespaces
and that do not simply extend shop functionality, you need to use metadata version 2.0
and register these controller classes in the module's metadata.php file.

More information regarding this topic can be found `here <skeleton/metadataphp/version20.html>`__.
