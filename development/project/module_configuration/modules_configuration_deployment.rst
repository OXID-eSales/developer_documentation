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
    --> "Run apply-configuration command"
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

.. important::

    If you have environment configuration files in the OXID eShop you should not save settings via admin backend.
    If you do this, the environment specific values will be
    merged into the base configuration and the environment configuration will be renamed to `.bak` file like `1.yml.bak`.
    Then your manual changes will be applied to the base configuration and then to the
    modules.
    Be aware that if there is already an environment backup file, it will be overridden if setting  will change again.

Next steps would be:

* **Upload** files to the production server.
* **Copy** testing, staging or production file on top of main environment file. Example command:

    .. code:: bash

        cp var/configuration/environment/production.1.yml var/configuration/environment/1.yml

* **Apply configuration** for all configured modules. More information can be found in following section.

.. _apply_configuration_configured_modules-20190829:

Apply configuration
-------------------

Each module configuration in the shop configuration yml file has a ``configured``
option and It can have two states:

* ``true`` means that the module is prepared for the activation.
* ``false`` means that the module is prepared for the deactivation.

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

This option can be set manually by changing configuration file.
Also this will be changed if module will be activated or deactivated manually.

To apply configuration use the following command:

.. code:: bash

    vendor/bin/oe-console oe:module:apply-configuration

Provide ``--shop-id`` option if it is only for one shop.

.. code:: bash

    vendor/bin/oe-console oe:module:apply-configuration --shop-id=1

.. important:: When command is executed module data in configuration files will overwrite data in database.
