Activation
==========

If template was installed successfully, the next step is activating it.

There are 2 ways of activating a theme:

**1. Activating a theme through the OXID eShop admin panel**

1. Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`.
2. Choose the theme and choose the :guilabel:`Activate` button.

**2. Activating a theme via OXID eShop command**

To activate theme execute the following command:

.. code:: bash

    vendor/bin/oe-console oe:theme:activate <theme-id>
