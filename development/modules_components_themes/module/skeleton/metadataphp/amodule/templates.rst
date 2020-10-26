templates
=========

Description
    Module templates array. All module templates should be registered here, so on requiring template shop will
    search template path in this array.

Type
    array of strings

Mandatory
    no

Example
    .. code:: php

        'templates' => [
            'order_dhl.tpl' => 'out/admin/tpl/order_dhl.tpl'
        ],