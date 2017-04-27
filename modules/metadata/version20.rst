.. _metadata_version2-20170427:

Version 2.0
===========

Changes compared to version 1.1
-------------------------------

* New Section Controllers: To be able to use namespaces for module controllers, we introduce
  module's metadata.php version 2.0 with a new section ``controllers``.
  The support for ``files`` was dropped in Module's metadata version 2.0. Classes in a namespace will be found by the autoloader.
  If you use your own namespace, :doc:`register it in the module's composer.json file </modules/module_via_composer>`.

.. important::

  You can use metadata version 2.0 with controllers only for modules using namespaces. When using modules
  without a namespace you will have to use metadata version 1.0 with the 'files' section to register your module controllers.

* Templates and blocks for different Shop themes.
  It also allows to define templates and blocks for all themes (define in the same way as in old metadata).



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

Used to display extension description in the extension detail information page. This field is :ref:`multilang capable<multilanguage_fields-20170316>`

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

You should extend only OXID eShop classes within the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` (``\OxidEsales\Eshop``). If you try to extend
e.g a class of the namespace ``\OxidEsales\EshopCommunity``, you are not able to activate the module and get a warning
message in the OXID eShop admin.

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

In this array are registered all module templates blocks. On module activation they are automaticly inserted into database.
On activating/deactivating module, all module blocks also are activated/deactivated.

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

The template block ``file`` value has to be specified directly from module root.
You can define a position of a block if a template block is extended multiple (by different modules).
So you can sort the block extensions. This is done via the optional template block ``position`` value.

To describe block or overwrite default block template for specific theme, use theme attribute in block description.

.. code::

    'blocks' => array(
        array(
            'theme' => 'shop_theme_id'
            'template' => 'name_off_shop_template_which_contains_block',
            'block'=>'name_off_shop_block',
            'file'=>'path_to_module_block_file'
        ),

.. note::
    - To override default block use same template and block values.
    - Specific block will override all files for specific block.
    - It is not allowed to use `admin` as a theme id.

**Example**

.. code::

    'blocks' => array(
        array(
            'template' => 'deliveryset_main.tpl',
            'block'=>'admin_deliveryset_main_form',
            'file'=>'/views/blocks/deliveryset_main.tpl',
        ),
        array(
            'template' => 'widget/sidebar/partners.tpl',
            'block'=>'partner_logos',
            'file'=>'/views/blocks/widget/sidebar/oepaypalpartnerbox1.tpl',
        ),
        array(
            'template' => 'widget/sidebar/partners.tpl',
            'block'=>'partner_logos',
            'file'=>'/views/blocks/widget/sidebar/oepaypalpartnerbox2.tpl',
        ),
        array(
            'theme' => 'flow_theme',
            'template' => 'widget/sidebar/partners.tpl',
            'block'=>'partner_logos',
            'file'=>'/views/blocks/widget/sidebar/oepaypalpartnerboxForFlow.tpl',
        ),
    )

In this particular example:

    * If `flow_theme` theme is active, the contents of `oepaypalpartnerboxForFlow.tpl` file would be loaded in `partners.tpl` partner_logos block.
    * For other then `flow_theme` theme, the `oepaypalpartnerbox1.tpl` and `oepaypalpartnerbox2.tpl` files contents
      would be shown in `partners.tpl partner_logos block`.

Custom blocks
^^^^^^^^^^^^^

It is possible to reuse template blocks for parent theme when child theme extends parent theme.

.. code::

    'blocks' => array(
        array(
            'template' => 'widget/minibasket/minibasket.tpl',
            'block'=>'widget_minibasket_total',
            'file'=> '/views/blocks/widget/minibasket/oepaypalexpresscheckoutminibasket.tpl',
        ),
        array(
            'template' => 'widget/sidebar/partners.tpl',
            'block'=> 'partner_logos',
            'file'=>'/views/blocks/widget/sidebar/oepaypalpartnerbox.tpl',
        ),
        array(
            'theme' => 'flow_theme',
            'template' => 'widget/minibasket/minibasket.tpl',
            'block'=> 'widget_minibasket_total',
            'file'=> '/views/blocks/widget/minibasket/oepaypalexpresscheckoutminibasketFlow.tpl',
        ),
        array(
            'theme' => 'flow_theme',
            'template' => 'widget/sidebar/partners.tpl',
            'block'=> 'partner_logos',
            'file'=> '/views/blocks/widget/sidebar/oepaypalpartnerboxForFlow.tpl',
        ),
        array(
            'theme' => 'flow_theme_child',
            'template' => 'widget/sidebar/partners.tpl',
            'block'=> 'partner_logos',
            'file'=> '/views/blocks/widget/sidebar/oepaypalpartnerboxForMyCustomFlow.tpl',
        ),
    )

In this particular example `flow_theme_child` extends `flow_theme`. If `flow_theme_child` theme would be active:

    * `oepaypalpartnerboxForMyCustomFlow.tpl` template block would be used instead of `partner_logos`.
    * `oepaypalexpresscheckoutminibasketFlow.tpl` template would be used instead of `widget_minibasket_total`.





.. _settings-20170316:

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

In order to get correct translations of your settings names in admin one should create ``views/admin/module_options.php`` where is the language with 2 letters for example ``en`` for english. There should be placed the language constants according to the following scheme:

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

All module templates should be registered here, so on requiring template shop will search template path in this array.
Default template (for all themes) are described in same way as in metadata v1.*

.. code::

    'templates' => array(
        'module_template_name'   => 'path_to_module_template',
    )

To have template for specific theme, define it in an array with the key equal to theme id.

.. code::

    'templates' => array(
        'theme_id' => array(
            'module_template_name'   => 'path_to_module_template',
        )
    )

.. note::

    - Its possible to use any theme id, even default one, if you want to specify some template for the theme.
    - It is not allowed to use `admin` as a theme id.

**Example**

.. code::

    'templates' => array(
        'order_paypal.tpl' => 'oe/oepaypal/views/admin/tpl/order_paypal.tpl',
        'ipnhandler.tpl'   => 'oe/oepaypal/views/tpl/ipnhandler.tpl',
        'more.tpl'         => 'oe/oepaypal/views/tpl/moreDefault.tpl',

        'flow_theme' => array(
            'more.tpl' => 'oe/oepaypal/views/tpl/moreFlow.tpl',
        )
    )

Templates for child theme
^^^^^^^^^^^^^^^^^^^^^^^^^

It is possible to reuse templates for parent theme when child theme extends parent theme.
This mechanism is especially useful in project scope when needs to customize an already existing theme.

.. code::

    'templates' => array(
        'order_paypal.tpl' => 'oe/oepaypal/views/admin/tpl/order_paypal.tpl',
        'ipnhandler.tpl'   => 'oe/oepaypal/views/tpl/ipnhandler.tpl',
        'more.tpl'         => 'oe/oepaypal/views/tpl/moreDefault.tpl',

        'flow_theme' => array(
            'ipnhandler.tpl' => 'oe/oepaypal/views/tpl/ipnhandlerFlow.tpl',
            'more.tpl'       => 'oe/oepaypal/views/tpl/moreFlow.tpl',
        ),

        'flow_theme_child' => array(
            'more.tpl'   => 'oe/oepaypal/views/tpl/moreMyCustomFlow.tpl',
        )
    )


In this particular example `flow_theme_child` extends `flow_theme`.
If `flow_theme_child` theme would be active:

    * `moreMyCustomFlow.tpl` template would be used instead of `more.tpl`.
    * `ipnhandlerFlow.tpl` template would be used instead of `ipnhandler.tpl`.




.. _events-20170307:

events
------

Module events were introduced in metadata version 1.1. There are 2 events: onActivate and onDeactivate.

.. code:: php

  'events'       => array(
        'onActivate'   => '\OxidEsales\PayPalModule\Core\Events::onActivate',
        'onDeactivate' => '\OxidEsales\PayPalModule\Core\Events::onDeactivate'
    ),

Metadata file version
---------------------

.. code:: php

  $sMetadataVersion = '2.0';


.. _multilanguage_fields-20170316:

Multilanguage fields
--------------------

.. note::
    This section is about multilanguage fields of strings introduced in the metadata.php file itself. If you want
    to use translations in your module for frontend or backend, you should place them in your module according
    the :ref:`module structure conventions <modules_structure_language_files_20170316>`.

Extension description is a multilanguage field. This should be an array with a defined key as language abbervation and the value of it's translation.

.. code:: php

  'description'  => array(
    'de'=>'Intelligente Produktsuche und Navigation.',
    'en'=>'Intelligent product search and navigation.',
  )


The field value also can be a simple string. If this field value is not an array but simple text, this text string will be displayed in all languages.


Vendor directory support
------------------------

All modules can be placed not directly in shop modules directory, but also in vendor directory.
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
