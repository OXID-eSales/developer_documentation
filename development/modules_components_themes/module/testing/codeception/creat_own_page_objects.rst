.. _codeception-write_own_page_objects:

Create own PageObject
=====================

As a simple example we will create a PageObject for the contact page.
Run the following command from inside the module ``Tests`` directory (``<vendor_name>/<module_name>/Tests``):

.. code:: php

    <shop_dir>/vendor/bin/codecept generate:pageobject ContactPage

The empty ``<vendor_name>/<module_name>/Tests/Codeception/_support/Page/ContactPage.php`` PageObject will be created.

.. code:: php

    <?php
    namespace MyVendor\MyModule\Tests\Codeception\Page;

    class ContactPage
    {
        // include url of current page
        public static $URL = '';

        /**
         * Declare UI map for this page here. CSS or XPath allowed.
         * public static $usernameField = '#username';
         * public static $formSubmitButton = "#mainForm input[type=submit]";
         */

        /**
         * Basic route example for your current URL
         * You can append any additional parameter to URL
         * and use it in tests like: Page\Edit::route('/123-post');
         */
        public static function route($param)
        {
            return static::$URL.$param;
        }
    }


We adapt this ``ContactPage`` to extend from ``OxidEsales\Codeception\Page\Page`` and it uses the OXID Codeception Translator module.
Then we need to figure out all CSS or XPath locators we will need and assemble a method ``sendContactForm`` which takes the form data as input
and returns the contact page in the state from after contact form is sent.

.. code:: php

    <?php

    namespace MyVendor\MyModule\Tests\Codeception\Page;

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

        public $sendContact = "//button[contains(., '%s')]";

        public $salutationSelection = "//button[@title='%s']";

        public $salutationValue = "//li[@data-original-index='%s']";

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
            $I->click(sprintf($this->sendContact, Translator::translate('SEND')));
            $I->waitForPageLoad();

            return $this;
        }

        /**
         * Select salutation.
         */
        private function selectSalutation()
        {
            $locator = sprintf($this->salutationSelection, Translator::translate('DD_CONTACT_SELECT_SALUTATION'));

            $I = $this->user;
            $I->seeElement($locator);
            $I->click($locator);
            $I->click(sprintf($this->salutationValue, 1));
        }
    }


Here we use this Contact PageObject in a test. Contact form is sent and test asserts, that we see the correct thank you message.

.. code:: php

    public function sendContactFormSuccess(AcceptanceTester $I)
    {
        $I->wantToTest('sending a contact message');

        $contactPage = new \MyVendor\MyModule\Tests\Codeception\Page\ContactPage($I);
        $I->amOnPage($contactPage->URL);
        $contactPage->sendContactForm('Max', 'Muster',  'user@oxid-esales.com', 'subject', 'body');

        $I->see(Translator::translate('DD_CONTACT_THANKYOU1'));
    }