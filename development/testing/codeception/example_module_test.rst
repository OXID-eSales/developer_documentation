Example Module test
===================

Let's assume the :ref:`example module <codeception_example_module>` is installed in your shop,
:ref:`Codeceptions initialization <codeception_initialization>`
is done as described and you'd like to write a Codeception acceptance test verifying that
you see a "Hello, my shopid is 1" on the shop's start page with activated module.


Create a Cest
-------------

You can create a Cest by running the following command from inside the module ``Tests`` directory (``<vendor_name>/<module_name>/Tests``):

.. code:: php

    <shop_dir>/vendor/bin/codecept generate:cest Acceptance CheckShopFrontend

The empty ``<vendor_name>/<module_name>/Tests/Codeception/Acceptance/CheckShopFrontendCest.php`` Cest will be
automatically created.

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

It is not yet testing anything, but we can already run it. Running the codeception tests is explained in
section :ref:`Running Codeception Tests <running-codeception-tests>`.


Add test for not logged in user case
------------------------------------

Let us add test code to check the front page.

.. code:: php

    <?php

    namespace MyVendor\MyModule\Tests\Codeception;
    use MyVendor\MyModule\Tests\Codeception\AcceptanceTester;

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

    vagrant@oxideshop:/var/www/oxideshop$ MODULE_IDS=<module_id> vendor/bin/codecept run Acceptance -c tests/codeception.yml
    Building Actor classes for suites: Acceptance
     -> AcceptanceTesterActions.php generated successfully. 150 methods added
    \AcceptanceTester includes modules: Asserts, WebDriver, Db, \OxidEsales\Codeception\Module\Oxideshop, \OxidEsales\Codeception\Module\Database, \OxidEsales\Codeception\Module\Translation\TranslationsModule
    Codeception PHP Testing Framework v2.5.6
    Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
    Running with seed:


    Acceptance Tests (1) ----------------------------------------------------------------------------------------------------------------------------------------------
    ✔ CheckShopFrontendCest: Test message for not logged in user (8.72s)
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------


    Time: 55.12 seconds, Memory: 12.00MB

    OK (1 test, 1 assertion)
    - XML report generated in file:///var/www/oxideshop/vendor/myvendor/mymodule/tests/Codeception/_output/report.xml


Add test for logged in user case
--------------------------------

Now let's check the case of a logged in user.

We will need to:

* open the shop
* open the login box
* enter user credentials
* check the main page for the expected message.

Some of those steps can be skipped by using :ref:`OXID Codeception Page Objects <codeception-page_objects>`.

To be able to use the OXID page objects, first, :ref:`OXID Codeception Modules <codeception-modules>`
need to be enabled in your module codeception configuration. When initializing the codeception tests as
described in section :ref:`Creating test structure in a module <codeception_initialization>` this is already taken care of.
Let's just add the next test:

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
