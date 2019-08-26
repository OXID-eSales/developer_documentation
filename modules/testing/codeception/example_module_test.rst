Example Module test
===================

Let's assume the :ref:`example module <codeception_example_module>` is installed in your shop,
:ref:`Codeceptions initialization <codeception_initialization>`
as described is done and you'd like to write a Codeception acceptance test verifying that
you see a "Hello, my shopid is 1" on the shop's start page with activated module.


Create a Cest
-------------

You can create a Cest by running the following command from inside the ``<vendor_name>/<module_name>/Tests``
directory:

.. code:: php

    php <shop_dir>/vendor/bin/codecept generate:cest acceptance CheckShopFrontend

No we have the ``<vendor_name>/<module_name>/Tests/Codeception/Acceptance/CheckShopFrontendCest.php`` Cest.

.. code:: php

    <?php

    class CheckShopFrontendCest
    {
        public function _before(AcceptanceTester $I)
        {
        }

        // tests
        public function tryToTest(AcceptanceTester $I)
        {
        }
    }

It is not yet testing anything, but we can already run it. How to run codeception tests is explained in
section :ref:`Running Codeception Tests <running-codeception-tests>`.


Add test for not logged in user case
------------------------------------

Let us add test code to check the front page.

.. code:: php

    <?php

    class CheckShopFrontendCest
    {
        public function _before(AcceptanceTester $I)
        {
        }

        // tests
        public function notLoggedInUserMessage(AcceptanceTester $I)
        {
            $I->wantToTest('message for not logged in user');
            $I->amOnPage('/');
            $I->see('Hello, my shopid is 1!');
        }
    }

Running the test should look like

::

    vagrant@oxideshop:/var/www/oxideshop$ vendor/bin/runtests-codeception
    Building Actor classes for suites: acceptance
     -> AcceptanceTesterActions.php generated successfully. 95 methods added
    \AcceptanceTester includes modules: WebDriver, \Helper\Acceptance
    Codeception PHP Testing Framework v2.5.6
    Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
    Running with seed:


    Acceptance Tests (1) ----------------------------------------------------------------------------------------------------------------------------------------------
    ✔ CheckShopFrontendCest: Test message for not logged in user (6.97s)
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------


    Time: 8.52 seconds, Memory: 4.00MB

    OK (1 test, 1 assertion)
    - XML report generated in file:///var/www/oxideshop/source/modules/myvendor/mymodule/tests/Codeception/Acceptance/_output/report.xml


Add test for logged in user case
--------------------------------

Now let's check the case of a logged in user. See :ref:`here <predefined-test-user>` for test user credentials.

We will need to:

* open the shop
* open the login box
* enter user credentials
* check the main page for the expected message.

Some of those steps can be skipped by using :ref:`OXID Codeception Page Objects <codeception-page_objects>`

To be able to use the OXID page objects, first, :ref:`OXID Codeception Modules <codeception-modules>`
should be enabled in your module codeception configuration.  Simpliest way to do this -
copy/paste the config directory from ``<shop_dir>/Tests/Codeception/config`` into ``<shop_dir>/source/modules/<vendor_name>/<module_name>/Tests/Codeception/``
and change ``params`` section of module codeception.yaml to use it:

::

    params:
    - Codeception/config/params.php

Then we can register the OXID codeception modules in the codeception.yaml as well:

::

    suites:
        acceptance:
            actor: AcceptanceTester
            path: .
            modules:
                enabled:
                    - \Helper\Acceptance
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
                    - \OxidEsales\Codeception\Module\Oxideshop:
                        depends:
                          - WebDriver
                          - Db
                    - \OxidEsales\Codeception\Module\Database:
                        config_key: 'fq45QS09_fqyx09239QQ'
                        depends: Db
                    - \OxidEsales\Codeception\Module\Translation\TranslationsModule:
                        shop_path: '%SHOP_SOURCE_PATH%'
                        paths: 'Application/views/flow'

and add the next test:

.. code:: php

    public function loggedInUserMessage(AcceptanceTester $I)
    {
        $I->wantToTest('different message for logged in user');

        $homePage = new \OxidEsales\Codeception\Page\Home($I);
        $I->amOnPage($homePage->URL);
        $I->see('Hello, my shopid is 1!');

        $homePage->loginUser('user@oxid-esales.com', 'useruser');
        $I->dontSee(\OxidEsales\Codeception\Module\Translation\Translator::translate('LOGIN'));
        $I->see('Hello, my shopid is 1 and you are ' . 'user@oxid-esales.com' . ' ;)');
    }


So now instead of manually trying to figure out all locators, forms, buttons, we just use the
``\OxidEsales\Codeception\Page\Home`` PageObject which is providing all this wrapped up in method ``loginUser``.

In this test we can also see an example of using the ``OXID's Codeception Translation module``. It will
translate the language constant to be independent from chosen language.

In section :ref:`Create own PageObject <codeception-write_own_page_objects>` you can find an example
how to create your own PageObjects,
