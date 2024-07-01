Version 2.1
===========

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.

Changes compared to version 2.0
-------------------------------

* New section ``smartyPluginDirectories``: Its now possible to add Smarty plugins into a module by defining them in
  the metadata.php. Read the section :doc:`smartyPluginDirectories <amodule/smartyPluginDirectories>` for
  details.

.. _modules_skeleton_metadata_v21_structure:

Structure
---------

On the top level of the PHP file metadata.php, there have to be exactly 2 variables:
``$sMetadataVersion (String)`` and ``$aModule (Array)``. No other variables or code are allowed.

.. code:: php

    <?php

    $sMetadataVersion = '2.1';
    $aModule = [
        'id' => ...
        ...
    ]

The array ``$aModule`` can contain multiple sub keys:

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

       amodule/blocks

       amodule/settings

       amodule/smartyPluginDirectories

       amodule/templates

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
