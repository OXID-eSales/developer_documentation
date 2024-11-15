Setup/Activation
================

If module was :doc:`installed <installation>` successfully, the next step is activating it.

There are 3 ways of activating a module:

.. _modules_installation_activate_via_admin-20190917:

**1. Activating a module through the OXID eShop admin panel**

1. Open OXID eShop administration panel and go to :menuselection:`Extensions --> Modules`.
2. Choose the module and choose the :guilabel:`Activate` button.

.. _modules_installation_activate_via_command-20190917:

**2. Activating a module via OXID eShop command**

To activate module execute the following command:

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id>

To activate a module for a sub shop, use the following option:

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id> --shop-id=<shop-id>

.. note::

    :code:`<module-id>` is the unique identifier of a module. Find it in the module's  :file:`metadata.php` file.

    :code:`<shop-id>` is the unique identifier of a sub shop. Find it in the Admin panel under :menuselection:`Master Settings --> Core Settings --> Main`.

**3. Activating all configured modules at once**

All modules activation usually should be used during deployment phase.

For more information about how to activate all modules at once, see :doc:`modules configuration and deployment document </development/modules_components_themes/project/module_configuration/modules_configuration_deployment>`.
