DI Container
============

.. toctree::
    :maxdepth: 2
    :titlesonly:
    :glob:

The OXID eShop uses the Symfony DI container. for
more information about DI Container in general and the Symfony DI container in particular
refer to the Symfony DI documentation.

https://symfony.com/doc/current/components/dependency_injection.html

Getting services
^^^^^^^^^^^^^^^^

If you need services configured in the DI container,
you need to fetch the DI container yourself and then get the services you need.

There is a ContainerFactory class you will get through
a static method on the class itself.

.. code:: php

    $containerFactory = ContainerFactory::getInstance()

    $container = $containerFactory->getContainer()

example:

.. code:: php

    $container = ContainerFactory::getInstance()→getContainer();
    $erpService = $container→get(ERPPriceProviderInterface::class);

Normally, the container factory will get the container from a container cache file.
It resides in the ``tmp`` directory of your application and is called :file:`container_cache.php`.

If this file is not found, the container will be set up fresh from it's configuration.

.. important::
    If you change something in the container configuration, you need to delete
    :file:`container_cache.php` to get a container that reflects your changes.

.. note::
    Most of the services in the OXID eShop are not publicly available.
    Only high level services that we call bridges are allowed to be fetched from the container.
    These services are called like this because they provide bridges between the traditional OXID code
    and the new code in the Internal namespace.
