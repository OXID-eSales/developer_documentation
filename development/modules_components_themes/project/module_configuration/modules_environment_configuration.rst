Modules environment configuration
=================================

.. contents ::
    :local:
    :depth: 2

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.
    
Overview
--------

Different module configurations might be different in different environments (testing, staging or productive).
Forexample on testing and staging, you might want to run some modules with sandbox mode and on the production system use
the production settings.

To solve this problem, OXID eShop can use another directory in addition to :ref:`var/configuration/shops <configuring_module_via_configuration_files-20190829>`
with configuration files located in `var/environment/shops/<shop-id>/`.

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


The environment files can be used to overrride module settings in for example `var/configuration/shops/<shop-id>/<mymodule.yaml>`
with `var/environment/shops/<shop-id>/<mymodule.yaml>`