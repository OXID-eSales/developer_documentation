Module configuration deployment
===============================

This document describes a possible deployment process which could be used for the application.

The workflow can be seen in image below, schema steps are described in the following sections.

.. uml::

    @startuml

    (*)--> "User prepares configuration files"
    --> "User prepares/creates environment files"
    "User prepares/creates environment files" --> "environment/production/shops/1/modules/{module_id}.yaml"
    "User prepares/creates environment files" --> "environment/staging/shops/1/modules/{module_id}.yaml"
    "User prepares/creates environment files" --> "environment/testing/shops/1/modules/{module_id}.yaml"
    "environment/production/shops/1/modules/{module_id}.yaml" --> "Uploads files to servers"
    "environment/staging/shops/1/modules/{module_id}.yaml" --> "Uploads files to servers"
    "environment/testing/shops/1/modules/{module_id}.yaml" --> "Uploads files to servers"
    --> "Copy files according current\n environment to environment/shops/1/modules/{module_id}.yaml"
    --> "Run oe:module:deploy-configurations command"
    --> (*)

    @enduml


Preparing configuration files
-----------------------------

Let's say you are configuring modules on your local machine (how to do this please read the
:ref:`modules configuration document <configuring_module-20190910>`).

After you are done, you have stored your files in the :file:`var/configuration/shops/` directory.

Dealing with environment files
------------------------------

Let's assume you have OXID eShop with Module Template module and you want to deploy your configuration from your development
environment to your staging environment. All settings in both environments are the same, except ``oemoduletemplate_Password``.

So, you would need all the time after deployment to change these values as configuration files would be overwritten.

To solve this problem, the `environment` feature was introduced.

Environment files overwrite settings which are already described in configuration files located in the
:file:`var/configuration/shops/` directory.

To use this feature, create the :file:`var/configuration/environment` directory and put stripped down contents
of a module configuration file :file:`var/configuration/environment/shops/<shop-id>/modules/<module-id>.yaml` in there.

Here, you may configure environment specific values, for example
credentials for payment providers.

To solve the problem described in the beginning of the section, follow the following steps:

1. On the staging environment (assuming its main shop with id `1` and the module id is `oe_moduletemplate`), create a
   file with the name of the module id inside the :file:`var/configuration/environment/shops/1/modules` directory.
2. Copy and paste the part of your module settings from :file:`var/configuration/shops/1/modules/oe_moduletemplate.yaml`
   to :file:`var/configuration/environment/shops/1/modules/oe_moduletemplate.yaml`.
3. Write your new value for ``oemoduletemplate_Password`` and save your file.

Example of the environment file :file:`var/configuration/environment/shops/1/modules/oe_moduletemplate.yaml`:

.. code:: yaml

    moduleSettings:
      oemoduletemplate_Password:
        value: staging_environment_password

Don't forget to clean the module cache after updating your yaml files.

.. important::

    If you have environment configuration files in the OXID eShop you should not save settings via the admin backend.

    If you do this, the environment specific values will be
    merged into the base configuration and the environment configuration for the module will be renamed to `.bak` file like `oe_moduletemplate.yaml.bak`.

    Be aware that if there is already an environment backup file, it will be overridden if the settings change again.

Next steps would be:

* **Uploading** directories to the production server.
* **Copying** testing, staging or production directory on top of main environment directory.

  Example command:

    .. code:: bash

        cp var/configuration/environment/production/ var/configuration/environment/

* **Deploying module configurations**. For more information, see the following section.

.. _apply_configuration_configured_modules-20190829:

Deploying module configurations
-------------------------------

Make sure that module settings in different environments work the same.

-----------------------------------------------------

Example: You have activated and configured a module in a test environment. Then you install the module in the production environment and copy the module's configuration file from the test to the production environment.

To make sure the configuration in your production environment works the same as in you test environment, you execute the deployment tool.

------------------------------------------------------

|procedure|

1. Install the deployment tool.

   .. code:: bash

      composer require oxid-esales/deployment-tools

#. Edit the configuration file. Set, for example, the activation status.

   Example of the module yaml file:

   .. code:: yaml

      id: oe_moduletemplate
      activated: true
      ...

   Each module configuration file has an ``activated`` option, and it can have two states:

   * ``true`` means that the module is prepared for the activation or already active.
   * ``false`` means that the module is prepared for the deactivation or already inactive.

   Also, the option will be set to ``true`` if you activate a module manually via console or admin backend or to false if you deactivate your module.

#. Execute the following command depending on the intended scope.

   * If you have the OXID eShop Professional Edition or want to configure all subshops of an Enterprise Edition, omit the :technicalname:`shop-id` parameter.

     .. code:: bash

        vendor/bin/oe-console oe:module:deploy-configurations

   * If you use an OXID eShop Enterprise Edition and it is only for one shop, specify the :technicalname:`--shop-id` parameter.

     .. code:: bash

        vendor/bin/oe-console oe:module:deploy-configurations --shop-id=1




