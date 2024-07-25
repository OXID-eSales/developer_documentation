Modules environment configuration
=================================

.. contents ::
    :local:
    :depth: 2

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.

Overview
--------

Module configurations can vary across different environments, such as testing, staging, and production. For example,
in testing and staging environments, you might run some modules in sandbox mode, whereas in the production environment,
you would use the production settings.

To solve this problem, OXID eShop can use an additional directory alongside :ref:`var/configuration/shops <configuring_module_via_configuration_files-20190829>`.
The configuration files for different environments can be located in `var/configuration/environment/shops/<shop-id>/`.

Example structure:

.. code::

  .
  └── var
      └── configuration
          └── environment
              └── shops
                  └── 1
                  └── 2
                  └── ...
          └── shops
              └── 1
              └── 2
              └── ...


The environment files can be used to override module settings. For example, you can override settings
in `var/configuration/shops/<shop-id>/modules/oe_moduletemplate.yaml` with those
in `var/configuration/environment/shops/<shop-id>/modules/oe_moduletemplate.yaml`.

.. note:: Only module settings can be overwritten via environment files.

Original file:

.. code:: yaml

    id: oe_moduletemplate
    moduleSource: vendor/oxid-esales/module-template
    version: 2.0.0
    activated: true
    ...
    moduleSettings:
      oemoduletemplate_GreetingMode:
        group: oemoduletemplate_main
        type: select
        value: personal
        constraints:
          - generic
          - personal

Environment override:

.. code:: yaml

    moduleSettings:
      oemoduletemplate_GreetingMode:
        value: generic
    ...
