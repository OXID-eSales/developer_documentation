.. _codeception-page_objects:

Codeception page objects
========================

We are using the Page Object pattern which allows us to organize variables in a more structured way. A Page Object
represents a HTML page (or a component of the page), services that the page offers and UI locators of that page.

OXID Page object class
----------------------

* The instance of an Actor class (``AcceptanceTester $this->I``) must be passed to each Page Object class.

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


* The Page Object class' public methods represent the actions offered by the page.

* All methods should return a Page Object. Like this we can effectively model the user's journey in a test as you will
  see later in an example.

* Page Objects themselves should never make verifications or assertions. This should always be within the test’s code.
  There is one, single, verification which can, and should, be within the page object and that is to verify that
  the page, and possibly critical elements on the page, were loaded correctly.

* Page Objects should be used only **in tests and helpers.**

**Example for the user login page**

.. code:: php

    class UserLogin extends Page
    {
        // include url of current page
        public $URL = '/en/my-account/';

        // include bread crumb of current page
        public $breadCrumb = '#breadcrumb';

        public $userAccountLoginName = '#loginUser';

        public $userAccountLoginPassword = '#loginPwd';

        public $userAccountLoginSubmit = '#loginButton';

        /**
         * @param string $userName
         * @param string $userPassword
         *
         * @return UserAccount
         */
        public function login(string $userName, string $userPassword): UserAccount
        {
            $I = $this->user;
            $I->fillField(s$this->userAccountLoginName, $userName);
            $I->fillField($this->userAccountLoginPassword, $userPassword);
            $I->click($this->userAccountLoginSubmit);
            $I->dontSee(Translator::translate('LOGIN'));
            return new UserAccount($I);
        }
    }

* A Page Object do not need to represent an entire page. It may represent a section that appears many times within a
  page, such as site navigation. That's where the Page Objects Component come into play.


Page Objects Component
----------------------

Page Objects Component will be represented by traits and included in the different Page Object classes as needed.

Example:

.. code:: php

    namespace OxidEsales\Codeception\Page\Component\Footer;

    use OxidEsales\Codeception\Page\Checkout\Basket;
    use OxidEsales\Codeception\Page\PrivateSales\Invitation;

    /**
     * Trait for service menu widget in footer
     * @package OxidEsales\Codeception\Page\Component\Footer
     */
    trait ServiceWidget
    {
        public $privateSalesInvitation = '//ul[@class="services list-unstyled"]';

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


Locators
--------

We should avoid hard-coding XPath and CSS locators directly in tests, instead move them to PageObject classes as
properties. This gives more flexibility to your code, more reusability, easier maintenance and increases readability.

Example:

.. code:: php

    // avoid hard-coding XPath and CSS locators directly
    $I->click('//li[@class="step3 passed "]/a/div[2]');

    // better way
    public $previousStep = '//li[@class="step3 passed "]/a/div[2]';

    $I->click($this->previousStep);

Please choose proper names for those properties. It should not have the name of the UI element, but represent the
purpose of this element. It increases readability and we do not need to change property names, if XPath or CSS locators
change with the time.

Example:

.. code:: php

    // wrong
    public $previousStepClass = '//li[@class="step3 passed "]/a/div[2]';

    // sometimes makes sense
    public $previousStepLink = '//li[@class="step3 passed "]/a/div[2]';

    // better
    public $previousStep = '//li[@class="step3 passed "]/a/div[2]';



.. NOTE:: As these UI locators depend on the theme, we need different PageObjects per theme.


We got the most relevant pages and steps already represented as `Codeception page objects <https://github.com/OXID-eSales/codeception-page-objects/>`__.
Our recommendation is that you stick to this concept even in case the page you need does not yet have a
page object. Create Page Components or Page Object classes as you need them. For everything module specific please use the module namespace.
In case of Page Components or Objects that could be reused by other module writers, please send us a Pull Request.
We will greatly appreciate help from the OXID Community
to add to our testing environment.
