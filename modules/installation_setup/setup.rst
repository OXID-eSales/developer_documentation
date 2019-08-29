Setup/Activation
================

If module was :doc:`installed <installation>` successfully, next step is activating it.

There are 3 ways of activating a module:

**1. Activate a module through OXID eShop admin panel:**

Open OXID eShop administration panel and got to :menuselection:`Extensions --> Modules`,
select a module and click activation button.

**2. Activate a module via OXID eShop command:**

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id>

.. note::

    <module-id> is a module, which should be activated, ID. It can be found in module `metadata.php` file.

**3. Activate all configured modules at once:**

How to activate all modules at once please read
:ref:`modules configuration and setup document <activate_configured_modules-20190829>`.
