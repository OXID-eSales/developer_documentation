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
        /**
         * Method overrides eShop method and adds logging functionality.
         *
         * @param string      $productID
         * @param int         $amount
         * @param null|array  $sel
         * @param null|array  $persParam
         * @param bool|false  $shouldOverride
         * @param bool|false  $isBundle
         * @param null|string $oldBasketItemId
         *
         * @see \OxidEsales\Eshop\Application\Model\Basket::addToBasket()
         *
         * @return BasketItem|null
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
            $basketItemLogger = new BasketItemLogger($this->getConfig()->getLogsDir());
            $basketItemLogger->logItemToBasket($productID);

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
- With all relevant modules activated (functionality of Testing Library)

OXID eShop class is created with function oxNew. This assures that extension chain is build form all relevant modules.
At the end assertion is done that module functionality works as expected. This method will break if:

- OXID eShop introduces backward incompatibility with the module.
- Other module within a compilation change OXID eShop in incompatible way.

::

    public function testLoggingWhenCustomerAddsToBasket()
    {
        $rootPath = $this->mockFileSystemForShop();

        $productId = 'testArticleId';

        /**
            Create Shop class which uses module class.
            Use oxNew() to build whole chain to assure that module work
            in a project - when other modules are activated.
         **/
        $basketComponent = oxNew(\OxidEsales\Eshop\Application\Component\BasketComponent::class);
        $this->setRequestParameter('aid', $productId);
        $basketComponent->tobasket();

        $fileContents = $this->getLogFileContent($rootPath);

        $this->assertLogContentCorrect($fileContents, $productId);
    }

.. important::

  In case OXID eShop class is extended via module class and it should be used somewhere in the code,
  objects must be created not from module class, but from OXID eShop class.

  **Use case:**
  module class `\\OxidEsales\\LoggerDemo\\Model\\Basket` extends OXID eShop class `\\OxidEsales\\Eshop\\Application\\Model\\Basket`,
  new object must be created from `\\OxidEsales\\Eshop\\Application\\Model\\Basket`.

  **Good example:**
  `$basket = oxNew(\\OxidEsales\\Eshop\\Application\\Model\\Basket::class);`

  **Bad example:**
  `$basket = oxNew(\\OxidEsales\\LoggerDemo\\Model\\Basket::class);`

Example module
--------------

- https://github.com/OXID-eSales/logger-demo-module
- https://github.com/OXID-eSales/event_logger_demo
