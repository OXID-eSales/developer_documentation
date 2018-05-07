Configuration file config.inc.php
=================================

.. _configincphp_sloglevel:

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
