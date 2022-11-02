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