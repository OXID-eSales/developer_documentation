.. _codeception-modules:

OXID Codeception modules and helpers
====================================

All actions and assertions that can be performed by the Actor object (``AcceptanceTester $I``) are defined in modules.
We will show later how you can extend the testing suite with your own actions by writing own Codeception modules.

To be able to use a Codeception module in a test suite it should be registered in the respective suite configuration yaml file.
In our case when writing Codeception tests for a module, this is the ``codeception.yml`` file.

.. code::

    modules:
        enabled:
            - <module_class_goes_here>


Currently the following `OXID's Codeception helper modules <https://github.com/OXID-eSales/codeception-modules.git/>`__
are available:

Oxideshop Module
----------------

This module will be used for some common actions like clean up database, clear cache, wait for page load,
waiting for ajax etc.

NOTE: This codeception module needs the WebDriver and the Db module to be enabled as well.
WebDriver and Db module are standardCodeception modules. They need some parameters like the shop url or database
credentials to work. Parameters can be supplied as :ref:`described here <oxid_codeception_module_parameters>`.

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
database. It needs the Codeception Db module and the shop's config_key as parameter.

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
In our :ref:`example  <_codeception_example_module>` the  ``_bootstrap.php`` has to be located in
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