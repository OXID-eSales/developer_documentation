extend
""""""

Description:
    On this place shall be defined which shop classes are extended by this module. Take care you declare the keys
    (e.g. oxorder) always in lower case! Take care you declare the file names case sensitive!
    It is suggested to use lower case for file names, to avoid difficulties.

Type:
    array of strings

Mandatory:
    no

Example
    .. code:: php

        'extend'       => [
            'order'        => 'oe/oepaypal/controllers/oepaypalorder',
            'payment'      => 'oe/oepaypal/controllers/oepaypalpayment',
            'wrapping'     => 'oe/oepaypal/controllers/oepaypalwrapping',
            'oxviewconfig' => 'oe/oepaypal/controllers/oepaypaloxviewconfig',
            'oxaddress'    => 'oe/oepaypal/models/oepaypaloxaddress',
            'oxuser'       => 'oe/oepaypal/models/oepaypaloxuser',
            'oxorder'      => 'oe/oepaypal/models/oepaypaloxorder',
            'oxbasket'     => 'oe/oepaypal/models/oepaypaloxbasket',
            'oxbasketitem' => 'oe/oepaypal/models/oepaypaloxbasketitem',
            'oxarticle'    => 'oe/oepaypal/models/oepaypaloxarticle',
            'oxcountry'    => 'oe/oepaypal/models/oepaypaloxcountry',
            'oxstate'      => 'oe/oepaypal/models/oepaypaloxstate',
        ],