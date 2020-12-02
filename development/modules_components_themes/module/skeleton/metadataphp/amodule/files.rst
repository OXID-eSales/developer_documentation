files
=====

Description
    All module php files that do not extend any shop class. On request shop autoloader checks this array and if class
    name is registered in this array, loads class. If you use namespaced classes, autoloading is done via composer.

Type
    Associative array

Mandatory
    no

.. note::

    We deprecated supporting metadata version 1, 1.1 and 1.2.
    Therefore, it is recommended to use version 2 or later, in which the `files` option is no longer supported.

Example
    .. code:: php

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