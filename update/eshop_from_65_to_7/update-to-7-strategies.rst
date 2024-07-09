Updating modules and shop to work with OXID 7
=============================================

There are multiple ways how to to update shop version 6 code to be compatible with version 7,
depending on your current situation one way might work better than the other.

In this section we'll point out different ideas, but in the end you need to decide which approach fits best for you.

Before we come to this, we put a section of changes that need to be applied to a module in order to fit for OXID 7,
but it can already be done for a OXID 6.5 compatible module. Please first read the whole section here and then decide
which way to start.


.. _make_the_module_fit-20240709:

The 'make the module fit' steps
-------------------------------

The following changes can be applied in 6.5 as well as 7.

* Before you start, add tests. The higher the test coverage, the less issues you will have.
  After each step of refactoring make your tests pass again.

* Does the module use OnActivate/OnDeativate methods to update the database schema? Please extract this part into a migration and run
  migrations command after composer install or update. All migrations are tracked in the database and only executed once,
  so it's totally safe to use them. Only thing to keep in mind: never ever change a migration after it was released.
  In case your module needs further database changes, add a new migration but never change you module's migrations
  once they belong to a tagged version.

* Refactor module entry points into controllers. In OXID eShop up to latest version 6, as module code is duplicated into source/modules folder,
  it is possible to directly invoke a script residing in this directory.

  .. code:: php
     https://myoxideshop.com/modules/moduledir/moduleendpoint.php

  Please change this into a shop controller, which then can be invoked like

  .. code:: php
     https://myoxideshop.com/index.php?cl=moduleendpoint

  See `:ref:_module-controllers-20170427`

* From OXID eShop 7.0 on, only metadata version 2.0 is supported, see `:ref:update/eshop_from_65_to_7/modules.html#port-to-v7-metadata-20221123`
  This means: the module must have namespaces, namespace needs to point to vendor directory.
  Move module sourcecode into src folder and adapt namespace pointer. This is not strictly necessary, but we recommend a clean structure.

  Example
  .. code:: php
     "autoload": {
        "psr-4": {
            "OxidEsales\\ModuleTemplate\\": "src/",
            "OxidEsales\\ModuleTemplate\\Tests\\": "tests/"
        }
      },

* Clean up module settings handling. Older shops were not very strictly distinguishing where a config variable originated from
  (shop, theme, module), it was usually accessed via

  .. code:: php

     \OxidEsales\Eshop\Core\Registry::getConfig()->getConfigParam('someConfigParam')

  There's an interface in Shop 6.5
  .. code:: php

     OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Bridge\ModuleSettingBridgeInterface

    The recommended and future proof way here is to implement a ModuleSettingsService in the module and retrieve/save
    settings only through it. You'll find an example in our module template for OXID 6.5
    `https://github.com/OXID-eSales/module-template/blob/v2.1.0/src/Service/ModuleSettings.php`
    We did improve this part for OXID 7 (as module template gets regular best practices updates)
    `https://github.com/OXID-eSales/module-template/blob/v3.0.0/src/Settings/Service/ModuleSettingsServiceInterface.php`
    but the service itself did not change. Neither do the places the settings get actually used need a change as
    the module's logic only need to access the shop settings logic in one central place in this example.

* Clean up the module's source code. In case of module grown from the early OXID 6 versions have a tendency to have a
  lot of their business logic  built into what we call 'chain extended' classes.
  We recommend to disentangle the module's business logic from the places where it's hooked into the shop.
  This is a recommendation not a must, but it will help to make your code future proof and easier to maintain in the long run.
  The idea is to build your module logic as far separated from the shop as possible and only in an infrastructure layer access the shop core.
  This is not so easy in case you extend shop models or controller, but still you should evaluate the possibility of encapsulating
  your logic in a service and have the extended class call that service. Get some ideas from what we started doing with Dependency Injection.
  Even in case you need to chain extend a shop class in order to hook into an existing method and change that method's logic, put
  your new code in a service, call logic from that service, then call perent method.
  Please refer to our module template for detailed examples.

* Do not access module assets (css, js, images) directly in templates like you would the odl fashioned module endpoint,
  rather make use of OxidEsales\Eshop\Core\ViewConfig::getModuleUrl()
  .. code:: php

    $oViewConf->getModuleUrl('mymodule','relative/path/to/some.css')

* Whichever of the above points you changed: make your tests pass again.


The 'last minute switch' strategy
---------------------------------

Stay on latest Shop version 6 for as long as possible and prepare shop, theme and modules to fit as good a possible
for OXID 7.

* Do not use jquery, use vanilla Javascript, it makes the change from smarty to twig engine easier.


Only then run the update process as described in :ref:`update/eshop_from_65_to_7/update-to-7.0:Updating from OXID eShop 6.5 to OXID eShop 7.0`.



The 'early bird' strategy
-------------------------

This was the approach we used in OXID internally to update our modules to work with OXID eShop 7.
In order for this to work, the module to be updated needs to have a decent test coverage. Without unit, integration
and acceptance tests in place for the 6.5 compatible module version this will be a risky business.

So we rig up a fresh OXID 7.0 with Smarty template engine and first ensure that the module in question can be
installed in the new shop.
* Which means the dependencies listed in the module's composer.json need to fit OXID eShop 7.0 system requirements
  like PHP version, Symfony components etc.
* Also from OXID eShop 7.0 on, only metadata version 2.0 is supported, see `:ref:update/eshop_from_65_to_7/modules.html#port-to-v7-metadata-20221123`
  The module code is no longer duplicated into source/modules, so the 'extra' section part in composer.json
  specifying the target directory can be removed now. See example below, it can just be removed from metadata.php now.

  .. code:: php
          "extra": {
                "oxideshop": {
                    "target-directory": "oe/moduletemplate",
                    "blacklist-filter": [
                        "source/**/*",
                        "vendor/**/*"
                    ]
                }
            },

Once the module is installed, the next step is to make it activatable.
See Checklist `:ref:_make_the_module_fit-20240709` for nesessary preparation steps.
* In OXID 7, module settings are no longer stored in the oxconfig table, they are fetched by a service from yaml files
  (cache first, files second) and are written into yaml files. Keep this in mind when working with settings.
* The module already comes with migrations? Beware, the migrations need a little update, see
   :ref:`update/eshop_from_65_to_7/modules.html#port-to-v7-migrations-20221123`
* About module settings:
  The interface we recommended to use in `:ref:_make_the_module_fit-20240709`
  `OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Bridge\ModuleSettingBridgeInterface`
  is still around in OXID 7 but it's deprecated. Please update to use the newest one
  `OxidEsales\EshopCommunity\Internal\Framework\Module\Facade\ModuleSettingServiceInterface`.
* Move assets into assets directory. As module code is no longer duplicated, another way to make images, css and js
  available is to move them in the assets folder. Please access them in templates via oViewCon::getModuleUrl() method
  as stated earlier.
* Check for usages of deprecated, removed or changed shop classes in your module and udpate those places.
* Run your unit and integration tests, they should point out the most urgend problems. Fix those places.
* Try activating the module via console-command until you get an ok response.

Now it's time for taking care of the frontend. We recommend you switch to the Twig Engine but in the first step,
the best approach might be to first make the module work with smarty engine as you already have smarty templates
for the 6.5 version.
Installation of smarty eninge is described in section `:ref:



* Do not use jquery, use vanilla Javascript, it makes the change from smarty to twig engine easier.






