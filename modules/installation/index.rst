Installation
============

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

Configuring modules
-------------------

In most cases modules need to be configured before they can be activated. One of the major benefits
of the new module setup is that there are two ways of configuring modules:

1. The traditional way of configuring the module in the admin backend.

2. The automatic deployment friendly way by providing configuration files.

We will describe both ways in the following sections.

Configuring modules manually
............................

On the surface this has not changed at all. You see the installed modules in the admin backend
and if the module defines some configuration options in the `metadata.php` file, you can edit
them here.

But what is really happening is quite different from former versions of the module subsystem in
the OXID eShop. In previous version these edits went straight to the database. This is no longer
the case. They now are written to the file system in the installation base directory under
`var/configuration/shops`. For each shop id there is one file with the complete configuration
for the shop. So if the shop has id 1, the file would be named 1.yaml.
On activation the values are read from these files and then transferred to the
database. But the single source of truth regarding the module configuration is this configuration
based on yaml files.

Skript based configuration
..........................

Since the complete configuration is in configuration files, you can make it part of the
VCS repository of your project and deploy it somehow to your testing, staging and productive
systems and then activate the modules through the command line as described below in the
section `Activate configured modules`_.

Since configuration might differ for the different testing, staging or productive environments
it is possible to overwrite values in the base configuration. The procedure is quite
simple: Create the directory `var/configuration/environment` and put stripped down versions
of `<shop id>.yaml` in there. Here you may configure environment specific values, for example
credentials for payment providers. These files will be merged with the base configuration
file and used throughout the module activation process.

.. note::

   It is recommended that in your VCS repository you keep diffent environment configurations,
   for example 1.yaml.productive, 1.yaml.staging, 1.yaml.testing and on deployment rename
   the files for the actual environment to 1.yaml.

.. important::

   If you deploy base and environment configurations from VCS, these should not be changed
   through the admin backend. If you do this, the environment specific values will be
   merged into the base configuration and the environment configuration will be removed.
   Then your manual changes will be applied to the base configuration and then to the
   modules.
   
   This in itself is not a problem, but when you redeploy the configuration, all your
   manual changes will be overwritten. We will show a warning in the backend
   if there is an environment specific configuration found in `var/configuration` and
   advise you not to change configuration values manually. But in case of an
   emergency you can do this, if you really need to. But ensure that these changes
   are reflected in the VCS version of the configuration to avoid trouble on redeployment.

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

Each module configuration in the shop configuration yml file has a ``configured``
option (false by default) which means that the module is in configured state and prepared
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


