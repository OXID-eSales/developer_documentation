Configuration file config.inc.php
=================================

.. _configincphp_sloglevel:

Database connection
-------------------

dbType
^^^^^^

The built-in Doctrine DBAL driver implementation to use. Default is "pdo_mysql": A MySQL driver that uses the pdo_mysql PDO extension.

.. code:: php

    $this->dbType = 'pdo_mysql';

.. warning::

    We cannot guarantee all shop functionality will work if this value is changed.

dbCharset
^^^^^^^^^

The charset used when connecting to the database. It is highly related with dbType used.

.. code:: php

    $this->dbCharset = 'utf8';

.. warning::

    We cannot guarantee all shop functionality will work if this value is changed.

Other database connection variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: php

    $this->dbHost = 'localhost'; // database host name
    $this->dbPort  = 3306; // tcp port to which the database is bound
    $this->dbName = 'oxid'; // database name
    $this->dbUser = 'oxid'; // database user name
    $this->dbPwd  = 'oxid'; // database user password

sLogLevel
---------

.. code:: php

    $this->sLogLevel = 'warning'; // default setting 'warning'

You can set the log level to one of the levels defined by `\Psr\Log\LogLevel <https://github.com/php-fig/log/blob/master/Psr/Log/LogLevel.php>`__.
This level will be used by the default PSR-3 logging implementation of OXID eShop.

.. note::

    Keep in mind that this is the minimum level to be logged and lower levels would not be logged, even if those log levels are used in the code.

    The message in the following code example will not be logged to any logging channel, if sLogLevel is set to ``warning``.
    You would have to set sLogLevel to ``debug`` to see something in the error log file.

    .. code:: php

        $logger->debug('Some debug message', [__CLASS__, __FUNCTION__]);

    Like this you are able to change the log level temporarily even in productive environments to see more information in
    your log file.

.. _configincphp_iDebug:

iDebug
------

.. code:: php

    /**
     * Enable debug mode for template development or bug fixing
     * -1 = Log more messages and throw exceptions on errors (not recommended for production)
     * 0 = off
     * 1 = smarty
     * 3 = smarty
     * 4 = smarty + shoptemplate data
     * 5 = Delivery Cost calculation info
     * 6 = SMTP Debug Messages
     * 8 = display smarty template names (requires /tmp cleanup)
     */
    $this->iDebug = 0; // default setting 0

The different values do not reflect log levels but rather, which part of the OXID eShop functionality should logged.

.. note::

    This setting is for debugging purposes during development ONLY. It prints out a lot of information directly to the
    front page and is not suitable for a productive environment.

sCSVSign
--------

Separator for Im/Export in Enterprise Edition

sGiCsvFieldEncloser
-------------------

Encloser for Im/Export

blCheckForUpdates
-----------------

Shop will be checked for version in admin home page only if this option is checked


sAltImageDir / sSSLAltImageUrl
------------------------------

In case if pictures for articles should be loaded from separate server and are available only through http - it's enough to include sAltImageDir option in config.inc.php. Then to load picture for article only define the rest http path to the image file. Attention: If this option is set in the configuration file config.inc.php, uploading of product pictures in admin area is not possible!
If you are using https, you also have to set the sSSLAltImageUrl option.

.. code:: php

    $this->sAltImageDir = "[http://[path_to_images_dir_on_server]/";
    $this->sSSLAltImageUrl = "[https://[path_to_images_dir_on_server]/";


sCookieDomain
-------------

In case you setup different subdomain for SSL/non-SSL pages cookies may not be shared between them. Defines the domain that the cookie is available.

sAuthOpenIdRandSource
---------------------

define 'Auth_OpenID_RAND_SOURCE' (filename for a source of   random bytes)
<pre>$this->sAuthOpenIdRandSource  = '/dev/urandom';</pre>

sCookiePath
-----------

possibility to define path on the server in which the cookie will be available on.

.. code:: php

    $this->sCookiePath = '/dev/urandom';

blForceSessionStart
-------------------

Force session start on first page view and for users whose browsers do not accept cookies, append sid parameter to URLs.

.. code:: php

    $this->blForceSessionStart = "1";

aTrustedIPs
-----------

Defines IP addresses, for which session + cookie id match and user agent change checks are off.

blUseTimeCheck
--------------

Additionally checks if "oxactivefrom > current date < oxactiveto"

blUseStock
----------

If value is TRUE checks stock state "( oxstock > 0 or ( oxstock <= 0 and ( oxstockflag = 1 or oxstockflag = 4 ) )"

sCustomTheme
------------

Is a global config parameter which activates a template override system for an easier design customization and defines
custom theme directory name in ‘views’ folder. The structure of this custom theme has to be the same as main theme. The
shop will look up if there is an adapted file in your custom folder; if not it will return to the main folder.

blLogChangesInAdmin
-------------------

Log all modifications performed in Admin (in oxadminlog table)

.. code:: php

    $this->blLogChangesInAdmin = 0;


blMallSharedBasket
------------------

Common cart for subshops use together with option in main shop configurations (Mall tab): "Allow users from other shops"

blSeoMode
---------

Switch off SEO URLs

.. code:: php

    $this->blSeoMode = false;

iPicCount
---------

Change number of item pictures

.. code:: php

    $this->iPicCount = 12;

aModules
--------

Some classes can be overloaded, but only by setting up this information in config.inc.php directly

.. code:: php

    $this->aModules = array(
        'oxutilsobject' => 'my_oxutilsobject'
    );

aRequireSessionWithParams
-------------------------

This configuration array specifies additional request parameters, which, if received, forces a new session being started.

This is the default array with the request parameters and their values, which forces a new session:

.. code:: php

    array(
        'cl' => array(
            'register' => true,
            'account'  => true,
        ),
        'fnc' => array(
            'tobasket' => true,
            'login_noredirect' => true,
            'tocomparelist'    => true,
        ),
        '_artperpage' => true,
        'ldtype'      => true,
        'listorderby' => true,
    );

If you want to extend this array include in config.inc.php file this option:

.. code:: php

    $this->aRequireSessionWithParams = array(
        'parameter_name' => array(
            'parameter_value' => true,
        )
    );

The keys of the array are the names of parameters and the values of the arrays are the parameter values that lead to the
session being started, e.g:

.. code:: php

    $this->aRequireSessionWithParams = array(
        'fnc' => array(
            'login_noredirect' => true,
        ),
        'new_sid' => true
    );

blUseCron
---------

Enables or disables the use of cron jobs in config.inc.php

Implemented with OXID eShop version 4.6.0

.. code:: php

    $this->blUseCron = true;

iCreditRating
-------------

Sets the default value of credit rating

Implemented with OXID eShop version 4.7.3

.. code:: php

    $this->iCreditRating = 1000;

blEnterNetPrice
---------------

Prices will be entered without tax

blSkipViewUsage
---------------

If you can't log in to the admin panel, try setting the parameter blSkipViewUsage temproarily to "true".

Implemented with OXID eShop version 4.7

.. code:: php

    $this->blSkipViewUsage = true;

sShopLogo
---------

Add your own logo image file, upload it to /out/az ure/img/.

Implemented with OXID eShop version 4.8

.. code:: php

    $this->sShopLogo = 'your_own_image.jpg'

blDemoShop
----------

Enables shop demo mode

.. code:: php

    $this->blDemoShop= true;

blDoNotDisableModuleOnError
---------------------------

Disable module auto deactivation

Implemented with OXID eShop versions 5.1.2/4.8.2 and 5.0.11/4.7.11

.. code:: php

    $this->blDoNotDisableModuleOnError = false;
