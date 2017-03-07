Version 2.0
===========

Changes compared to version 1.1
-------------------------------

To be able to use namespaces for module controllers, we introduce
module's metadata.php version 2.0 with a new section ``controllers``.
The support for ``files`` was dropped in Module's metadata version 2.0. Classes in a namespace will be found by the autoloader.
If you use your own namespace, register it in the module's composer.json file.

.. important::

  You can use metadata version 2.0 with controllers only for modules using namespaces. When using modules
  without a namespace you will have to use metadata version 1.0 with the 'files' section to register your module controllers.


id
--

The extension id must be unique. It is recommended to use vendor prefix + module root directory name. Module ID is used for getting all needed information about extension. If this module has defined config variables in ``oxconfig`` and ``oxconfigdisplay`` tables (e.g. ``module:efifactfinder``), the extension id used in these tables should match extension id defined in metadata file. Also same id (``efifactfinder``) must be used when defining extension templates blocks in ``oxtplblocks`` table.

.. note::

  the extension id for modules written for OXID eShop versions >= 4.9.0 mustn't be > 93 characters. Please also see https://bugs.oxid-esales.com/view.php?id=5549.

title
-----

Used to display extension title in the extensions list and detail information.

description
-----------

Used to display extension description in the extension detail information page. This field is multilang capable.

lang
----

Default extension language. Displaying extension title or description there will be checked if these fields have a selected language. If not, the selected language defined in the lang field will be selected. E.g. if admin is opened in German and extension is available in English, the English title and description value will be shown as there is translation into German.

thumbnail
---------

Extension thumbnail filename. Thumbnail should be in root folder and it is displayed in admin under extension details page.

version
-------

The version number of this extension.

author
------

The author/developer of this extension.

url
---

Link to module writer web page.

email
-----

Module vendor email.

extend
------

On this place shall be defined which shop classes are extended by this module.
You can use metadata version 2.0 with :ref:`controllers<controllers-20170307>` only for modules using namespaces.

.. code:: php

  'extend'       => array(
        \OxidEsales\Eshop\Application\Model\Payment::class => MyVendor\MyModuleNamespace\Application\Model\MyModulePayment::class,
        \OxidEsales\Eshop\Application\Model\Article::class => MyVendor\MyModuleNamespace\Application\Model\MyModuleArticle::class
    ),

This information is used for activating/deactivating extension.

.. _controllers-20170307:

controllers
-----------

At this place, you can define, which controllers should be able to be called directly, e.g. from templates.
You can define a routing of ``controller keys`` to module classes.

The key of this array

* is a identifier (``controller key``) which should be unique over all OXID eShop modules. Use vendor id and module id for prefixing.
* Take care you declare the keys always in lower case!

The value is the assigned class which should also be unique.


.. code:: php

    'controllers'  => [
        'myvendor_mytestmodule_mymodulecontroller' => MyVendor\mytestmodule\MyModuleController::class,
        'myvendor_mytestmodule_myothermodulecontroller' => MyVendor\mytestmodule\MyOtherModuleController::class,
    ],

Now you can route requests to the module controller e.g. in a template:

.. code:: php

    <form action="[{$oViewConf->getSelfActionLink()}]" name="MyModuleControllerAction" method="post" role="form">
        <div>
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="cl" value="myvendor_mytestmodule_mymodulecontroller">
            <input type="hidden" name="fnc" value="displayMessage">
            <input type="text" size="10" maxlength="200" name="mymodule_message" value="[{$the_module_message}]">
            <button type="submit" id="MyModuleControllerActionButton" class="submitButton">[{oxmultilang ident="SUBMIT"}]</button>
        </div>
    </form>

If the controller key is not found within the shop or modules, it is assumed that the controller key is a class with this name.
If there is no class with this name present, the OXID eShop will redirect to the shop front page.



blocks
------

In this array are registered all module templates blocks. On module activation they are automaticly inserted into database. On activating/deactivating module, all module blocks also are activated/deactivated

.. code:: php

  'blocks' => array(
        array('template' => 'widget/sidebar/partners.tpl', 'block'=>'partner_logos',                     'file'=>'/views/blocks/oepaypalpartnerbox.tpl'),
        array('template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_top',               'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        array('template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_bottom',            'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        array('template' => 'page/checkout/payment.tpl',   'block'=>'select_payment',                    'file'=>'/views/blocks/oepaypalpaymentselector.tpl'),
    ),
    )

The template block ``file`` value has to be specified directly from module root.

settings
--------

There are registered all module configuration options. On activation they are inserted in config table and then in backend you can configure module according these options. Lets have a look at the code to become a clearer view.

.. code:: php

  'settings' => array(
        array('group' => 'main', 'name' => 'dMaxPayPalDeliveryAmount', 'type' => 'str',      'value' => '30'),
        array('group' => 'main', 'name' => 'blPayPalLoggerEnabled',    'type' => 'bool',     'value' => 'false'),
        array('group' => 'main', 'name' => 'aAlwaysOpenCats',          'type' => 'arr',      'value' => array('Preis','Hersteller')),
        array('group' => 'main', 'name' => 'aFactfinderChannels',      'type' => 'aarr',     'value' => array('1' => 'de', '2' => 'en')),
        array('group' => 'main', 'name' => 'sConfigTest',              'type' => 'select',   'value' => '0', 'constraints' => '0|1|2|3', 'position' => 3 ),
        array('group' => 'main', 'name' => 'sPassword',                'type' => 'password', 'value' => 'changeMe')
    )

Each setting belongs to a group. In this case its called ``main``. Then follows the name of the setting which is the variable name in oxconfig/oxconfigdisplay table. It is best practice to prefix it with your moduleid to avoid name collisions with other modules. Next part is the type of the parameter and last part is the default value.

In order to get correct translations of your settings names in admin one should create views/admin//module_options.php where is the language with 2 letters for example ``en`` for english. There should be placed the language constants according to the following scheme:

.. code:: php

  // Entries in module_options.php for above code examples first entry:
  'SHOP_MODULE_GROUP_main'                    => 'Paypal settings',
  'SHOP_MODULE_dMaxPayPalDeliveryAmount'      => 'Maximal delivery amount',
  'HELP_SHOP_MODULE_dMaxPayPalDeliveryAmount' => 'A help text for this setting',

So the shop looks in the file for a language constant like ``SHOP_MODULE_GROUP_`` and for the single setting for a language constant like ``SHOP_MODULE_``.
In php classes you can query your module settings by using the ``function getConfigParam()`` of ``Config`` class:


.. code:: php

  $myconfig = Registry::getConfig();
  $myconfig->getConfigParam("dMaxPayPalDeliveryAmount");


templates
---------

Module templates array. All module templates should be registered here, so on requiring template shop will search template path in this array.

.. code:: php

  'templates' => array('order_dhl.tpl' => 'oe/efi_dhl/out/admin/tpl/order_dhl.tpl')


events
------

Module events were introduced in metadata version 1.1. Currently there are only 2 of them (onActivate and onDeactivate), more events will be added in future releases.

.. code:: php

  'events'       => array(
        'onActivate'   => 'oepaypalevents::onActivate',
        'onDeactivate' => 'oepaypalevents::onDeactivate'
    ),

custom JavaScript / CSS / Images
--------------------------------

Create out/src/js/, out/src/img/ and out/src/css/ directories so it fit Shop structure and would be easier to debug for other people. You can use something like this to include your scripts in to templates:

.. code:: php

  [{oxscript include=$oViewConf->getModuleUrl("{moduleID}", "out/src/js/{js_fle_name}.js")}]


Metadata file version
---------------------

.. code:: php

  $sMetadataVersion = '2.0';



Multilanguage fields
--------------------

Extension description is a multilanguage field. This should be an array with a defined key as language abbervation and the value of it's translation.

.. code:: php

  'description'  => array(
    'de'=>'Intelligente Produktsuche und Navigation.',
    'en'=>'Intelligent product search and navigation.',
  )


The field value also can be a simple string. If this field value is not an array but simple text, this text string will be displayed in all languages.

Mandatory fields
----------------

The list of fields that are mandatory for metadata file:

* metadata version
* id
* title
* extend
* blocks (if module has any templates blocks)
* settings (if module has any settings)

Vendor directory support
------------------------

All modules can be placed not directly in shop modules directory, but also in vendor directory. In this case the ``vendormetadata.php`` file must be placed in the vendor directory root. If the modules handler finds this file on scanning the shop modules directory, it knows that this is vendor directory and all subdirectories in this directory should be scanned also. Currently the ``vendormetadata.php`` file can be empty, in future here will be added some additional information about the module vendor.
Vendor directory structure example:

.. code::

  modules
    oxid
      module1
        module1 files
      module2
        module2 files
      module3
        module3 files


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
