Modules configuration and setup
===============================

In most cases modules need to be configured before you can proceed with setup and activate it. There
are two ways of configuring modules:

1. Configuring the module in the admin backend.

2. The automatic deployment friendly way by providing configuration files.

.. uml::

    @startuml
        start
        partition "Configuration   " {
            if (How?) then (Configure module via\nweb interface)
              :Configures module via WEB interface;
            else (Script based\nconfiguration)
              :Change values in configuration files;
            endif
            :Configuration file is updated;
        }
        partition "Setup   " {
            if (Action) then (Activate)
                :Insert database entries;
            else (Deactivate)
                :Remove database entries;
            endif
        }
        stop
    @enduml

We will describe both ways in the following sections.

Configuring modules via admin interface
---------------------------------------

To configure modules via admin interface, please open OXID eShop administration panel
To configure modules via admin interface, please open OXID eShop administration panel
and got to :menuselection:`Extensions --> Modules`, you will see modules list, please select module you want to
configure click :menuselection:`Settings`, you will see list of settings which is possible to change.

Entries in the settings list are loaded and saved in file located in `var/configuration/shops`.
For each shop id there is one file with the complete configuration
for the shop. So if the shop has id 1, the file would be named 1.yaml. See the example below:

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1.yml
             └──2.yml
             └── ...

During the module setup/activation all of the values are being transferred from file to database.

.. note::

    If var directory has not found in the project directory.
    ``composer update`` must be executed or it must created manually.
    Also, each shop must have their own separate yml file.


Script based configuration
--------------------------

Since the complete configuration is in configuration files, you can make it part of the
VCS repository of your project and deploy it to your testing, staging and productive
systems and then activate the modules through the command line as described below in the
section `activate all configured modules`_.

Since configuration might differ for the different testing, staging or productive environments
it is possible to overwrite values in the base configuration. The procedure is quite
simple: Create the directory `var/configuration/environment` and put stripped down versions
of `<shop id>.yaml` in there. Here you may configure environment specific values, for example
credentials for payment providers. These files will be merged with the base configuration
file and used throughout the module activation process. See the example below:

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1.yml
             └──2.yml
             └── ...
          └── environment
             └──1.yml
             └──2.yml
             └── ...

.. note::

   Environment files for each shop must be created manually at the first time.
   It is recommended that in your VCS repository you keep different environment configurations,
   for example 1.yaml.productive, 1.yaml.staging, 1.yaml.testing and on deployment rename
   the files for the actual environment to 1.yaml.

.. important::

   If you deploy base and environment configurations from VCS, these should not be changed
   through the admin backend. If you do this, the environment specific values will be
   merged into the base configuration and the environment configuration will be renamed to `.bak` file like `1.yml.bak`.
   Then your manual changes will be applied to the base configuration and then to the
   modules. Be aware that if there is already an environment backup file, it will be overridden if setting  will change again.

   This in itself is not a problem, but when you redeploy the configuration, all your
   changes in base configuration will be overwritten. If you change settings through the admin backend
   ensure that these changes are reflected in the VCS version of the configuration to avoid trouble on redeployment.


Example of overriding shop configuration file with an environment file
----------------------------------------------------------------------

Lets assume you have on shop and you would like to deploy you configuration from you development
environment to production environment. Also, you installed paypal module but
In the production environment ``sOEPayPalUsername`` and ``sOEPayPalPassword`` needs a different credentials.
So follow these steps:

1. Create environment folder under the configuration directory and create 1.yml file inside this folder.
2. You need copy and paste the part of your module you need to change. For our example, we want to change moduleSettings section that contains these credentials.
3. Write your new values  for ``sOEPayPalUsername`` and ``sOEPayPalPassword`` and save your file.

.. note::
    We have the same shop configuration for the production environment but
    we have environment file only in production environment. You only need to copy the part that you want to override
    In the environment file.

Environment file:

.. code:: yaml

    modules:
      oepaypal:
        moduleSettings:
          sOEPayPalUsername
            value: 'production'
          sOEPayPalPassword
            value: 'xxxxxxxx'
          sOEPayPalSignature
            value: ''
          ...


Activate single module
----------------------

After the installation module can be activated. Description how to activate module can be found in
:doc:`module setup document </modules/installation_setup/setup>`.

.. note::

  Module data and extensions chains in the database will be overwritten after every module activation/deactivation with the data from the module configuration.

.. _activate_configured_modules-20190829:

Activate all configured modules
-------------------------------

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

    vendor/bin/oe-console oe:module:activate-configured-modules

or only for the one shop if `--shop-id` option is provided:

.. code:: bash

    vendor/bin/oe-console oe:module:activate-configured-modules --shop-id=1

The ``configured`` option will be set to true after the module activation and set back to false
after the module deactivation. You can also set the option manually in the shop configuration
yml file.

After shop or database reset modules will be not active, but the ``configured`` option
stays and it's easily possible to activate all previously active modules via the command.
