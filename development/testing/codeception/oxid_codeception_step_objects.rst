.. _codeception-step_objects:

Codeception step objects
========================

For the recurring test actions like login on start page or add a product to basket and then open basket
please use the StepObjects classes.

Standard Codeception step objects
---------------------------------

The Step Object classes extend the Actor (``AcceptanceTester``) class, meaning they can access all the methods
and properties of it:

.. code:: php

    class Start extends AcceptanceTester
    {
        /**
         * @param string $userName
         * @param string $userPassword
         *
         * @return Home
         */
        public function loginOnStartPage(string $userName, string $userPassword)
        {
            $I = $this->user;
            $startPage = $I->openShop();
            $startPage = $startPage->loginUser($userName, $userPassword);
            return $startPage;
        }
    }

The StepObject will be instantiated automatically by the Dependency Injection Container of the Codeception inside the
test:

.. code:: php

    public function sendInvitationEmail(Start $I)
    {
        ...

        $homePage = $I->loginOnStartPage($userLoginName, $userPassword);

        ...
    }

OXID Codeception step objects
-----------------------------

OXID has also defined few Step Objects, that could be useful for writing tests faster. The OXID Step Object classes do
not extend the Actor (``AcceptanceTester``) class, but are injecting it:

.. code:: php

    class Step
    {
        /**
         * @var \Codeception\Actor
         */
        protected $user;

        /**
         * Step constructor.
         * @param \Codeception\Actor $I
         */
        public function __construct(\Codeception\Actor $I)
        {
            $this->user = $I;
        }
    }

The usage would look like this:

.. code:: php

    /**
     * @param ProductNavigation $productNavigation
     */
    public function sendInvitationEmail(AcceptanceTester $I)
    {
        ...

        $startStep = new Start($I);
        $homePage = $startStep->loginOnStartPage($userLoginName, $userPassword);

        ...
    }