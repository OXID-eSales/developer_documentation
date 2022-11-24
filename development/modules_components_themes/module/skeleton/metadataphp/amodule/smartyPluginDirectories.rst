smartyPluginDirectories (Smarty only)
=====================================

Description
    You can define directories (relative to your module directory) where Smarty should search for plugins.

    The order in which Smarty searches for plugins is:

    #. Smarty plugins from directories defined in module X which was activated as first module.

    #. Smarty plugins from directories defined in module Y which was activated as second module.

    #. OXID eShop Smarty plugins from the directory :file:`vendor/oxid-esales/smarty-component/src/Plugin/`.

    The plugins of the module which were registered first, have priority over the modules which were activated later.
    This also means e.g. if you specify a Smarty plugin with the same name in module X, it overwrites the OXID eShop
    Smarty plugin from the directory :file:`vendor/oxid-esales/smarty-component/src/Plugin/`.

Type
    Array of strings

Mandatory
    No

Example
    .. code:: php

        'smartyPluginDirectories' => [
            'Smarty/PluginDirectory1',
            'Smarty/PluginDirectory2'
        ],
