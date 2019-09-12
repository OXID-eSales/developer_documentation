.. _metadataphpversion-settings-20190911:

settings
========

Description
    In this section all module configuration options are registered. In the eShop admin, users can configure
    modules according these settings.
    The settings can be translated and you can access the values in your php code.

Type
    Array of associative arrays. Array keys:

    * Each module setting belongs to a group (mandatory key ``group``).
    * The mandatory key ``name`` is used for getting and storing the setting.
      It is best practice to prefix it with your :doc:`module id <id>` to avoid name
      collisions with other modules.
    * The key ``type`` is mandatory. Possible values are ``str``, ``bool``, ``arr`` (array),
      ``aarr`` (associative array), ``select`` (multiple options, translation possible), ``password``.
      If type is ``select``, you have to define the possible values by another key ``constraints``.
    * The key the ``value`` sets a default value and is also mandatory. The keys ``type`` and ``value`` have to fit, see
      example below.
    * The optional parameter ``position`` sets the order of module settings shown in the eShop admin.

Mandatory
    No

Usage
    In php classes you can query your module settings by:

    .. code:: php

        $myconfig = \OxidEsales\Eshop\Core\Registry::getConfig();
        $myconfig->getConfigParam("sOEPayPalBrandName");

    In order to get correct translations of your settings names you have to create the file :file:`module_options.php`
    like described in the :ref:`section translations <modules_structure_language_files_20170316>`
    The shop looks inside this file for language constants according the scheme ``SHOP_MODULE_GROUP_``,
    ``SHOP_MODULE_`` and ``HELP_MODULE``.

    .. code:: php

        // name of the group
        'SHOP_MODULE_GROUP_main'                          => 'Paypal settings',

        // sOEPayPalBrandName
        'SHOP_MODULE_sOEPayPalBrandName'                  => 'Name of the shop',
        'HELP_SHOP_MODULE_sOEPayPalBrandName'             => 'Please enter the name of your shop ....',


        // blOEPayPalLoggerEnabled
        'SHOP_MODULE_blOEPayPalLoggerEnabled'             => 'Activate PayPal logging',

        // aOEPayPalAlwaysOpenCats
        'SHOP_MODULE_aOEPayPalAlwaysOpenCats'             => 'Categories available',

        // aOEPayPalChannels
        'SHOP_MODULE_aOEPayPalChannels'                   => 'Channels available',

        // sOEPayPalLogoImageOption
        'SHOP_MODULE_sOEPayPalCustomShopLogoImage'        => 'Custom shop logo for the PayPal payment page',
        'HELP_SHOP_MODULE_sOEPayPalCustomShopLogoImage'   => 'Help text for ... ',
        'SHOP_MODULE_sOEPayPalLogoImageOption_noLogo'     => 'Don\'t send any shop logo',
        'SHOP_MODULE_sOEPayPalLogoImageOption_shopLogo'   => 'Send default shop logo ',
        'SHOP_MODULE_sOEPayPalLogoImageOption_customLogo' => 'Send custom shop logo',

        // sOEPayPalPassword
        'SHOP_MODULE_sOEPayPalPassword'                   => 'Password',

Example

    .. code:: php

        'settings' => [
            [
                'group' => 'main',
                'name' => 'sOEPayPalBrandName',
                'type' => 'str',
                'value' => 'PayPal Testshop'
            ],
            [
                'group' => 'main',
                'name' => 'blOEPayPalLoggerEnabled',
                'type' => 'bool',
                'value' => false
            ],
            [
                'group' => 'main',
                'name' => 'aOEPayPalAlwaysOpenCats',
                'type' => 'arr',
                'value' => ['Price','Manufacturer']
            ],
            [
                'group' => 'main',
                'name' => 'aOEPayPalChannels',
                'type' => 'aarr',
                'value' => ['1' => 'de', '2' => 'en']
            ],

            // If type equals select, the key constraints has to specify possible values.
            [
                'group' => 'main',
                'name' => 'sOEPayPalLogoImageOption',
                'type' => 'select',
                'value' => 'noLogo',
                'constraints' => 'noLogo|shopLogo|customLogo',
            ],
            [
                'group' => 'main',
                'name' => 'sOEPayPalPassword',
                'type' => 'password',
                'value' => 'changeMe',
                'position' => 3
            ]
        ]
