.. _codeception-modules:

OXID Codeception modules and helpers
====================================

All actions and assertions that can be performed by the Actor object (``AcceptanceTester $I``) are defined in modules.
In this section you can find out how to extend the testing suite with your own actions by writing own Codeception modules.

To be able to use a Codeception module in a test suite it should be registered in the respective suite configuration yaml file.
In our case when writing Codeception tests for a module, this is the ``accceptance.suite.yml`` file.

.. code::

    modules:
        enabled:
            - <module_class_goes_here>


At the moment, following `OXID's Codeception helper modules <https://github.com/OXID-eSales/codeception-modules.git>`__
are available:

Oxideshop Module
----------------

This module will be used for some common actions like clean up database, clear cache, wait for page load,
waiting for ajax etc.

.. NOTE::
    This codeception module needs the WebDriver and the Db module to be enabled as well.
    WebDriver and Db module are standard Codeception modules. They need some parameters like the shop url or database
    credentials to work. Parameters can be supplied in ``<myvendor>/<mymodule>/Tests/Codeception/config/params.php``.

.. code::

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\Oxideshop:
                    depends:
                      - WebDriver
                      - Db
                - WebDriver:
                    url: '%SHOP_URL%'
                    browser: firefox
                    port: '%SELENIUM_SERVER_PORT%'
                    window_size: 1920x1080
                    clear_cookies: true
                - Db:
                    dsn: 'mysql:host=%DB_HOST%;dbname=%DB_NAME%;charset=utf8'
                    user: '%DB_USERNAME%'
                    password: '%DB_PASSWORD%'
                    port: '%DB_PORT%'
                    dump: '%DUMP_PATH%'
                    mysql_config: '%MYSQL_CONFIG_PATH%'
                    populate: true # run populator before all tests
                    cleanup: true # run populator before each test
                    populator: '%PHP_BIN% %VENDOR_PATH%/bin/reset-shop && mysql --defaults-file=$mysql_config --default-character-set=utf8 $dbname < $dump'


Database Module
---------------

This module will be used for changing configuration option values of the shop or deleting entries from the
database. It requires the **Codeception Db** module and the shop's config_key as parameter.

.. code::

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\Database:
                    config_key: 'fq45QS09_fqyx09239QQ'
                    depends: Db


Translator Module
-----------------

The OXID eShop themes are designed to be language independent. Instead of language specific text, the OXID language constants
are used in templates and are translated when the shop renders the output. Withe the Translator module you can keep your tests
language independent by supplying the expected OXID language constant rather than the final translation.
The Translator Module needs the shop path and the theme as parameters.

.. code::

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\Translation\TranslationsModule:
                    shop_path: '%SHOP_SOURCE_PATH%'
                    paths: 'Application/views/flow'

For example the following piece of test code would only work in german language

.. code:: php

        $I->see('Vielen Dank für Ihre Nachricht an');

whereas

.. code:: php

        $I->see(\OxidEsales\Codeception\Module\Translation\Translator::translate('DD_CONTACT_THANKYOU1'));

is language independent and the recommended way to assert texts in a test.


Context Helper
--------------

This helper class is used for page status configuration and checking, like setting the active user or checking
if a user is logged in or not.

Usage example in a test:

.. code:: php

    \OxidEsales\Codeception\Module\Context::isUserLoggedIn();


Fixtures Helper
---------------

With this helper class, test fixtures can be loaded during test bootstrap and used later while testing.
Please register the bootstrap file in the ``codeception.yml`` file.
In our :ref:`example  <codeception_example_module>` the  ``_bootstrap.php`` is located in
``<vendor_name>/<module_name>/Tests/Codeception/acceptance/_bootstrap.php``.

.. code::

    settings:
        bootstrap: _bootstrap.php

Example for ``_bootstrap.php``:

.. code:: php

        <?php
        $helper = new \OxidEsales\Codeception\Module\FixturesHelper();
        $helper->loadRuntimeFixtures(dirname(__FILE__).'/../_data/fixtures.php');
        $helper->loadRuntimeFixtures(dirname(__FILE__).'/../_data/additionaldata.php');


.. _write-own-codeception-module:



Create own Codeception module
=============================


    "All actions and assertions that can be performed by the Tester object in a class are defined in modules.
    You can extend the testing suite with your own actions and assertions by writing them into a custom module."

The `Codeception documentation <https://codeception.com/docs/06-ModulesAndHelpers>`__ gives detailed information
about how Codeception modules work. So here we will only give a short example of how to write and use a custom Codeception
module for testing an OXID eShop module.

Let's again take our :ref:`example module <codeception_example_module>` and add a module setting to the metadata.php.

.. code:: php

    'settings' => [
        [
            'group' => 'main',
            'name'  => 'myModuleSetting',
            'type'  => 'str',
            'value' => ''
        ]
    ],

Then show this string in the module message in frontend.

.. code:: php

    <?php

    namespace MyVendor\MyModule;

    class ShopControl extends ShopControl_parent
    {
        protected function processOutput($view, $output)
        {
            $output = parent::processOutput($view, $output);

            $salutation = 'Hello';
            if (\OxidEsales\Eshop\Core\Registry::getConfig()->getConfigParam('myModuleSetting')) {
                $salutation .= ' ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getConfigParam('myModuleSetting');
            }

            $message = $salutation . ', my shopid is ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId();
            $user = \OxidEsales\Eshop\Core\Registry::getSession()->getUser();
            if ($user && $user->getId()) {
                $message .= ' and you are ' . $user->getFieldData('oxusername') . ' ;) ';
            } else {
                $message .= '! ';
            }
            $output = !isAdmin() ? $message . $output : $output;

            return $output;
        }
    }


As the string is empty so far, this will not change anything for our already existing tests. We will now write another
test that checks the message with non empty setting.
And we'd like to change the setting by calling something like ``$I->changeMyModuleSettingTo('Dude')``.
Before each test, we will reset the setting to an empty string.

.. code:: php

    <?php

    class CheckShopFrontendCest
    {
        public function _before(AcceptanceTester $I)
        {
            $I->changeMyModuleSettingTo('myvendor/mymodule', 'myModuleSetting', '');
        }


Add a test case for not empty setting:

.. code:: php

    public function notLoggedInUserMessageSetting(AcceptanceTester $I)
    {
        $I->wantToTest('message for not logged in user with module setting');
        $I->changeMyModuleSettingTo('myvendor/mymodule', 'myModuleSetting', 'Dude');

        $homePage = new \OxidEsales\Codeception\Page\Home($I);
        $I->amOnPage($homePage->URL);
        $I->see('Hello Dude, my shopid is 1!');
    }

For Actor to be able changing the module setting, let's add the following Codeception module class:

.. code:: php

    <?php
    namespace MyVendor\MyModule\Tests\Codeception;

    use OxidEsales\EshopCommunity\Internal\Module\Setup\Bridge\ModuleActivationBridgeInterface;
    use OxidEsales\EshopCommunity\Internal\Module\Configuration\Bridge\ModuleConfigurationDaoBridgeInterface;
    use OxidEsales\EshopCommunity\Internal\Application\ContainerFactory;

    class SettingsModule extends \Codeception\Module
    {
        /**
         * @param string $moduleId
         * @param string $name
         * @param string $value
         */
        public function changeMyModuleSettingTo($moduleId, $name, $value)
        {
            $this->ensureModuleState($moduleId);

            $container = ContainerFactory::getInstance()->getContainer();
            $moduleConfigurationDaoBridge = $container->get(ModuleConfigurationDaoBridgeInterface::class);
            $moduleConfiguration = $moduleConfigurationDaoBridge->get($moduleId);

            if (!empty($moduleConfiguration->getModuleSettings())) {
                foreach ($moduleConfiguration->getModuleSettings() as $moduleSetting) {
                    if ($moduleSetting->getName() === $name) {
                        if ($moduleSetting->getType() === 'aarr') {
                            $value = $this->_multilineToAarray($value);
                        }
                        if ($moduleSetting->getType() === 'bool') {
                            $value = filter_var($value, FILTER_VALIDATE_BOOLEAN);
                        }
                        $moduleSetting->setValue($value);
                    }
                }

                $moduleConfigurationDaoBridge->save($moduleConfiguration);
            }

            $this->ensureModuleState($moduleId);
        }

        /**
         * Ensure module is deactivated if active, activated if inactive.
         *
         * @param string $moduleId
         */
        private function ensureModuleState($moduleId)
        {
            $container = ContainerFactory::getInstance()->getContainer();
            $shopId = \OxidEsales\Eshop\Core\Registry::getConfig()->getShopId();

            $moduleActivationBridge = $container->get(ModuleActivationBridgeInterface::class);
            $moduleWasActiveBeforeSaving = $moduleActivationBridge->isActive($moduleId, $shopId);

            if ($moduleWasActiveBeforeSaving) {
                $moduleActivationBridge->deactivate($moduleId, $shopId);
            } else {
                $moduleActivationBridge->activate($moduleId, $shopId);
            }
        }
    }

and enable it in the ``acceptance.suite.yml``:

.. code::

    modules:
        enabled:
            - \MyVendor\MyModule\Tests\Codeception\SettingsModule


Then run the codeception tests.
