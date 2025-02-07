Module environment configuration
================================

This document describes how to handle different module configurations across environments in OXID eShop.

Overview
--------

Module configurations may differ between environments such as development, staging, and production. For instance, in a development environment you might use test credentials, while in production the module uses its live settings.

To manage these differences, OXID eShop uses a two-tier configuration approach:

- **Base Configuration:** Stored in the directory
  :file:`var/configuration/shops/<shop-id>/modules/`
  where **<shop-id>** is a placeholder for the shop identifier. For example, **1** might denote the main shop but you must set this value according to your system.
- **Environment-specific Configuration:** Overrides stored in
  :file:`var/configuration.<env>/shops/<shop-id>/modules/`
  where you need to replace **<env>** with your target environment name. For example, use :file:`var/configuration.prod/shops/1/modules/` for production settings.
  The directory name must match your ``OXID_ENV`` environment variable value (e.g., `prod`, `stage`, `dev`).

.. note::
   The directories for environment-specific configurations (e.g. :file:`configuration.prod`) are **not** created automatically. You must create them manually if you want to maintain different settings for different environments.

Configuration Examples
----------------------

Consider the module **oe_moduletemplate** for a shop with identifier **1**.

**Base Configuration File**
Location: :file:`var/configuration/shops/1/modules/oe_moduletemplate.yaml`

.. code:: yaml

    id: oe_moduletemplate
    moduleSource: vendor/oxid-esales/module-template
    version: 2.0.0
    activated: true
    moduleSettings:
      oemoduletemplate_Password:
        value: default_password

**Environment Override File (Production)**
Location: :file:`var/configuration.prod/shops/1/modules/oe_moduletemplate.yaml`

.. code:: yaml

    moduleSettings:
      oemoduletemplate_Password:
        value: environment_specific_password

Directory Structure
-------------------

An example directory structure for shop **1** is as follows:

.. code::

  .
  └── var
      ├── configuration
      │   └── shops
      │       └── 1
      │           └── modules
      │               └── oe_moduletemplate.yaml
      └── configuration.prod
          └── shops
              └── 1
                  └── modules
                      └── oe_moduletemplate.yaml

Important Considerations
------------------------

.. important::

    When using environment-specific configuration files, avoid saving module settings via the admin backend.
    If you do, the environment-specific values will be merged into the base configuration, and the environment override file will be renamed to a `.bak` file.
