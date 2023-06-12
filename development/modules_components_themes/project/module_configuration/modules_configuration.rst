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

    If the :file:`var` directory cannot be found in the project directory, execute ``composer update`` or create the :file:`var` directory manually.

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
                        └──oe_moduletemplate.yaml

The configuration might be different in different environment (testing, staging or productive). To solve this problem,
OXID eShop uses another directory with configuration files located in `var/environment/<shop-id>/`.

Example structure:

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

During the installation process, all of the information from module `metadata.php` is being transferred to the
configuration files.

For example you have OXID eShop without any modules, so `var/configuration/shops/modules/` will be empty.

When you will run the installation let's say for the OXID eShop Module Template module, the files in `var/configuration/shops/` will be filled with information from `metadata.php`.

An example of stripped down configuration file :file:`var/configuration/shops/modules/1/oe_moduletemplate.yaml`:

.. code:: yaml

    id: oe_moduletemplate
    version: 1.0.0
    activated: true
    title:
      en: 'OxidEsales Module Template (OEMT)'
    description:
      en: ''
    lang: ''
    thumbnail: pictures/logo.png
    author: 'OXID eSales AG'
    url: ''
    email: ''
    classExtensions:
      OxidEsales\Eshop\Application\Model\User: OxidEsales\ModuleTemplate\Model\User
      OxidEsales\Eshop\Application\Controller\StartController: OxidEsales\ModuleTemplate\Controller\StartController
    controllers:
      oemtgreeting: OxidEsales\ModuleTemplate\Controller\GreetingController
    events:
      onActivate: '\OxidEsales\ModuleTemplate\Core\ModuleEvents::onActivate'
      onDeactivate: '\OxidEsales\ModuleTemplate\Core\ModuleEvents::onDeactivate'
    moduleSettings:
      oemoduletemplate_GreetingMode:
        group: oemoduletemplate_main
        type: select
        value: generic
        constraints:
          - generic
          - personal
      oemoduletemplate_BrandName:
        group: oemoduletemplate_main
        type: str
        value: Testshop



Also, the file with the module class extension chain will be generated.

Example: :file:`var/configuration/shops/1/class_extension_chain.yaml`:

.. code:: yaml

        OxidEsales\Eshop\Application\Model\User:
            - OxidEsales\ModuleTemplate\Model\User


