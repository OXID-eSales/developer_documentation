Module configuration deployment
===============================

This document describes possible deployment process which could be used for the application.
Workflow can be seen in image bellow, schema steps are described in following sections.

.. uml::

    @startuml

    (*)--> "User prepares configuration files"
    --> "User prepares/creates environment files"
    "User prepares/creates environment files" --> "environment/production.1.yaml"
    "User prepares/creates environment files" --> "environment/staging.1.yaml"
    "User prepares/creates environment files" --> "environment/testing.1.yaml"
    "environment/production.1.yaml" --> "Uploads files to servers"
    "environment/staging.1.yaml" --> "Uploads files to servers"
    "environment/testing.1.yaml" --> "Uploads files to servers"
    --> "Copy files according current\n environment to environment/1.yaml"
    --> "Executes module \nactivation command(s)"
    --> (*)

    @enduml


Configuration files preparation
-------------------------------

Let's say you are configuring modules on your local machine (how to do this please read the
:ref:`modules configuration document <configuring_module-20190910>`). After your are done, you have prepared files in
`var/configuration/shops/` directory.

Dealing with environment files
------------------------------

Let's assume you have OXID eShop with PayPal module and you want to deploy your configuration from your development
environment to staging environment. All settings in both environments are the same except ``sOEPayPalUsername``
and ``sOEPayPalPassword``. So you would need all the time after deployment to change these values
as configuration files would be overwritten. To solve this problem, `environment` feature
was introduced.

Environment files overwrite settings which are already described in configuration files located in
:file:`var/configuration/shops/` directory.

To use this feature you need to create the directory :file:`var/configuration/environment` and put stripped down contents
of :file:`var/shops/<shop id>.yaml` in there. Here you may configure environment specific values, for example
credentials for payment providers.

So to solve the problem described in the beginning of the section follow these steps:

1. On staging environment `1.yaml` (assuming it's main shop)
   file inside the :file:`var/configuration/environment` directory.
2. Copy and paste the part of your module settings from :file:`var/shops/1.yaml`
   to :file:`var/configuration/environment/1.yaml`.
3. Write your new values  for ``sOEPayPalUsername`` and ``sOEPayPalPassword`` and save your file.

Environment file :file:`var/configuration/environment/1.yml` should look something like this:

.. code:: yaml

    modules:
      oepaypal:
        moduleSettings:
          sOEPayPalUsername
            value: 'staging_environment_username'
          sOEPayPalPassword
            value: 'staging_environment_password'

New values will get into database as soon as module will be **activated**.

In case you have 3 environments: testing, staging and production, files structure could look like this:

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
             └──production.1.yml
             └──staging.1.yml
             └──testing.1.yml
             └──2.yml
             └──production.2.yml
             └──staging.2.yml
             └──testing.2.yml
             └── ...

In described files structure you can see that there are multiple
files per shop in :file:`var/configuration/environment` directory. This might be useful when deploying files to some
specific environment.

Next steps would be:

* **Upload** files to the production server.
* **Copy** testing, staging or production file on top of main environment file. Example command:

    .. code:: bash

        cp var/configuration/environment/production.1.yml var/configuration/environment/1.yml

* **Activate** modules. More information can be found in following sections.

Activating modules
------------------

When modules are installed and configured they can be activated. There are few ways how to achieve this, check sections
bellow.

Manual module activation
^^^^^^^^^^^^^^^^^^^^^^^^

In case you activate module manually (:ref:`via admin <modules_installation_activate_via_admin-20190917>`
or via :ref:`single module activation command <modules_installation_activate_via_command-20190917>`)
the ``configured`` option in configuration file will be set to ``true`` and after the module deactivation:
set back to ``false``. More about the ``configured`` option please read
:ref:`section above <activate_configured_modules-20190829>`.

.. _activate_configured_modules-20190829:

Activate all configured modules
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each module configuration in the shop configuration yml file has a ``configured``
option (``false`` by default). If it's ``true``, it means that the module is in configured state and prepared
for the activation/reactivation.

The option can be set manually or by changing configuration file or by activating a module manually.

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

You can activate/reactivate all configured modules for all available shops via the console command:

.. code:: bash

    vendor/bin/oe-console oe:module:activate-configured-modules

or only for the one shop if `--shop-id` option is provided:

.. code:: bash

    vendor/bin/oe-console oe:module:activate-configured-modules --shop-id=1

.. note::

  Module data and extensions chains in the database will be overwritten after every module
  activation/deactivation with the data from the module configuration.

Changing settings when environment files are present
----------------------------------------------------

If you deploy base and environment configurations from VCS, these should not be changed
through the admin backend. If you do this, the environment specific values will be
merged into the base configuration and the environment configuration will be renamed to `.bak` file like `1.yml.bak`.
Then your manual changes will be applied to the base configuration and then to the
modules. Be aware that if there is already an environment backup file, it will be overridden if setting  will change again.

This in itself is not a problem, but when you redeploy the configuration, all your
changes in base configuration will be overwritten. If you change settings through the admin backend
ensure that these changes are reflected in the VCS version of the configuration to avoid trouble on redeployment.
