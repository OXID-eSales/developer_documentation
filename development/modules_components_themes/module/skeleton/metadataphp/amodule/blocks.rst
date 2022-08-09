blocks
======

.. note::

    **Extending Twig blocks**

    The `blocks` section in `metadata.php` is used for :emphasis:`Smarty` templates only.

    To find out how to extend :emphasis:`Twig` blocks, see :doc:`Twig template documentation for modules </development/modules_components_themes/module/using_twig_in_module_templates>`.


Description:
    In this array, all module templates blocks are registered.
    |br|
    On module activation, they are automatically inserted into the
    database.
    |br|
    On activating/deactivating the module, all module blocks also are activated/deactivated.

Type:
    array of arrays. Sub keys can be ``template``, ``block``, ``file`` and ``position``.

Mandatory:
    no

Example
-------

    .. code:: php

        'blocks' => [
            [
                'template' => 'widget/sidebar/partners.tpl',
                'block'=>'partner_logos',
                'file'=>'/views/blocks/oepaypalpartnerbox.tpl',
                'position' => '2'
            ],
            [
                'template' => 'page/checkout/basket.tpl',
                'block'=>'basket_btn_next_top',
                'file'=>'/views/blocks/oepaypalexpresscheckout.tpl',
                'position' => '1'
            ],
            [
                'template' => 'page/checkout/basket.tpl',
                'block'=>'basket_btn_next_bottom',
                'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'
            ],
        ],



Differences in block file definition per shop/metadata version
--------------------------------------------------------------

In OXID eShop >= 4.6 with metadata version 1.0, the template block ``file`` value was relative to ``out/blocks`` directory inside module root.

In OXID eShop 4.7 / 5.0 with metadata version 1.1, the template block ``file`` value has to be specified directly from module root.

To maintain compatibility with older shop versions, template block files will work using both notations.

.. todo: #Vasyl: Does the following belong to "Differences in block file definition per shop/metadata version*" ?

Template block ``file`` value holding the path to your customized block should be defined using full path from module directory, earlier it was a sub path of the modules ``out/blocks`` directory.

.. todo: #Vasyl: Does the following belong to "Differences in block file definition per shop/metadata version" ?

You can define a position of a block if a template block is extended several times (by different modules).
In this way, you can sort the block extensions.

To do this, use the optional template block ``position`` value.

Theme-specific blocks
---------------------
To register or extend theme-specific block template, add a `'theme'` key to the block's definition:

.. code:: php

    'blocks' => [
        [
            'theme' => 'shop_theme_id'
            'template' => 'name_off_shop_template_which_contains_block',
            'block' => 'name_off_shop_block',
            'file' => 'path_to_module_block_file',
        ]
    ]
