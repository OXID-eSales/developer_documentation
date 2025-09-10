metadata.php
============

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.

Each OXID eShop module has its metadata defined via the :file:`metadata.php` file, located in the module's root directory.

Structure
---------

On the top level of the PHP file metadata.php, there have to be exactly two variables:
``$sMetadataVersion (String)`` and ``$aModule (Array)``. No other variables or code are allowed.

.. code:: php

    <?php

    $sMetadataVersion = '2.1';
    $aModule = [
        'id' => ...
        ...
    ]

The string ``$sMetadataVersion`` defines the Metadata version. Since OXID eShop 6.1, the current version is 2.1.

The array ``$aModule`` is for basic information as well as different extension configuration. It can contain multiple sub keys:

    .. toctree::
       :maxdepth: 1

       amodule/id

       amodule/title

       amodule/description

       amodule/lang

       amodule/thumbnail

       amodule/version

       amodule/author

       amodule/url

       amodule/email

       amodule/extend

       amodule/controllers

       amodule/settings

       amodule/events


Example of metadata.php
-----------------------

Here is an example of a module metadata file:

.. code:: php

    Example for module using namespaces

    <?php
    /**
     * Metadata version
     */
    $sMetadataVersion = '2.1';
    /**
     * Module information
     */
    $aModule = [
        'id'           => 'myvendor_mytestmodule',
        'title'        => 'Test metadata controllers feature',
        'description'  => '',
        'thumbnail'    => 'picture.png',
        'version'      => '2.0',
        'author'       => 'OXID eSales AG',
        'controllers'  => [
            'myvendor_mytestmodule_MyModuleController' => MyVendor\mytestmodule\MyModuleController::class,
            'myvendor_mytestmodule_MyOtherModuleController' => MyVendor\mytestmodule\MyOtherModuleController::class,
        ],
        'templates' => [
            'mytestmodule.tpl' => 'mytestmodule.tpl',
            'mytestmodule_other.tpl' => 'test_module_controller_routing_other.tpl'
        ],
        'smartyPluginDirectories' => [
            'Smarty/PluginDirectory'
        ],
    ];


.. toctree::
    :titlesonly:
    :glob:
    :maxdepth: 1

    amodule/index
    *
