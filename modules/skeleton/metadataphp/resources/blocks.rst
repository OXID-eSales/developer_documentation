blocks
""""""

Description:
    In this array are registered all module templates blocks. On module activation they are automaticly inserted into
    database. On activating/deactivating module, all module blocks also are activated/deactivated.

Type:
    array of arrays. Sub keys can be ``template``, ``block``, ``file`` and ``position``.

Mandatory:
    no

Example
    .. code:: php

        'blocks' => [
            [
                'template' => 'widget/sidebar/partners.tpl',
                'block'=>'partner_logos',
                'file'=>'/views/blocks/oepaypalpartnerbox.tpl'
                'position' => '2'
            ],
            [
                'template' => 'page/checkout/basket.tpl',
                'block'=>'basket_btn_next_top',
                'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'
                'position' => '1'
            ],
            [
                'template' => 'page/checkout/basket.tpl',
                'block'=>'basket_btn_next_bottom',
                'file'=>'/views/blocks/oepaypalexpresscheckout.tpl'
            ],
        ),

Differences in block file definition per shop/metadata version.

In OXID eShop >= 4.6 with metadata version 1.0 template block ``file`` value was relative to ``out/blocks`` directory inside module root.

In OXID eShop 4.7 / 5.0 with metadata version 1.1 template block ``file`` value has to be specified directly from module root.

To maintain compatibility with older shop versions, template block files will work using both notations.

Template block ``file`` value holding path to your customized block should be defined using full path from module directory, earlier it was a sub path from modules ``out/blocks`` directory.

You can define a position of a block if a template block is extended multiple (by different modules).
So you can sort the block extensions. This is done via the optional template block ``position`` value.