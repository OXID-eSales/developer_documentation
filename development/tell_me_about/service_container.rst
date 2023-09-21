.. _service_container_01:

Service Container
=================

The OXID eShop uses the Symfony DI Container to handle services.

For more information about the DI Container, see the `Symfony DI Container documentation <https://symfony.com/doc/current/components/dependency_injection.html>`_.

You can use the services described in :doc:`modules </development/modules_components_themes/module/module_services>` and
:doc:`OXID eShop components </development/modules_components_themes/component>`. You can use the services in multiple ways:

.. contents::
    :local:

Creating services
-----------------

There is a :doc:`step-by-step instruction for modules </development/modules_components_themes/module/module_services>` but the instructions
are the same for components.

Modules need to be activated in order to make the services
included working. In contrast, components just need to be installed by composer.

Getting services
----------------

* Getting services via :ref:`injecting it through the constructor as a dependency <inject_services-20191111>`.

  Use this way whenever possible (inside another service).

* Getting services using service locator.

  You can use the :file:`ContainerFactory` class to get a service. The service you want to get must be marked as public.

  Example:

  .. code:: php

     $moduleActivationService = ContainerFacade::get(ModuleActivationBridgeInterface::class);

.. important::
    Consider the hints in the :ref:`Stable OXID eShop Core Services <stable_core_services-20191111>` section.

.. _how_to_replace_shop_services-20854932:

Replacing OXID eShop services in a project
------------------------------------------

In some cases, you might need to change system services behaviour. Creating a replacement for OXID eShop system services
should be done in a :doc:`/development/modules_components_themes/component` and not in a module.

You can overwrite system services in your project.
For this purpose, there is a file named :file:`configurable_services.yaml` which you will find (or will have to create)
under :file:`var/configuration`. This file exists exactly once per project. Do not use any other way of replacing
OXID eShop services!

Example of :file:`var/configuration/configurable_services.yaml` file:

.. code:: yaml

    services:
      Psr\Log\LoggerInterface:
        class: MyProject\CustomLogger

In the example, the OXID eShop Service ``PsrLogLoggerInterface`` is set as the key and will be replaced by our custom
implementation ``MyProject\CustomLogger``, which is specified by the class parameter.

.. note::

    There are several possibilities to configure the Symfony DI container.

    OXID framework only uses and supports the yaml file format.

    Make sure to always use the :file:`.yaml` file extension, not :file:`.yml`.

.. important::

   Consider the hints in the :ref:`Stable OXID eShop Core Services <stable_core_services-20191111>` section.

.. important::

   If we want to overwrite already existent service and it is a public service, a new service should be also set as public.

   In fact, the services should have the same visibility.

   Reason: It could be used in the shop or modules as before. This means maybe we have already used it as public in the shop or modules and if we make it private in the new service, they will not work anymore.

Defining shop-specific system services
--------------------------------------

If you need a service specifically for a single eShop and do not want to apply it to all eShops, define/override the system services per store.

To do so, under :file:`var/configuration/shops/[SHOP_ID]`, create a file named :file:`configurable_services.yaml`.

For the content and structure of the yaml file see the previous example under :ref:`development/tell_me_about/service_container:Replacing OXID eShop services in a project`.

Example of the full path: :file:`var/configuration/shops/[SHOP_ID]/configurable_services.yaml`


.. _stable_core_services-20191111:

Using Stable OXID eShop Core Services
-------------------------------------

We do not recommend using or overwriting system services in :file:`internal` directory unless services have
``@stable`` annotation.

Services which are not marked as stable might change more often in future releases.

For more information, see the :file:`README.md` file in the internal directory.

Clearing the Service Container Cache
------------------------------------

Normally, the container factory will get the container from a container cache file.

It resides in the :file:`tmp` directory of your application and is called :file:`container_cache.php`.

If this file is not found, the container will be set up fresh from its configuration.

If you change something in the container configuration, you need to delete
:file:`container_cache.php` to get a container that reflects your changes.
