.. _metadata_version2-20170427:

Version 2.0
===========

Changes compared to version 1.1
-------------------------------

* New Section Controllers: To be able to use namespaces for module controllers, we introduce
  module's metadata.php version 2.0 with a new section ``controllers``.
  The support for ``files`` was dropped in Module's metadata version 2.0. Classes in a namespace will be found by the autoloader.
  If you use your own namespace, :doc:`register it in the module's composer.json file </development/modules_components_themes/module/skeleton/composerjson/module_via_composer>`.

.. important::

  You can use metadata version 2.0 with controllers only for modules using namespaces. When using modules
  without a namespace you will have to use metadata version 1.0 with the 'files' section to register your module controllers.

Structure
---------

On the top level of the PHP file metadata.php, there have to be exactly 2 variables:
``$sMetadataVersion (String)`` and ``$aModule (Array)``. No other variables or code are allowed.

.. code:: php

    <?php

    $sMetadataVersion = '2.0';
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
    $sMetadataVersion = '2.0';
    /**
     * Module information
     */
    $aModule = array(
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
            'mytestmodule.tpl' => 'mytestmodule/mytestmodule.tpl',
            'mytestmodule_other.tpl' => 'mytestmodule/test_module_controller_routing_other.tpl'
        ]
    );
