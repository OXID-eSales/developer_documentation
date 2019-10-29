Service Container
=================

The OXID eShop uses the Symfony ``DI Container`` to handle services. For
more information about DI Container refer to the Symfony ``DI Container`` documentation.

https://symfony.com/doc/current/components/dependency_injection.html

Using DI Container
------------------

For using ``DI Container`` there are couple of things you need to know:

1. You need to create a service.

2. You need a :file:`services.yaml` file that Configures ``DI Container``. This file is responsible for registering your service into the ``DI Container`` and you will find it in the Internal directory.

.. note::

    There are several possibilities to configure the Symfony DI container.
    OXID framework only use yaml file format so we only support :file:`services.yaml`.

    Also, there are the :file:`services.yaml` files for the different editions
    if you have PE or EE edition packages installed.
    You will find :file:`services.yaml` file in each of editions.

Creating a service
------------------

A service is any PHP object that
performs some sort of "global" task such as delivering emails.
Each service is used throughout your application whenever you need the specific functionality.

Example: Create a service for activating modules.

.. code:: php

    namespace OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge;

    interface ModuleActivationBridgeInterface
    {
        public function activate(string $moduleId, int $shopId): void;

        public function deactivate(string $moduleId, int $shopId): void;

        public function isActive(string $moduleId, int $shopId): bool;
    }

    class ModuleActivationBridge implements ModuleActivationBridgeInterface
    {
        public function __construct(
            ModuleActivationServiceInterface    $moduleActivationService,
            ModuleStateServiceInterface         $moduleStateService
        ) {
            $this->moduleActivationService = $moduleActivationService;
            $this->moduleStateService = $moduleStateService;
        }

        public function activate(string $moduleId, int $shopId): void
        {
            // write your code
        }

        public function deactivate(string $moduleId, int $shopId): void
        {
            // write your code
        }

        public function isActive(string $moduleId, int $shopId): bool
        {
            // write your code
        }
    }



Registering a service
---------------------

Example: Register a service into ``DI Container`` using :file:`services.yaml` file:

.. code:: php

    services:
      _defaults:
        autowire: true
        public: false

      OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridgeInterface:
        class: OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Bridge\ModuleActivationBridge
        public: true


Getting services
----------------

If you need services configured in the ``DI Container``, There are two ways to do it:

1. Getting services via injecting it through constructor as an dependency.

    Example:

    .. code:: php

        public function __construct(
            ModuleActivationServiceInterface    $moduleActivationService,
            ModuleStateServiceInterface         $moduleStateService
        ) {
            $this->moduleActivationService = $moduleActivationService;
            $this->moduleStateService = $moduleStateService;
        }


2. Getting services using service locator. You can use :file:`ContainerFactory` class to get a service.

    Example:

    .. code:: php

        $containerFactory = ContainerFactory::getInstance();
        $container = $containerFactory->getContainer();
        $moduleActivationService = $container->get(ModuleActivationBridgeInterface::class);

    .. important::

        Normally, the container factory will get the container from a container cache file.
        It resides in the ``tmp`` directory of your application and is called :file:`container_cache.php`.

        If this file is not found, the container will be set up fresh from it's configuration.
        If you change something in the container configuration, you need to delete
        :file:`container_cache.php` to get a container that reflects your changes.

Overwriting shop services in a project
--------------------------------------

In some cases you might need to change system services behaviour, for this reason OXID eShop provides functionality
to achieve this.

You can overwrite system services in your project.
For this purpose there is a file named :file:`configurable_services.yaml`, which you will find (or will have to create)
under :file:`var/configuration`. This file exists exactly once per project.

Example of :file:`var/configuration/configurable_services.yaml` file:

.. code:: yaml

    services:
      Psr\Log\LoggerInterface:
        class: MyProject\CustomLogger
        public: true

In example OXID eShop `Psr\Log\LoggerInterface` service being overwritten by new `CustomLogger`.

Services which are safe to overwrite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We do not recommend overwrite system services in :file:`internal` directory, unless services have
``@stable`` annotation. Services which are not marked as stable might change more often in the future releases.
For more information refer to :file:`README.md` file in internal directory.
