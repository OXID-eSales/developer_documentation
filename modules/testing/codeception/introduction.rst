Introduction
============


    "One of the main concepts of Codeception is representation of tests as actions of a person.
    [...] we have an AcceptanceTester, a user who works with our application through an interface that we provide."

Codeception has its own testing format called Cest (Codecept + Test). Each public method of Cest
(except those starting with ``_``) will be executed as a test. Each test class gets a so
called "Actor" object (``AcceptanceTester $I``) that represents the user "doing something" with the
application (shop in our case).

    "Methods of actor classes are generally taken from Codeception Modules.
    Each [Codeception] module provides predefined actions for different testing purposes, and they can be combined to fit the testing environment."


::

    class MainCest
    {
        public function frontPageWorks(AcceptanceTester $I)
        {
            $homePage = new \OxidEsales\Codeception\Page\Home($I);
            $I->amOnPage($homePage->URL);
            $I->see(\OxidEsales\Codeception\Module\Translation\Translator::translate("HOME"));
        }
    }


Please also see `Codeception documentation GettingStarted section <https://codeception.com/docs/02-GettingStarted/>`__
if you are interested in further details about Codeception. We will guide you through running and writing
acceptance tests with Codeception for OXID eShop and OXID eShop modules in the following sections
of this documentation.
