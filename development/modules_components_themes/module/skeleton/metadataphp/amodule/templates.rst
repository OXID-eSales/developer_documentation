.. _module-templates-20170427:

templates
=========

Description
    Module templates array. All module templates should be registered here, so on requiring template shop will
    search template path in this array.

.. note::

    Module templates path are relative to module path in vendor directory.

Type
    - array of strings
    - two-dimensional array of strings (in case of theme-specific templates)

Mandatory
    no

Example
    .. code:: php

        'templates' => [
            'order_dhl.tpl' => 'out/admin/tpl/order_dhl.tpl'
        ],

.. code::

  .
  └── <vendor>
      └── <module_id>
          └── views
              └── out
                  └── admin
                      └── order_dhl.tpl


Theme-specific templates
------------------------
To extend templates for a specific theme, insert them wrapped with additional array into `'templates'`,
use the theme ID as a key:

    .. code-block:: php

        'templates' => [

            //Module extends template:
            'Template name' => 'Path to module template',

            //Module extends Theme-specific template:
            'Theme ID' => [
                'Template name' => 'Path to module template',
            ]
        ]

    .. warning::

        You can not use `admin` as a `'Theme ID'` here.

    **Example:**

    .. code-block:: php

        'templates' => [

            //Module extends template:
            'order_paypal.tpl' => 'path/to/admin/module/template/order_paypal.tpl',
            'ipnhandler.tpl'   => 'path/to/module/template/ipnhandler.tpl',
            'more.tpl'         => 'path/to/module/template/moreDefault.tpl',

            //Module extends Theme-specific template:
            'flow_theme' => [
                'more.tpl' => 'path/to/module/template/moreFlow.tpl',
            ]
        ]

Customizing theme-specific templates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Theme-specific templates can be customized by extending the theme they were created for:

    .. code-block:: php

        'templates' => [
            'order_paypal.tpl' => 'path/to/admin/module/template/order_paypal.tpl',
            'ipnhandler.tpl'   => 'path/to/module/template/ipnhandler.tpl',
            'more.tpl'         => 'path/to/module/template/moreDefault.tpl',

            'flow_theme' => [
                'ipnhandler.tpl' => 'path/to/module/template/ipnhandlerFlow.tpl',
                'more.tpl'       => 'path/to/module/template/moreFlow.tpl',
            ],

            'flow_theme_child' => [
                'more.tpl'   => 'path/to/module/template/moreMyCustomFlow.tpl',
            ]
        ]

In this particular example  a child theme: `flow_theme_child` extends a parent theme: `flow_theme`.
After activating `flow_theme_child`:

    * `moreMyCustomFlow.tpl` template would be used instead of `more.tpl`.
    * `ipnhandlerFlow.tpl` template would be used instead of `ipnhandler.tpl`.
