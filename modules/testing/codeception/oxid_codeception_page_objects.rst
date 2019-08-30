.. _codeception-page_objects:

OXID Codeception page and step objects
======================================

Usually when writing acceptance tests it's a hassle to get all the locators right. We should avoid
hard-coding XPath and CSS locators directly in tests as this will make them hard to maintain.
At least for the standard themes, those locators usually do not change very often so if we had a list of them this
would speed up test writing a lot. Even better not having to bother with locators at all if possible but
simply use ``login``, ``openBasket`` etc. not having to reinvent standard actions on every test.

That's where the Page Objects come into play. We are using the Page Object pattern which allows us
to organize variables in a more structured way. Page Objects include UI locators which are represented
with public static properties.

Following components are shipped with testing library.

**NOTE:** As these UI locators depend on the theme, we need different PageObjects per theme.


Layout component
----------------

Layout components will be represented by traits and included in the different Page Object classes as needed.

Example:

.. code:: php

    namespace OxidEsales\Codeception\Page\Component\Footer;

    use OxidEsales\Codeception\Page\Checkout\Basket;
    use OxidEsales\Codeception\Module\Translation\Translator;
    use OxidEsales\Codeception\Page\PrivateSales\Invitation;

    /**
     * Trait for service menu widget in footer
     * @package OxidEsales\Codeception\Page\Component\Footer
     */
    trait ServiceWidget
    {
        public $basketLink = '//ul[@class="services list-unstyled"]';

        public $privateSalesInvitationLink = '//ul[@class="services list-unstyled"]';

        /**
         * @return Basket
         */
        public function openBasket()
        {
           ...
        }

        /**
         * @return Invitation
         */
        public function openPrivateSalesInvitationPage()
        {
            ...
        }
    }


Page object class
-----------------

A Page Object represents a page (or a component of the page) and some actions of it. The page will be implemented as
a class.

The instance of an Actor class (``AcceptanceTester $this->I``) will be passed to each Page Object class.

.. code:: php

    /**
     * Page constructor.
     *
     * @param \Codeception\Actor $I
     */
    public function __construct(\Codeception\Actor $I)
    {
        $this->user = $I;
    }


* The Page Object class' public methods represent the actions offered by the page. All methods should return a
  Page Object. Like this we can effectively model the user's journey in a test as you will see later in an example.

* Page Objects themselves should never make verifications or assertions. This should always be within the test’s code.
  There is one, single, verification which can, and should, be within the page object and that is to verify that
  the page, and possibly critical elements on the page, were loaded correctly.

* Page Objects should be used only **in tests and helpers.**

* For more detailed information you can head to Codeception documentation page on `Codeception page objects <https://codeception.com/docs/06-ReusingTestCode#PageObjects>`__


**Example for the user login page**

.. code:: php

    class UserLogin extends Page
    {
        // include url of current page
        public static $URL = '/en/my-account/';

        // include bread crumb of current page
        public static $breadCrumb = '#breadcrumb';

        public static $userAccountLoginName = '#loginUser';

        public static $userAccountLoginPassword = '#loginPwd';

        public static $userAccountLoginButton = '#loginButton';

        public static $userForgotPasswordLink = '#forgotPasswordLink';

        /**
         * @param $userName
         * @param $userPassword
         *
         * @return UserAccount
         */
        public function login($userName, $userPassword)
        {
            $I = $this->user;
            $I->fillField(self::$userAccountLoginName, $userName);
            $I->fillField(self::$userAccountLoginPassword, $userPassword);
            $I->click(self::$userAccountLoginButton);
            $I->dontSee(Translator::translate('LOGIN'));
            return new UserAccount($I);
        }
    }


The Step Object class
---------------------

For the recurring test actions like opening a product details page or adding a product to basket and then open basket
please use the StepObjects classes.
The Step Object classes extend the Actor (``AcceptanceTester``) class, meaning they can access all the methods
and properties of it:

.. code:: php

    class ProductNavigation extends AcceptanceTester
    {

        /**
         * Open product details page.
         *
         * @param string $productId The Id of the product
         *
         * @return ProductDetails
         */
        public function openProductDetailsPage($productId)
        {
            $I = $this;

            $I->amOnPage(ProductDetails::route($productId));
            return new ProductDetails($I);
        }
    }

The StepObject will be instantiated automatically by the Dependency Injection Container of the Codeception inside the
test:

.. code:: php

    /**
     * @param ProductNavigation $productNavigation
     */
    public function sendProductPriceAlert(ProductNavigation $I)
    {
        $I->wantToTest('product price alert functionality');

        $productData = [
            'id' => 1000,
            'title' => 'Test product 0 [EN] šÄßüл',
            'desc' => 'Test product 0 short desc [EN] šÄßüл',
            'price' => '50,00 € *'
        ];

        //open details page
        $detailsPage = $I->openProductDetailsPage($productData['id']);
        $I->see($productData['title']);
        $I->see(Translator::translate('PRICE_ALERT'));
        ......
    }


We got the most relevant pages and steps already represented as `Codeception page objects <https://github.com/OXID-eSales/codeception-page-objects/>`__.
Our recommendation is that you stick to this concept even in case the page you need does not yet have a
page object. Create Page Components or Page Object classes as you need them and then
please send us a Pull Request. We will greatly apppreciate help from the OXID Community
to add to our testing environment.

.. _codeception-write_own_page_objects:

Create own PageObject
=====================

As a simple example we will create a PageObject for the contact page. Our ``ContactPage`` extends from
``OxidEsales\Codeception\Page\Page`` and uses the OXID Codeception Translator module. Then we need to figure out all
CSS or XPath locators we will need and assemble a method ``sendContactForm`` which takes the form data as input
and returns the contact page in the state from after contact form is sent.

.. code:: php

    <?php

    namespace MyVendor\MyModule\Tests\Codeception\Acceptance;

    use OxidEsales\Codeception\Page\Page;
    use OxidEsales\Codeception\Module\Translation\Translator;

    class ContactPage extends Page
    {
        // include url of current page
        public $URL = '/en/contact';

        public $userFirstName = 'editval[oxuser__oxfname]';

        public $userLastName = 'editval[oxuser__oxlname]';

        public $userEmail = 'editval[oxuser__oxusername]';

        public $messageSubject= 'c_subject';

        public $messageBody= 'c_message';

        /**
         * @param string $userFirstName
         * @param string $userLastName
         * @param string $userEmail
         * @param string $subject
         * @param string $body
         *
         * @return $this
         */
        public function sendContactForm($userFirstName, $userLastName, $userEmail, $subject, $body)
        {
            $I = $this->user;

            $this->selectSalutation();
            $I->fillField($this->userFirstName, $userFirstName);
            $I->fillField($this->userLastName, $userLastName);
            $I->fillField($this->userEmail, $userEmail);
            $I->fillField($this->messageSubject, $subject);
            $I->fillField($this->messageBody, $body);
            $I->click("//button[contains(., '" . Translator::translate('SEND') . "')]");
            $I->waitForPageLoad();

            return $this;
        }

        /**
         * Select salutation.
         */
        private function selectSalutation()
        {
            $locator = "//button[@title='" . Translator::translate('DD_CONTACT_SELECT_SALUTATION') . "']";

            $I = $this->user;
            $I->seeElement($locator);
            $I->click($locator);
            $I->click("//li[@data-original-index='1']");
        }
    }


Here we use this Contact PageObject in a test. Contact form is sent and test asserts, that we see the correct thank you message.

.. code:: php

     public function sendContactFormSuccess(AcceptanceTester $I)
        {
            $I->wantToTest('sending a contact message');

            $contactPage = new \MyVendor\MyModule\Tests\Codeception\Acceptance\ContactPage($I);
            $I->amOnPage($contactPage->URL);
            $contactPage->sendContactForm('Max', 'Muster',  'user@oxid-esales.com', 'subject', 'body');

            $I->see(\OxidEsales\Codeception\Module\Translation\Translator::translate('DD_CONTACT_THANKYOU1'));
        }