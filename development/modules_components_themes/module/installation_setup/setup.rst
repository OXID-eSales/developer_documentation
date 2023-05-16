Setup/Activation
================

If module was :doc:`installed <installation>` successfully, next step is activating it.

There are 3 ways of activating a module:

.. _modules_installation_activate_via_admin-20190917:

**1. Activate a module through OXID eShop admin panel:**

Open OXID eShop administration panel and got to :menuselection:`Extensions --> Modules`,
select a module and click activation button.

.. _modules_installation_activate_via_command-20190917:

**2. Activate a module via OXID eShop command:**

To activate the module execute the :code;`oe:module:activate` command.

Use the ``shop-id`` parameter to activate the modules in the relevant subshop.
|br|
This parameter is optional for the shop with shop ID 1.:

The <module-id> is the ID of the module to be activated. You find it in the module's `metadata.php` file.

.. todo: #Igor: verify --shop-id parameter -- tbd (8:30): please add info about how to activate module in subshop via comandline (--shop-id parameter)

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id> [--shop-id=<subshop-id>]

If you have installed the Community Edition as root package and upgraded to the Professional or Enterprise Edition, use the following path:

.. code:: bash

   bin/oe-console oe:module:activate <module-id> [--shop-id=<subshop-id>]

If you are not sure, try the standard path first.


To deactivate the module, execute the following command:

.. code:: bash

    vendor/bin/oe-console oe:module:deactivate <module-id> [--shop-id=<subshop-id>]


**3. Activate all configured modules at once:**

.. todo: #Igor: Do we recommend activating all modules? In this case it should be step 2; what is the use case for activating a single module?

All modules activation usually should be used during deployment phase.

How to activate all modules at once please read
:doc:`modules configuration and deployment document </development/modules_components_themes/project/module_configuration/modules_configuration_deployment>`.
