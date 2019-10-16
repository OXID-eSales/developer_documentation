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

To activate module you need to execute command:

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id>

For module deactivation you would need to execute this command:

.. code:: bash

    vendor/bin/oe-console oe:module:deactivate <module-id>

.. note::

    <module-id> is a module, which should be activated, ID. It can be found in module `metadata.php` file.

**3. Activate all configured modules at once:**

All modules activation usually should be used during deployment phase. How to activate all modules at once please read
:doc:`modules configuration and deployment document </project/module_configuration/modules_configuration_deployment>`.
