Modules configuration and setup
===============================

.. contents ::
    :local:
    :depth: 2

Overview
--------

In most cases modules need to be configured before you can proceed with setup and activate it. There
are two ways of configuring modules:

1. :ref:`Configuring modules via admin interface <configuring_module_via_admin-20190829>`

2. The automatic deployment friendly way
   by :ref:`Configuring modules via providing configuration files <configuring_module_via_configuration_files-20190829>`

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
                :Execute on activate action/events;
            else (Deactivate)
                :Execute on deactivate action/events;
            endif
        }
        stop
    @enduml

.. _configuring_module-20190910:

Configuration
-------------

.. _configuring_module_via_admin-20190829:

Configuring modules via admin interface
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To configure modules via admin interface, open OXID eShop administration panel
and go to :menuselection:`Extensions --> Modules`.

You will see a list of installed modules.

Select the module you want to configure and choose :menuselection:`Settings`.

You will see a list of settings that you can change.

Entries in the settings list are loaded and saved in configuration files located in `var/configuration/shops`.

For each shop id there is one directory with the complete configuration for this shop.

So if the shop has id 1, a directory would be named 1. See the example below:

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1
             └──2
             └── ...

.. note::

    If var directory cannot be found in the project directory.
    ``composer update`` must be executed or it must be created manually.
    Also, each shop must have their own separate directory.

.. _configuring_module_via_configuration_files-20190829:

Configuring modules via providing configuration files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Since the complete configuration is in configuration files, you can make it part of the
VCS repository of your project and deploy it to your testing, staging and productive
systems and deploy through the command line as described below in the
section :ref:`deploy module configurations<apply_configuration_configured_modules-20190829>`.

Project configuration files are located in project directory `var/shops/<shop-id>/`, here "<shop-id>" represents
Sub-shop ID. In case you don't use Sub-shop functionality, it will always be only one directory.

Each directory with a shop configuration has `class_extension_chain.yaml` file with the module class extension chain
and a separate subdirectory `modules` for module configurations, configuration for every module is in a separate file
where filename is the module id: `var/environment/<shop-id>/modules/<module-id>.yaml`

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1
                      └──class_extension_chain.yaml
                      └──modules
                        └──oepaypal.yaml
                        └──oegdproptin.yaml

Configuration might be different in different environment (testing, staging or productive). To solve this problem
OXID eShop uses another directory with configuration files located in `var/environment/<shop-id>/`.

Example structure you can see bellow:

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1
             └──2
             └── ...
          └── environment
             └──1
             └──2
             └── ...

Configuration files
"""""""""""""""""""

These files contains information of all modules which are :doc:`installed </development/modules_components_themes/module/installation_setup/installation>`.
During the installation process all of the information from module `metadata.php` is being transferred to the
configuration files. For example you have OXID eShop without any modules, so `var/configuration/shops/<shop-id>/modules/` will be empty. When you will run
installation let's say for OXID eShop Gdpr-Opt-In module, files in `var/configuration/shops/` will be filled with information from
`metadata.php`. An example of stripped down configuration file:

Example: `var/configuration/shops/modules/1/oegdproptin.yaml`

.. code:: yaml

        id: oegdproptin
        moduleSource: vendor/oxid-esales/gdpr-optin-module
        version: 3.0.0
        activated: true
        title:
          de: 'GDPR Opt-in'
          en: 'GDPR Opt-in'
        description:
          de: 'Das Modul stellt Opt-in-Funktionalit&auml;t f&uuml;r die Datenschutz-Grundverordnung (DSGVO) bereit'
          en: 'This module provides the opt-in functionality for the European General Data Protection Regulation (GDPR)'
        lang: ''
        thumbnail: logo.png
        author: 'OXID eSales AG'
        url: 'https://www.oxid-esales.com/'
        email: ''
        classExtensions:
          OxidEsales\Eshop\Core\ViewConfig: OxidEsales\GdprOptinModule\Core\ViewConfig
          OxidEsales\Eshop\Application\Component\Widget\ArticleDetails: OxidEsales\GdprOptinModule\Component\Widget\ArticleDetails
          OxidEsales\Eshop\Application\Component\Widget\Review: OxidEsales\GdprOptinModule\Component\Widget\Review
          OxidEsales\Eshop\Application\Component\UserComponent: OxidEsales\GdprOptinModule\Component\UserComponent
          OxidEsales\Eshop\Application\Controller\ReviewController: OxidEsales\GdprOptinModule\Controller\ReviewController
          OxidEsales\Eshop\Application\Controller\ArticleDetailsController: OxidEsales\GdprOptinModule\Controller\ArticleDetailsController
          OxidEsales\Eshop\Application\Controller\ContactController: OxidEsales\GdprOptinModule\Controller\ContactController
        events:
          onActivate: 'OxidEsales\GdprOptinModule\Core\GdprOptinModule::onActivate'
          onDeactivate: 'OxidEsales\GdprOptinModule\Core\GdprOptinModule::onDeactivate'
        moduleSettings:
          blOeGdprOptinInvoiceAddress:
            group: oegdproptin_settings
            type: bool
            value: false
          blOeGdprOptinDeliveryAddress:
            group: oegdproptin_settings
            type: bool
            value: false
          blOeGdprOptinUserRegistration:
            group: oegdproptin_settings
            type: bool
            value: false
          blOeGdprOptinProductReviews:
            group: oegdproptin_settings
            type: bool
            value: true
          OeGdprOptinContactFormMethod:
            group: oegdproptin_contact_form
            type: select
            value: deletion
            constraints:
              - deletion
              - statistical


Also the file with the module class extension chain will be generated.

Example: `var/configuration/shops/1/class_extension_chain.yaml`

.. code:: yaml

        OxidEsales\Eshop\Core\ViewConfig:
          - OxidEsales\GdprOptinModule\Core\ViewConfig

