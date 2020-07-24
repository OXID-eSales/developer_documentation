Services
========

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
            public: true

.. note:: **class** argument in **services.yaml** is optional and can be omitted
    (when it's undefined, DI container considers that the ID of the service is the PHP class with fully qualified name).
    Following 2 examples of service arguments will have the same effect:

.. code:: yaml

    services:
        SomeCompany\SpecialERPModule\PriceCalculator:
            class: SomeCompany\SpecialERPModule\PriceCalculator
            public: true

    services:
        SomeCompany\SpecialERPModule\PriceCalculator:
            public: true

We recommend to use the interface namespace as the DI container key for
the service if you have only the one implementation for an interface and
provide ``class`` parameter with the implementation namespace.
So we can inject with autowiring an interface as dependency in our classes
and avoid dependencies on implementations (dependency inversion principle).

.. code:: php

    public function __constructor(PriceCalculatorInterface $priceCalculator)
    {
        $this->priceCalculator = $priceCalculator;
    }

In this example we have dependency on PriceCalculatorInterface (abstraction),
but not on ERPPriceCalculator (implementation). PriceCalculatorInterface will be autowired
and no changes in the yaml file are needed because the key of the service is the same as provided
in the constructor argument type.

.. warning:: Your service needs to implement **ShopAwareInterface**, if you want to be able to active it per shop.
    Otherwise, module services will be active in all subshops, even if the module itself is activated only for one of them!


.. _inject_services-20191111:

Inject own, third party module or shop services
-----------------------------------------------

You can use your own, shop services or even services of other modules via dependency injection.

.. code:: php

    use Psr\Log\LoggerInterface;

    class ERPPriceCalculator implements PriceCalculatorInterface
    {
        private $shopLogger;

        public function __constructor(LoggerInterface $shopLogger)
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

Use services in standard classes
--------------------------------

Now you have a service and want to use it to extend already existing shop functionality.
You can create own Article class where you overwrite the getPrice() method:

.. code:: yaml

    class ERPArticle extends Article_parent
    {
        public function getPrice($amount = 1)
        {
            $container = ContainerFactory::getInstance()->getContainer();

            $erpPriceCalculator = $container->get(PriceCalculatorInterface::class);
            return $erpPriceCalculator->getPrice($this->getId(), $amount)
        }
    }

You just fetch the DI container via the ContainerFactory and then fetch your service.
In order to obtain the service, it needs to be marked as public.
