Installation
===================

Module installation contains 2 parts:

# copying all necessary module files to the source modules directory
# installing module configuration

.. important::

  Only installed modules appear on the admin modules page and can be activated from the admin backend or the command line.

Composer installation
---------------------

Module can be installed with regular composer installation. Composer performs all necessary installation steps.

Manual installation
-------------------

1. Copy or clone your module to the source/modules directory.

2. Install module configuration via oe:module:install-configuration console command. An example:

.. code:: bash

    vendor/bin/oe-console oe:module:install-configuration source/modules/oe/oepaypal

Activation
----------

After the installation module can be activated from the admin backend or via console command:

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id>.

During the module activation all necessary data from the module configuration will be written in the database and module cache will be reset.

.. note::

  Module data and extensions chains in the database will be overwritten after every module activation/deactivation with the data from the module configuration.
