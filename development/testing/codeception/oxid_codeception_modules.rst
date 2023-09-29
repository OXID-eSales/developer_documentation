.. _codeception-modules:

OXID Codeception modules and helpers
====================================

    "All actions and assertions that can be performed by the Tester object (``AcceptanceTester $I``) in a class are defined in modules.
    You can extend the testing suite with your own actions and assertions by writing them into a custom module."

The `Codeception documentation <https://codeception.com/docs/06-ModulesAndHelpers>`__ gives detailed information
about how Codeception modules work and how you can create your own Codeception modules.

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
    credentials to work. Parameters can be supplied in ``<myvendor>/<mymodule>/Tests/Codeception/Config/params.php``.

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
                    populator: 'mysql --defaults-file=$mysql_config --default-character-set=utf8 $dbname < $dump'
                    initial_queries:
                        - 'SET @@SESSION.sql_mode=""'


Database Module
---------------

This module will be used for changing configuration option values of the shop or deleting entries from the
database. It requires the **Codeception Db** module.

.. code::

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\Database:
                    depends: Db


Translator Module
-----------------

The OXID eShop themes are designed to be language independent. Instead of language specific text, the OXID language constants
are used in templates and are translated when the shop renders the output. Withe the Translator module you can keep your tests
language independent by supplying the expected OXID language constant rather than the final translation.
The Translator Module needs the shop path and the theme as parameters.

.. code:: yaml

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\Translation\TranslationsModule:
                    shop_path: '%SHOP_SOURCE_PATH%'
                    paths:
                        - 'Application/views/shop-theme-dir'
                    paths_admin:
                        - 'Application/views/admin_theme-dir'

For example the following piece of test code would only work in German language

.. code:: php

        $I->see('Vielen Dank für Ihre Nachricht an');

whereas

.. code:: php

        $I->see(\OxidEsales\Codeception\Module\Translation\Translator::translate('DD_CONTACT_THANKYOU1'));

is language independent and the recommended way to assert texts in a test.



Select Theme Module
-------------------

If you use page object pattern in your tests, you can run acceptance tests with different themes. This module
is responsible for activating the theme in tested shop. The Module requires database module and theme id as parameters.

.. code::

        modules:
            enabled:
                - \OxidEsales\Codeception\Module\SelectTheme:
                    depends:
                      - \OxidEsales\Codeception\Module\Database
                    theme_id: '%THEME_ID%'


Shop Setup Module
-----------------

The population of the fixture data has a very specific workflow:
- Setup the database of the shop with some initial data
- Import a sql file with data fixtures
- Create a dump file to populate and to restore the test data
- Assign the generated dump file to the codeception Db module

All these steps are already implemented in the ShopSetup codeception module and cann be activated
by adding it to your codeception suite configurations:

.. code::

    modules:
      enabled:
        - \OxidEsales\Codeception\Module\ShopSetup:
            dump: '%DUMP_PATH%'
            fixtures: '%FIXTURES_PATH%'
            license: '%license_key%'
        - Db:
        .....

**Important: The ShopSetup codeception module has to be activated before Db codeception module.**


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
``<vendor_name>/<module_name>/Tests/Codeception/Acceptance/_bootstrap.php``.

.. code::

    settings:
        bootstrap: _bootstrap.php

Example for ``_bootstrap.php``:

.. code:: php

        <?php
        $helper = new \OxidEsales\Codeception\Module\FixturesHelper();
        $helper->loadRuntimeFixtures(dirname(__FILE__).'/../_data/fixtures.php');
        $helper->loadRuntimeFixtures(dirname(__FILE__).'/../_data/additionaldata.php');


Let's assume you'd like to have and additonal test user for your module so you add the following data
into ``fixtures.php`` file.

.. code:: php

        <?php
        return [
            'myUser' => [
                'oxid' => '_myuser',
                'oxfname' => 'Milo',
                'oxlname' => 'MyUser',
                'oxusername' => 'myuser@myvendor.com',
                'oxactive' => 1,
                'oxshopid' => 1,
                'oxstreet' => 'MeineStrasse',
                'oxstreetnr' => '56',
                'oxzip' => '79098',
                'oxcity' => 'Freiburg',
                'oxcountryid' => 'a7c40f631fc920687.20179984',
                'oxboni' => '600',
                'oxcreate' => date("Y-m-d"),
                'OXREGISTER' => date("Y-m-d"),
                'OXBIRTHDATE' => date("Y-m-d"),
                'oxpassword' => md5('myuser'),
                'OXRIGHTS' => 'user'
            ],
            'myUserPassword' => [
                'password' => 'myuser'
            ]
        ];

During test bootstrap, the fixture data is loaded and ready to be used. Either write it into database
(you need the OXID Database Codeception module for this) in a Cest

.. code:: php

   $I->haveInDatabase('oxuser', \Codeception\Util\Fixtures::get('myUser'));

or access the data like

.. code:: php

   $password = \Codeception\Util\Fixtures::get('myUserPassword')['password'];
