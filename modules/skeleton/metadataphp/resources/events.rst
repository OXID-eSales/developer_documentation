events
""""""

Description:
    The specified event handler class should be registered in medatata files array.

Type:
    array of strings. Possible sub keys can  be ``onActivate`` and ``onDeactivate``

Mandatory:
    no

Example
    .. code:: php

        'events'       => [
            'onActivate'   => 'oepaypalevents::onActivate',
            'onDeactivate' => 'oepaypalevents::onDeactivate'
        ],
