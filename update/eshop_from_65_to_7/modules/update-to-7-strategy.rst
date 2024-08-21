Updating modules to work with OXID 7
====================================

This section will give some ideas how to adapt an existing module to work with OXID 7.
Of course you can just take your module, make it installable in OXID 7 and then adapt it step by step until the module
works as intended.

Mind you, we are talking about updating an existing product ready module, so we can assume that the starting point is
a module that is compatible to latest OXID eShop 6.5. You can make your update life easier by preparing
the module in OXID 6.5 to make the final switch to OXID 7 easier.

Please first read the whole section here and then decide which way to start.

.. _make_the_module_fit-20240709:

Steps to make the module fit
----------------------------

The following changes can be applied in 6.5 as well as 7 but as stated above, we recommend to stay in OXID 6.5 for now.
Use the highest supported PHP version for the OXID 6.5 installation.

* Before you start, add tests. The higher the test coverage, the less issues you will have.
  After each step of refactoring make your tests pass again. In case your module is not yet covered with tests at all: start by
  adding acceptance (codeception) tests. As many as you need to fully test the module's 'visible' functionality. Add unit and integration tests when refactoring code.
  Codeception tests will serve to verify refactoring did not break the module. When the module code is then sufficiently
  covered by unit and integration tests, you can start to remove excess acceptance tests as those are way slower than units/integrations.

  .. todo: #HR: we should add tutorial how to write tests, how to use OXID's codeception modules and objects, how to run tests, ...

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

  See :ref:`Module Controllers <module-controllers-20170427>` for details.

* From OXID eShop 7.0 on, only :ref:`metadata version 2.0<port_to_v7-metadata-20221123>` is supported.
  This means: the module must have namespaces, namespace needs to point to vendor directory.
  Move module sourcecode into src folder and adapt namespace pointer. This is not strictly necessary, but we recommend a clean structure.

  Example:
        .. code:: json

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

        \OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Bridge\ModuleSettingBridgeInterface

  The recommended and future proof way here is to implement a ModuleSettingsService in the module and retrieve resp. save
  settings only through it. You'll find an example in our module template for OXID 6.5 `module template for OXID 6.5 <https://github.com/OXID-eSales/module-template/blob/v2.1.0/src/Service/ModuleSettings.php>`__
  We did improve `this part <https://github.com/OXID-eSales/module-template/blob/v3.0.0/src/Settings/Service/ModuleSettingsServiceInterface.php>`__ for OXID 7 (as module template gets regular best practices updates) but the service itself did not change.
  Neither do the places the settings get actually used need a change as the module's logic only need to access the shop settings logic in one central place in this example.

* Clean up the module's source code. In case of module grown from the early OXID 6 versions have a tendency to have a
  lot of their business logic  built into what we call 'chain extended' classes.

  We recommend to disentangle the module's business logic from the places where it's hooked into the shop.
  This is a recommendation not a must, but it will help to make your code future proof and easier to maintain in the long run.

  The idea is to build your module logic as far separated from the shop as possible and only in an infrastructure layer access the shop core.
  This is not so easy in case you extend shop models or controller, but still you should evaluate the possibility of encapsulating
  your logic in a service and have the extended class call that service.

  Get some ideas from what we started doing with Dependency Injection. Even in case you need to chain extend a shop class in order to hook
  into an existing method and change that method's logic, put your new code in a service, call logic from that service, then call parent method.
  Please refer to our module template for detailed examples. Add interfaes and implement them. Learn about S.O.L.I.D principles.

* Do not access module assets (css, js, images) directly in templates like you would the old fashioned module endpoint,
  rather make use of OxidEsales\Eshop\Core\ViewConfig::getModuleUrl()

  .. code:: php

    $oViewConf->getModuleUrl('mymodule','relative/path/to/some.css')

* Whichever of the above points you changed: make your tests pass again. Regarding acceptance tests, rewrite them to use
  codeception, make as much use as possible of OXID's codeception-modules and codeception-page-objects.

Concerning templates
--------------------

The template engine for OXID eShop 6.5 is Smarty, the official Template Engine from OXID eShop 7.0 on is the Twig Engine
with APEX theme.

We recommend you switch to the Twig Engine but in the first step,
the best approach in case you are not yet fully familiar with twig might be to first make the module work with
smarty engine. You should have smarty templates for the 6.5 version so you we can go from there.

.. _steps_on_seven-20240710:

Steps to take on OXID 7
-----------------------

Install OXID eShop 7 with Smarty engine, add your module. Installation of smarty engine is described in
:ref:`update/eshop_from_65_to_7/install_smarty_engine:Switching to the legacy Smarty template engine`.

* Ensure that the module in question can be installed via composer in OXID eShop 7.0. Dependencies listed in the module's composer.json need to fit OXID eShop 7.0 system requirements like PHP version, Symfony components etc.
  Please make sure that the packages your module depemnds on are listed in that module's composer.json. Do not rely on some otehr cojponent in the metapackage requiring it for your module.

* Also from OXID eShop 7.0 on, as already mentioned above, only :ref:`metadata version 2.0<port_to_v7-metadata-20221123>` is supported.
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
  See :ref:`make_the_module_fit-20240709` for nesessary preparation steps.

* In OXID 7, module settings are no longer stored in the oxconfig table, they are fetched by a service from yaml files (cache first, files second) and are written into yaml files. Use the dedicated service to handle moduel settings.

* The module already comes with migrations? Beware, the migrations need a little update, see :ref:`port_to_v7-migrations-20221123`.

* About module settings: The interface we recommended to use in :ref:`make_the_module_fit-20240709`

  .. code:: php

      OxidEsales\EshopCommunity\Internal\Framework\Module\Configuration\Bridge\ModuleSettingBridgeInterface

  is still around in OXID 7 but it's deprecated. Please update to use the newest interface

  .. code:: php

     OxidEsales\EshopCommunity\Internal\Framework\Module\Facade\ModuleSettingServiceInterface

* Move assets into assets directory. As module code is no longer duplicated, another way to make images, css and js
  available is to move them in the assets folder. Please access them in templates via oViewCon::getModuleUrl() method
  as stated earlier.

* Check for usages of deprecated, removed or changed shop classes in your module and udpate those places.
  See :ref:`port_to_v7-removed-functions-20221123` for more information. Try out the mentioned rector and update tools,
  it's a big help.

* Run your unit and integration tests, they should point out the most urgent problems. Fix those places.

* Try activating the module via console-command until you get an ok response.

* Smarty templates are registered in the module's metadata.php, you need to adapt the paths to be relative to the module's root directory and add the module's template namespace. See examples below for comparison.

    .. code:: php

        //OXID 6.5 metadata.php example for Smarty module templates
        'templates'   => [
            'greetingtemplate.tpl' => 'oe/moduletemplate/views/templates/greetingtemplate.tpl',
        ],
         'blocks'      => [
            [
                'template' => 'page/shop/start.tpl',
                'block' => 'start_welcome_text',
                'file' => 'views/blocks/oemt_start_welcome_text.tpl'
            ]
        ],

    .. code:: php

        //OXID 6.5 usage of module own template
        class GreetingController extends FrontendController
        {
            ...
            protected $_sThisTemplate = 'greetingtemplate.tpl';

    Comparision for OXID eShop 7.0

    .. code:: php

        //OXID 7.0 example for Smarty mdoule templates
       'templates'   => [
            '@oe_moduletemplate/templates/greetingtemplate.tpl' => 'views/smarty/templates/greetingtemplate.tpl'
        ],
        'blocks'      => [
            [
                'template' => 'page/shop/start.tpl',
                'block' => 'start_welcome_text',
                'file' => 'views/smarty/blocks/oemt_start_welcome_text.tpl'
            ]
        ],

    .. code:: php

        //OXID 7.0 usage of module own template
        class GreetingController extends FrontendController
        {
           ...
            protected $_sThisTemplate = '@oe_moduletemplate/templates/greetingtemplate';

    Check the shop frontend/admin backend to verify whether your module is working as expected.
    Run your aceptance tests. OXID's Testing Library is deprecated but still usable for version 7.

.. _converting_smarty_to_twig-20240710:

Converting templates from smarty to twig
----------------------------------------

Prerequisites is that you have a theme that supports the twig template engine. Use APEX in case you want
to stick to the standard, convert your own theme to twig otherwise.

* Have a look at how twig inheritance is working in OXID 7
  :doc:`Twig Template Engine </development/modules_components_themes/module/using_twig_in_module_templates>`.
  The templates are no longer registered in metadata.php, but now they need to follow the twig theme structure in case
  of extending theme templates.

* Use OXID's `Smarty to Twig Converter <https://github.com/OXID-eSales/smarty-to-twig-converter>`__ to convert
  the module's templates from smarty to twig. Read the converter repo's README.md, it contains information about
  differences between OXID's smarty and twig templates.







