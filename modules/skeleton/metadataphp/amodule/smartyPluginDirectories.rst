smartyPluginDirectories
=======================

Description
    You can define directories (relative to your module directory) where smarty should search for smarty plugins.

    The order in which smarty searches for plugins is:

    #. Smarty plugins from directories defined in module X which was activated as first module.

    #. Smarty plugins from directories defined in module Y which was activated as second module.

    #. OXID eShop smarty plugins from the directory :file:`Core/Smarty/Plugin`.

    The plugins of the module which were registered first, have priority over the modules which were activated later.
    This also means e.g. if you specify a smarty plugin with the same name in module X, it overwrites the OXID eShop
    smarty plugin from the directory :file:`Core/Smarty/Plugin`.

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


