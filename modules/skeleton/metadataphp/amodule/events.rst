.. _metadataphpversion-events-20190911:

events
======

Description
    The specified event handler class should be registered in medatata files array.
Type
    associative array. Keys can be ``onActivate`` and ``onDeactivate``
Mandatory
    No
Example
     .. code:: php

         'events'       => [
            'onActivate'   => '\OxidEsales\PayPalModule\Core\Events::onActivate',
            'onDeactivate' => '\OxidEsales\PayPalModule\Core\Events::onDeactivate'
          ],


