files
"""""

Description:
    All module php files that do not extend any shop class. On request shop autoloader checks this array and if class
    name is registered in this array, loads class. So now no need to copy module classes to shop ``core`` or ``view``
    folder and all module files can be in module folder.

Type:
    array of strings

Mandatory:
    no

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