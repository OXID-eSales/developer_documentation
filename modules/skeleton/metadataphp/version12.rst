Version 1.2
===========

Changes compared to version 1.1
-------------------------------

* New :ref:`setting type <metadataphpversion12-settings-20190911>`- ``password``

id
--

The extension id must be unique. It is recommended to use vendor prefix + module root directory name. Module ID is used for getting all needed information about extension. If this module has defined config variables in ``oxconfig`` and ``oxconfigdisplay`` tables (e.g. ``module:efifactfinder``), the extension id used in these tables should match extension id defined in metadata file. Also same id (``efifactfinder``) must be used when defining extension templates blocks in ``oxtplblocks`` table.

.. note::

  The extension id for modules written for OXID eShop versions >= 4.7.0 mustn't be > 25 characters. The extension id for modules written for OXID eShop versions >= 4.9.0 mustn't be > 93 characters. Please also see https://bugs.oxid-esales.com/view.php?id=5549.

title
-----

Used to display extension title in the extensions list and detail information.

description
-----------

Used to display extension description in the extension detail information page. This field is :ref:`multilang capable<multilanguage_fields-20170315>`

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

On this place shall be defined which shop classes are extended by this module. Here is an example:

.. code:: php

  'extend'       => array(
        'order'        => 'oe/oepaypal/controllers/oepaypalorder',
        'payment'      => 'oe/oepaypal/controllers/oepaypalpayment',
        'wrapping'     => 'oe/oepaypal/controllers/oepaypalwrapping',
        'oxviewconfig' => 'oe/oepaypal/controllers/oepaypaloxviewconfig',
        'oxaddress'    => 'oe/oepaypal/models/oepaypaloxaddress',
        'oxuser'       => 'oe/oepaypal/models/oepaypaloxuser',
        'oxorder'      => 'oe/oepaypal/models/oepaypaloxorder',
        'oxbasket'     => 'oe/oepaypal/models/oepaypaloxbasket',
        'oxbasketitem' => 'oe/oepaypal/models/oepaypaloxbasketitem',
        'oxarticle'    => 'oe/oepaypal/models/oepaypaloxarticle',
        'oxcountry'    => 'oe/oepaypal/models/oepaypaloxcountry',
        'oxstate'      => 'oe/oepaypal/models/oepaypaloxstate',
    ),

This information is used for activating/deactivating extension.
Take care you declare the keys (e.g. oxorder) always in lower case!
Take care you declare the file names case sensitive!
It is suggested to use lower case for file names, to avoid difficulties.

files
-----

All module php files that do not extend any shop class. On request shop autoloader checks this array and if class name is registered in this array, loads class. So now no need to copy module classes to shop ``core`` or ``view`` folder and all module files can be in module folder.

.. code:: php

  'files' => array(
        'oePayPalException'                 => 'oe/oepaypal/core/exception/oepaypalexception.php',
        'oePayPalCheckoutService'           => 'oe/oepaypal/core/oepaypalcheckoutservice.php',
        'oePayPalLogger'                    => 'oe/oepaypal/core/oepaypallogger.php',
        'oePayPalPortlet'                   => 'oe/oepaypal/core/oepaypalportlet.php',
        'oePayPalDispatcher'                => 'oe/oepaypal/controllers/oepaypaldispatcher.php',
        'oePayPalExpressCheckoutDispatcher' => 'oe/oepaypal/controllers/oepaypalexpresscheckoutdispatcher.php',
        'oePayPalStandardDispatcher'        => 'oe/oepaypal/controllers/oepaypalstandarddispatcher.php',
        'oePaypal_EblLogger'                => 'oe/oepaypal/core/oeebl/oepaypal_ebllogger.php',
        'oePaypal_EblPortlet'               => 'oe/oepaypal/core/oeebl/oepaypal_eblportlet.php',
        'oePaypal_EblSoapClient'            => 'oe/oepaypal/core/oeebl/oepaypal_eblsoapclient.php',
        'oepaypalevents'                    => 'oe/oepaypal/core/oepaypalevents.php',
    ),

blocks
------

In this array are registered all module templates blocks. On module activation they are automaticly inserted into database. On activating/deactivating module, all module blocks also are activated/deactivated

.. code:: php

  'blocks' => array(
        array(
            'template' => 'widget/sidebar/partners.tpl',
            'block'=>'partner_logos',
            'file'=>'/views/blocks/oepaypalpartnerbox.tpl'
            'position' => '2'
        ),
        array(
            'template' => 'page/checkout/basket.tpl',
            'block'=>'basket_btn_next_top',
            'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'
            'position' => '1'
        ),
        array(
            'template' => 'page/checkout/basket.tpl',
            'block'=>'basket_btn_next_bottom',
            'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'
        ),
    ),
    )

Differences in block file definition per shop/metadata version.

In OXID eShop >= 4.6 with metadata version 1.0 template block ``file`` value was relative to ``out/blocks`` directory inside module root.

In OXID eShop 4.7 / 5.0 with metadata version 1.1 template block ``file`` value has to be specified directly from module root.

To maintain compatibility with older shop versions, template block files will work using both notations.

Template block ``file`` value holding path to your customized block should be defined using full path from module directory, earlier it was a sub path from modules ``out/blocks`` directory.

You can define a position of a block if a template block is extended multiple (by different modules).
So you can sort the block extensions. This is done via the optional template block ``position`` value.

.. _metadataphpversion12-settings-20190911:

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

  /* Entries in lang.php for constraints example:
  'SHOP_MODULE_sConfigTest'        => 'Field Label',
  'SHOP_MODULE_sConfigTest_0'      => '',
  'SHOP_MODULE_sConfigTest_1'      => 'Value x',
  'SHOP_MODULE_sConfigTest_2'      => 'Value y',
  'SHOP_MODULE_sConfigTest_3'      => 'Value z'
  */

Each setting belongs to a group. In this case its called ``main``. Then follows the name of the setting which is the variable name in oxconfig/oxconfigdisplay table. It is best practice to prefix it with your moduleid to avoid name collisions with other modules. Next part is the type of the parameter and last part is the default value.

Add **translations of you module's settings** into each copy of corresponding :file:`module_options.php` file
(see :ref:`File and Folder structure <modules_structure_language_files_admin>`)
using the following format for language constants:

.. code:: php

  // Entries in module_options.php for above code examples first entry:
  'SHOP_MODULE_GROUP_main'                    => 'Paypal settings',
  'SHOP_MODULE_dMaxPayPalDeliveryAmount'      => 'Maximal delivery amount',
  'HELP_SHOP_MODULE_dMaxPayPalDeliveryAmount' => 'A help text for this setting',

So the shop looks in the file for a language constant like ``SHOP_MODULE_GROUP_`` and for the single setting for a language constant like ``SHOP_MODULE_``.
In php classes you can query your module settings by using the ``function getParameter()`` of ``oxConfig`` class:

.. code:: php

  $myconfig = $this->getConfig();
  $myconfig->getConfigParam("dMaxPayPalDeliveryAmount");

or since OXID 4.7 you can also use

.. code:: php

  $myconfig = oxRegistry::get("oxConfig");
  $myconfig->getConfigParam("dMaxPayPalDeliveryAmount");

templates
---------

Module templates array. All module templates should be registered here, so on requiring template shop will search template path in this array.


  'templates' => array('order_dhl.tpl' => 'oe/efi_dhl/out/admin/tpl/order_dhl.tpl')

.. _events:

events
------

Module events were introduced in metadata version 1.1. Currently there are only 2 of them (onActivate and onDeactivate), more events will be added in future releases. Event handler class shoul'd be registered in medatata files array.

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

  $sMetadataVersion = '1.2';

Here is an example of PayPal module metadata file:

.. code:: php

  /**
   * Metadata version
   */
  $sMetadataVersion = '1.2';

  /**
   * Module information
   */
  $aModule = array(
    'id'           => 'oepaypal',
    'title'        => 'PayPal',
    'description'  => array(
        'de' => 'Modul fuer die Zahlung mit PayPal. Erfordert einen OXID eFire Account und die abgeschlossene Aktivierung des Portlets "PayPal".',
        'en' => 'Module for PayPal payment. An OXID eFire account is required as well as the finalized activation of the portlet "PayPal".',
    ),
    'thumbnail'    => 'logo.jpg',
    'version'      => '2.0.3',
    'author'       => 'OXID eSales AG',
    'url'          => 'http://www.oxid-esales.com',
    'email'        => 'info@oxid-esales.com',
    'extend'       => array(
        'order'        => 'oe/oepaypal/controllers/oepaypalorder',
        'payment'      => 'oe/oepaypal/controllers/oepaypalpayment',
        'wrapping'     => 'oe/oepaypal/controllers/oepaypalwrapping',
        'oxviewconfig' => 'oe/oepaypal/controllers/oepaypaloxviewconfig',
        'oxaddress'    => 'oe/oepaypal/models/oepaypaloxaddress',
        'oxuser'       => 'oe/oepaypal/models/oepaypaloxuser',
        'oxorder'      => 'oe/oepaypal/models/oepaypaloxorder',
        'oxbasket'     => 'oe/oepaypal/models/oepaypaloxbasket',
        'oxbasketitem' => 'oe/oepaypal/models/oepaypaloxbasketitem',
        'oxarticle'    => 'oe/oepaypal/models/oepaypaloxarticle',
        'oxcountry'    => 'oe/oepaypal/models/oepaypaloxcountry',
        'oxstate'      => 'oe/oepaypal/models/oepaypaloxstate',
    ),
    'files' => array(
        'oePayPalException'                 => 'oe/oepaypal/core/exception/oepaypalexception.php',
        'oePayPalCheckoutService'           => 'oe/oepaypal/core/oepaypalcheckoutservice.php',
        'oePayPalLogger'                    => 'oe/oepaypal/core/oepaypallogger.php',
        'oePayPalPortlet'                   => 'oe/oepaypal/core/oepaypalportlet.php',
        'oePayPalDispatcher'                => 'oe/oepaypal/controllers/oepaypaldispatcher.php',
        'oePayPalExpressCheckoutDispatcher' => 'oe/oepaypal/controllers/oepaypalexpresscheckoutdispatcher.php',
        'oePayPalStandardDispatcher'        => 'oe/oepaypal/controllers/oepaypalstandarddispatcher.php',
        'oePaypal_EblLogger'                => 'oe/oepaypal/core/oeebl/oepaypal_ebllogger.php',
        'oePaypal_EblPortlet'               => 'oe/oepaypal/core/oeebl/oepaypal_eblportlet.php',
        'oePaypal_EblSoapClient'            => 'oe/oepaypal/core/oeebl/oepaypal_eblsoapclient.php',
        'oepaypalevents'                    => 'oe/oepaypal/core/oepaypalevents.php',
    ),
    'events'       => array(
        'onActivate'   => 'oepaypalevents::onActivate',
        'onDeactivate' => 'oepaypalevents::onDeactivate'
    ),
    'blocks' => array(
        array('template' => 'widget/sidebar/partners.tpl', 'block'=>'partner_logos',                     'file'=>'/views/blocks/oepaypalpartnerbox.tpl'),
        array('template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_top',               'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        array('template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_bottom',            'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        array('template' => 'page/checkout/payment.tpl',   'block'=>'select_payment',                    'file'=>'/views/blocks/oepaypalpaymentselector.tpl'),
    ),
   'settings' => array(
        array('group' => 'main', 'name' => 'dMaxPayPalDeliveryAmount', 'type' => 'str',  'value' => '30'),
        array('group' => 'main', 'name' => 'blPayPalLoggerEnabled',    'type' => 'bool', 'value' => 'false'),
    )
  );

.. _multilanguage_fields-20170315:

Multilanguage fields
--------------------

.. note::
    This section is about multilanguage fields of strings introduced in the metadata.php file itself. If you want
    to use translations in your module for frontend or backend, you should place them in your module according
    the :ref:`module structure conventions <modules_structure_language_files_20170316>`

Extension description is a multilanguage field. This should be an array with a defined key as language abbervation and the value of it's translation.

.. code:: php

  'description'  => array(
    'de'=>'Intelligente Produktsuche und Navigation.',
    'en'=>'Intelligent product search and navigation.',
  )


The field value also can be a simple string. If this field value is not an array but simple text, this text string will be displayed in all languages.

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

In case of using a vendor directory you still need to describe file paths relatively to the modules directory:

.. code:: php

  'extend' => array(
        'some_class' => 'oxid/module1/my_class'
  ),
  'templates' => array(
        'my_template.tpl' => 'oxid/module1/my_template.tpl'
  )
