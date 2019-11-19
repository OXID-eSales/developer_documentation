Module settings
===============

OXID eShop module functionality has a feature which allows easily configure module settings via admin web interface.

Using module settings
---------------------

To use module settings feature you need to define module settings in your module :file:`metadata.php` file. How
the settings structure looks please check
:doc:`settings documentation page <skeleton/metadataphp/amodule/settings>`.

When settings are described, module configuration must be installed, the command can be found in
:doc:`module development document <tutorials/module_setup>`.

In OXID eShop admin backend settings will be displayed in:
:menuselection:`Extensions -->  Modules`, please select your module and click :menuselection:`Settings`.

Changing settings in non standard way
-------------------------------------

In case there is a need to change module setting not through the standard way (see section above), but a custom way.
For example you want to have custom settings page for your module.
To achieve this you still need to define all of the settings in :file:`metadata.php`
file. If you don't want that these settings would be displayed in :menuselection:`Settings` page, don't add
:ref:`group <metadataphpversion-settings-hiding-settings-20190926>`.
To save settings OXID eShop has settings bridge which allows to save them:

.. code:: php

        $moduleSettingBridge = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ModuleSettingBridgeInterface::class);
        $moduleSettingBridge->save('setting-name', 'value', 'module-id');

Settings bridge not only will save data into database, but it will also persist setting into the configuration yaml
file. More info about configuration files please read in
:ref:`module configuration documentation <configuring_module_via_configuration_files-20190829>`.

Receiving module setting
------------------------

In OXID eShop backend to receive module setting please use settings bridge. Example bellow:

.. code:: php

        $moduleSettingBridge = ContainerFactory::getInstance()
            ->getContainer()
            ->get(ModuleSettingBridgeInterface::class);
        $moduleSettingBridge->get('setting-name', 'module-id');

The bridge will return setting directly from the configuration file.
