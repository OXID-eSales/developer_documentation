Installation
===================

Module :ref:`installation <glossary-installation>` contains 2 parts:

#. copying all necessary module files to the source modules directory
#. installing module configuration

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

    oe-console oe:module:install-configuration source/modules/oe/oepaypal

Activation
----------

After the installation module can be activated from the admin backend or via console command:

.. code:: bash

    oe-console oe:module:activate <module-id>.

During the module activation all necessary data from the module configuration will be written in the database and module cache will be reset.

.. note::

  Module data and extensions chains in the database will be overwritten after every module activation/deactivation with the data from the module configuration.

Activate configured modules
---------------------------

Each module configuration in the shop configuration yml file has ``configured``
option (false by default) which means that module is in configured state and prepared
for the activation.

Example of the shop configuration yml file:

.. code:: yaml

    modules:
        oegdproptin:
            id: oegdproptin
            path: oe/gdproptin
            configured: true
            ...
        oevarnish:
            id: oevarnish
            path: oe/varnish
            configured: false
            ...

You can activate all configured modules for all available shops via the console command:

.. code:: bash

    oe-console oe:module:activate-configured-modules

or only for the one shop if `--shop-id` option is provided:

.. code:: bash

    oe-console oe:module:activate-configured-modules --shop-id=1

The ``configured`` option will be set to true after the module activation and set back to false
after the module deactivation. You can also set the option manually in the shop configuration
yml file.

After shop or database reset modules will be not active, but the ``configured`` option
stays and it's easily possible to activate all previously active modules via the command.

If you need to set up the shop in another environment and get active the same modules
you can copy the configuration file and run the command.

.. note::

  You can override the shop configuration yml file by creating environment yml file
  using the same file structure. This allows you to have different configurations in different environments
  without changing the original shop configuration.

Example of the shop environment yml file:

.. code:: yaml

    modules:
        oegdproptin:
            id: oegdproptin
            path: oe/gdproptin
            configured: true
            ...
        oevarnish:
            id: oevarnish
            path: oe/varnish
            configured: false
            ...


