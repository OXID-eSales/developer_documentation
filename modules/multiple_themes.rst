Multiple themes
===============

Short description
-----------------

Metadata v2.0 introduces possibility for a module to define templates for different Shop themes.
It also allows to define templates for all themes (define in a same way as in old metadata).

- Specific templates will be used if defined theme is the active one in Shop.
- Default templates will be used if there are no templates defined for the active Shop theme.

.. note:: Same applies for template blocks.

Templates
---------

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

In this particular example `flow_theme_child` extends `flow_theme`. If `flow_theme_child` theme would be active:
    - `moreMyCustomFlow.tpl` template would be used instead of `more.tpl`.
    - `ipnhandlerFlow.tpl` template would be used instead of `ipnhandler.tpl`.


Blocks
------

To have default block (for all themes) define it in same way as in metadata v1.*

.. code::

    'blocks' => array(
        array(
            'template' => 'name_off_shop_template_which_contains_block',
            'block'=>'name_off_shop_block',
            'file'=>'path_to_module_block_file'
        ),

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
    - If `flow_theme` theme is active, the contents of `oepaypalpartnerboxForFlow.tpl` file would be loaded in `partners.tpl` partner_logos block.
    - For other then `flow_theme` theme, the `oepaypalpartnerbox1.tpl` and `oepaypalpartnerbox2.tpl` files contents
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
    - `oepaypalpartnerboxForMyCustomFlow.tpl` template block would be used instead of `partner_logos`.
    - `oepaypalexpresscheckoutminibasketFlow.tpl` template would be used instead of `widget_minibasket_total`.
