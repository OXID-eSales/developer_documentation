Extend OXID eShop Class
=======================

OXID eShop allows to chain extend Shop classes. This builds all modules in a single chain allowing them to:

- Hook to events when methods are being used
- Change what is returned by the method
- Get the results from a method

This is a very powerful mechanism which gives a lot of flexibility to module writers.
This comes with a price that module classes which extends Shop classes are harder to maintain as they:

- Extends (contains) shop logic
- Could be influenced by other modules

Therefore best practice would be to avoid all logic in these classes and use them only to extend to a Shop method.
All logic then would be placed to a separate module class.
In such a case an integration test would be written for a class which extends Shop.
This test would assure that parameters get from Shop are such as expected and works in a project even when other modules
being activated. Module class with real logic would be tested with regular unit/integration/acceptance tests.

**Example of a module class which extends OXID eShop class**

This is simplified variant to show that custom logic of the module could be executed every time
when the OXID eShop method is being called.

::

    /**
     * @see \OxidEsales\Eshop\Application\Model\Basket
     */
    class Basket extends Basket_parent
    {
        use ServiceContainer;

        /**
         * Method overrides eShop method and adds logging functionality.
         * {@inheritDoc}
         */
        public function addToBasket(
            $productID,
            $amount,
            $sel = null,
            $persParam = null,
            $shouldOverride = false,
            $isBundle = false,
            $oldBasketItemId = null
        ) {
            $basketItemLogger = $this->getServiceFromContainer(BasketItemLogger::class);
            $basketItemLogger->log($productID);

            return parent::addToBasket(
                $productID,
                $amount,
                $sel,
                $persParam,
                $shouldOverride,
                $isBundle,
                $oldBasketItemId
            );
        }
    }

    class BasketItemLogger { ... }

**Example of integration/acceptance test**

This test assures that all functionality of the module works as expected within a project.
This test has to be run:

- Within the OXID eShop
- With all relevant modules activated

Using the ``ServiceContainer`` trait method ``getServiceFromContainer`` will allow us to mock the LoggerInterface and write a simple integration test for our new functionality later. In the test, we check if our logger functionality is called during the addToBasket method call. While it is not yet possible to inject our services via constructor for Models and Controllers we will use the trait which returns us our desired service. Doing so allows us to mock the ``getServiceFromContainer`` method and ask for the desired service. This in the future, makes possible testing our new functionality easier.
::

    public function testAddToBasket(): void
    {
        $loggerMock = $this->createMock(BasketItemLogger::class);
        $loggerMock
            ->expects($this->once())
            ->method('log');

        $basket = $this->createPartialMock(Basket::class, ['getServiceFromContainer']);
        $basket->method('getServiceFromContainer')->willReturnMap([
            [BasketItemLogger::class, $loggerMock]
        ]);

        $basket->addToBasket(self::TEST_PRODUCT_ID, 1, null, null, false, false, null);
    }

.. important::

  In case OXID eShop class is extended via module class and it should be used somewhere in the code,
  objects must be created not from module class, but from OXID eShop class.

  **Use case:**
  module class `\\OxidEsales\\ModuleTemplate\\Model\\Basket` extends OXID eShop class `\\OxidEsales\\Eshop\\Application\\Model\\Basket`,
  new object must be created from `\\OxidEsales\\Eshop\\Application\\Model\\Basket`.

  **Good example:**
  `$basket = oxNew(\\OxidEsales\\Eshop\\Application\\Model\\Basket::class);`

  **Bad example:**
  `$basket = oxNew(\\OxidEsales\\ModuleTemplate\\Model\\Basket::class);`

Example module
--------------

- https://github.com/OXID-eSales/module-template
