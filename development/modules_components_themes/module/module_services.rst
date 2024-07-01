.. _services_01:

Services
========

.. note::
    Watch a short video tutorial on YouTube: `Components & Services <https://www.youtube.com/watch?v=tgopDKPiUZE>`_.

The OXID eShop uses the Symfony DI Container to handle services. For
more information about DI Container refer to the
`Symfony DI Container documentation <https://symfony.com/doc/current/components/dependency_injection.html>`_

In a module, you can:

.. contents::
    :local:


Define service
--------------

For example, you need to adjust the price calculation of the product. You can define a single
responsible service for this:

.. code:: php

    interface PriceCalculatorInterface
    {
        public function getPrice(string $productId, int $amount): Price;
    }

    class ERPPriceCalculator implements PriceCalculatorInterface
    {
        public function getPrice(string $productId, int $amount): Price
        {
            $this->doSomeCalculation();
            // ...
            return $price
        }
    }

.. _register_services-20191111:

Register service
----------------

Then you can register the service in OXID DI Container. Create in root directory of your module
:file:`services.yaml` file and register it there:

.. code:: yaml

    services:
        SomeCompany\SpecialERPModule\PriceCalculatorInterface:
            class: SomeCompany\SpecialERPModule\ERPPriceCalculator
            autowire: true

.. note:: **class** argument in **services.yaml** is optional and can be omitted
    (when it's undefined, DI container considers that the ID of the service is the PHP class with fully qualified name).
    Following 2 examples of service arguments will have the same effect:

.. code:: yaml

    services:
        SomeCompany\SpecialERPModule\PriceCalculator:
            class: SomeCompany\SpecialERPModule\PriceCalculator

    services:
        SomeCompany\SpecialERPModule\PriceCalculator:

We recommend to use the interface namespace as the DI container key for
the service if you have only the one implementation for an interface and
provide ``class`` parameter with the implementation namespace.
So we can inject with autowiring an interface as dependency in our classes
and avoid dependencies on implementations (dependency inversion principle).

.. code:: php

    public function __construct(PriceCalculatorInterface $priceCalculator)
    {
        $this->priceCalculator = $priceCalculator;
    }

In this example we have dependency on PriceCalculatorInterface (abstraction),
but not on ERPPriceCalculator (implementation). PriceCalculatorInterface will be autowired
and no changes in the yaml file are needed because the key of the service is the same as provided
in the constructor argument type.

.. _inject_services-20191111:

Inject own, third party module or shop services
-----------------------------------------------

You can use your own, shop services or even services of other modules via dependency injection.

.. code:: php

    use Psr\Log\LoggerInterface;

    class ERPPriceCalculator implements PriceCalculatorInterface
    {
        private $shopLogger;

        public function __construct(LoggerInterface $shopLogger)
        {
            $this->shopLogger = $shopLogger;
        }

        public function getPrice(string $productId, int $amount): Price
        {
            $this->shopLogger->info('Log something');

            $this->doSomeCalculation();
            // ...
            return $price;
        }
    }

In this example a shop service with id 'Psr\Log\LoggerInterface' will be autowired and
no changes in the yaml file are needed, because the key of the logger service is the same as provided
in the constructor argument type.

Use services in non-DI classes
------------------------------

What if you want to use your new service (or any eShop service) in one of the non-DI OXID eSales classes as well?
You'll need to sacrifice the benefits of `Dependency Injection` and resort to `Service Locator` pattern for such scenario.

For example, you can just create a subclass and use the service after fetching it directly in one of the method overrides:

.. code:: php

    class ERPArticle extends Article_parent
    {
        public function getPrice($amount = 1)
        {
            $erpPriceCalculator = ContainerFacade::get(PriceCalculatorInterface::class);

            return $erpPriceCalculator->getPrice($this->getId(), $amount)
        }
    }

.. note::
    Each Symfony service is defined as `private` by default.
    Services that need to be accessed directly from the container (via `Service Locator`) should have `public` visibility.
