DI Container
============

The OXID eShop uses the Symfony ``DI Container`` to handle services. For
more information about DI Container refer to the Symfony ``DI Container`` documentation.

https://symfony.com/doc/current/components/dependency_injection.html

Using DI Container
^^^^^^^^^^^^^^^^^^

For using ``DI Container`` there are couple of things you need to know:

1- you need to create a service.

2- You need a services.yaml file that Configures ``DI Container``.
This file is responsible for registering your service into the ``DI Container``
and you will find it in the Internal directory.

.. note::

    There are several possibilities to configure the Symfony DI container.
    OXID framework only use yaml file format so we only support services.yaml.

    Also, there are the services.yaml files for the different editions if you have PE or EE edition packages installed.
    You will find services.yaml file in each of editions.

Creating a service
^^^^^^^^^^^^^^^^^^

A service is any PHP object that
performs some sort of "global" task such as delivering emails.
Each service is used throughout your application whenever you need the specific functionality.

Example: create a service for moduleActivation.

.. code:: php

    namespace OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge;

    interface ModuleActivationBridgeInterface
    {
        public function activate(string $moduleId, int $shopId);

        public function deactivate(string $moduleId, int $shopId);

        public function isActive(string $moduleId, int $shopId): bool;
    }

Registering a service
^^^^^^^^^^^^^^^^^^^^^^

Example: register a service into ``DI Container`` using services.yaml file:

.. code:: php

    services:
      _defaults:
        autowire: true
        public: false

      OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridgeInterface:
        class: OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridge
        public: true


Getting services
^^^^^^^^^^^^^^^^

If you need services configured in the ``DI Container``, There are two ways to do it:

1- Getting services via injecting it through constructor as an dependency.

Example:

.. code:: php

    public function __construct(
        ModuleActivationBridgeInterface $moduleActivation,
    ) {
        $this->moduleActivation = $moduleActivation;
    }


2- Getting services using service locator. You can use :file:`ContainerFactory` class to get a service.

Example:

.. code:: php

    $containerFactory = ContainerFactory::getInstance()
    $container = $containerFactory->getContainer()
    $moduleActivationService = $container->get(ModuleActivationBridgeInterface::class);

.. important::

    Normally, the container factory will get the container from a container cache file.
    It resides in the ``tmp`` directory of your application and is called :file:`container_cache.php`.

    If this file is not found, the container will be set up fresh from it's configuration.
    If you change something in the container configuration, you need to delete
    :file:`container_cache.php` to get a container that reflects your changes.
