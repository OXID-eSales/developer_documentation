Module configuration deployment
===============================

This document describes an example deployment workflow for module configurations across different environments in OXID eShop.

Overview
--------

After preparing your environment-specific configurations (see :doc:`modules_environment_configuration`), you need a process to deploy them to your target environments.
Below is an example of how such a deployment workflow could look like.

Prerequisites
-------------

Install the deployment tools using Composer::

    composer require oxid-esales/deployment-tools

Example Deployment Workflow
---------------------------

The deployment process follows these steps:

.. uml::

    @startuml
    start
    :Set up base configuration;
    :Create environment-specific overrides;
    :Upload files to server;
    :Set OXID_ENV according to target environment;
    :Run oe:module:deploy-configurations command;
    stop
    @enduml

1. **Set up base configuration**

   Create the base configuration in ``var/configuration/shops/<shop-id>/modules/<module-id>.yaml`` containing all basic module settings.

2. **Create environment-specific overrides**

   Create override configurations in ``var/configuration.<env>/shops/<shop-id>/modules/<module-id>.yaml`` containing only the settings that differ from the base configuration.

3. **Server Deployment**

   * Upload all configuration files to the target server

   * Ensure the correct ``OXID_ENV`` variable is set for your target environment

4. **Execute Deployment Command**

   For all shops (Professional Edition or all Enterprise Edition shops)::

       vendor/bin/oe-console oe:module:deploy-configurations

   For a specific shop in Enterprise Edition::

       vendor/bin/oe-console oe:module:deploy-configurations --shop-id=1

.. note::
    This is just an example workflow. Adapt it to your specific needs and deployment processes.
