.. _how_to_replace_shop_services-20854932:

Customizing Project Configuration
==================================

.. contents::
    :local:

Configuring OXID eShop Project services
---------------------------------------

You can extend configurations for system services and `parameters <https://symfony.com/doc/current/configuration.html#configuration-parameters>`_
of your Project by editing files in one of the project configuration folders.
For example, adding the following code to the file :file:`var/configuration/services.yaml`:

.. code:: yaml

    services:
      Psr\Log\LoggerInterface:
        class: MyProject\CustomLogger

will reassign Service ID `Psr\\Log\\LoggerInterface`, configured earlier in the OXID eShop Community Edition, as

.. code:: yaml

    services:
        Psr\Log\LoggerInterface:
          class: OxidEsales\EshopCommunity\Internal\Framework\Logger\Wrapper\LoggerWrapper

to a new implementation `MyProject\\CustomLogger`.
This new implementation will be used every time `LoggerInterface` is requested from the Container.


General Project configurations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is the basic project configuration folder.
Unless overwritten in additional, more specific file, values from the following files will be used for all shops and environments:

- :file:`var/configuration/services.yaml`
- :file:`var/configuration/parameters.yaml`


Shop-specific Project configurations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you need a service/parameter acting differently for a certain sub-shop, add configuration to the following files:

- :file:`var/configuration/shops/[SHOP_ID]/services.yaml`
- :file:`var/configuration/shops/[SHOP_ID]/parameters.yaml`

Environment-specific Project configurations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you need a service/parameter configured only for the active application `environment <https://symfony.com/doc/current/configuration.html#configuration-environments>`_
edit or create files in:

- :file:`var/configuration.[ENV_ID]/services.yaml`
- :file:`var/configuration.[ENV_ID]/parameters.yaml`

Environment-and-shop-specific Project configurations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The last configuration option will be applied only to actual application environment and specific shop ID:

- :file:`var/configuration.[ENV_ID]/shops/[SHOP_ID]/services.yaml`
- :file:`var/configuration.[ENV_ID]/shops/[SHOP_ID]/parameters.yaml`

Configurations loading order
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When compiled, Symfony Dependency Injection Container will collect all the service definitions found in the current OXID eSales
Project. The later such service configuration appears in this "compilation chain", the higher is its ability to have
an impact on the final, compiled version.

Project service configurations will be added in the following order:

- OXID eShop Community Edition Services
- OXID eShop Professional Edition Services
- OXID eShop Enterprise Edition Services
- OXID eShop Component Services
- Active OXID eShop Module Services
- General Project Configurations
- Shop-specific Project Configurations
- Environment-specific Project Configurations
- Environment-and-shop-specific Project Configurations

An example of such service loading chain might look like following:

.. code:: shell

    vendor/oxid-esales/oxideshop-ce/Internal/services.yaml
    ↓
    vendor/oxid-esales/oxideshop-pe/Internal/services.yaml
    ↓
    vendor/oxid-esales/oxideshop-ee/Internal/services.yaml
    ↓
    var/generated/generated_services.yaml
    ↓
    vendor/module-vendor/oxideshop-module/services.yaml
    ↓
    var/configuration/services.yaml
    ↓
    var/configuration/shops/1/services.yaml
    ↓
    var/configuration.dev/services.yaml
    ↓
    var/configuration.dev/shops/1/services.yaml
