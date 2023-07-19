Unified Namespace vs Internal Namespace
=======================================

In OXID framework, there is a possibility to overwrite classes from lower editions. For example in PE or EE edition, we can
overwrite CE classes. To do that, we need to have the edition specific namespaces, which means PE edition has a different
namespace than CE, for the same class.

This possibility leads us to make a chain between these classes to ensure we have all the functionalities from all the editions.
Our approach to do that is totally different between the traditional code and Internal Namespace. We will explain them below.

Traditional Code
----------------

In traditional code, we provided edition independent namespaces with introducing chain extending classes via Unified Namespace.
We created a tool (`unified namespace generator <https://github.com/OXID-eSales/oxideshop-unified-namespace-generator>`__) to generate a unified namespace for each class that is overwritten between editions.
So instead of an edition specific namespace, we must use its generated unified namespace, which is totally independent of editions.

To create an instance of these classes, we must use `oxnew` function to build the whole chain, for example:

.. code:: php

    $basketComponent = oxNew(\OxidEsales\Eshop\Application\Component\BasketComponent::class);
    $basketComponent->toBasket();

More information:

- :ref:`Unified Namespace Generator <unified_namespace_generator_01>`
- :ref:`Inheritance chain of unified namespace classes <system_architecture-namespaces-inheritiance_chain>`

Internal Namespace
------------------

Starting with version 6, the OXID framework incorporates the Symfony dependency injection (DI) container (`More information about service container <https://symfony.com/doc/current/service_container.html>`__).
And it harbors a new namespace:

.. code::

    OxidEsales\EshopCommunity\Internal

DI container is responsible to access to internal namespace services, and we do not need to use `oxnew` function and unified namespaces anymore.
Because we use the class interface name as key for the DI container and even if the PE or EE edition overwrites a service, the interface remains the same.
And if there is a service that only exists in the EE edition, then the interface obviously has an EE namespace,
but this is also okay because there is no corresponding CE or PE service.

Example:

.. code:: php

    use OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridgeInterface
    .
    .
    public function __contruct(ModuleActivationBridgeInterface $moduleActivationBridge) {
        $this->moduleActivationBridge = $moduleActivationBridge;
    }

More information:

- :ref:`Service Container <service_container_01>`
- :ref:`Services <services_01>`

Conclusion
----------

In traditional code, we can not use the edition specific namespaces.
Instead of it, we have unified namespaces and to access to the classes we need to use `oxnew` function.

In the Internal namespace, we have a DI container to use the edition specific namespaces.
