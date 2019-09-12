Version 1.2
===========

Changes compared to version 1.1
-------------------------------

* Added new :ref:`setting type <metadataphpversion-settings-20190911>`- ``password``

Structure
---------

On the top level of the PHP file metadata.php, there have to be exactly 2 variables:
``$sMetadataVersion (String)`` and ``$aModule (Array)``. No other variables or code are allowed.

.. code:: php

    <?php

    $sMetadataVersion = '1.2';
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

       amodule/files

       amodule/blocks

       amodule/settings

       amodule/templates

       amodule/events

Example
-------

.. code:: php

  /**
   * Metadata version
   */
  $sMetadataVersion = '1.2';

  /**
   * Module information
   */
  $aModule = [
    'id'           => 'oepaypal',
    'title'        => 'PayPal',
    'description'  => [
        'de' => 'Modul fuer die Zahlung mit PayPal. Erfordert einen OXID eFire Account und die abgeschlossene Aktivierung des Portlets "PayPal".',
        'en' => 'Module for PayPal payment. An OXID eFire account is required as well as the finalized activation of the portlet "PayPal".',
    ],
    'thumbnail'    => 'logo.jpg',
    'version'      => '2.0.3',
    'author'       => 'OXID eSales AG',
    'url'          => 'http://www.oxid-esales.com',
    'email'        => 'info@oxid-esales.com',
    'extend'       => [
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
    ],
    'files' => [
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
    ],
    'events'       => [
        'onActivate'   => 'oepaypalevents::onActivate',
        'onDeactivate' => 'oepaypalevents::onDeactivate'
    ],
    'blocks' => [
        ['template' => 'widget/sidebar/partners.tpl', 'block'=>'partner_logos',                     'file'=>'/views/blocks/oepaypalpartnerbox.tpl'),
        ['template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_top',               'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        ['template' => 'page/checkout/basket.tpl',    'block'=>'basket_btn_next_bottom',            'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'),
        ['template' => 'page/checkout/payment.tpl',   'block'=>'select_payment',                    'file'=>'/views/blocks/oepaypalpaymentselector.tpl'),
    ],
   'settings' => [
        ['group' => 'main', 'name' => 'dMaxPayPalDeliveryAmount', 'type' => 'str',  'value' => '30'),
        ['group' => 'main', 'name' => 'blPayPalLoggerEnabled',    'type' => 'bool', 'value' => 'false'),
    ]
  ];
