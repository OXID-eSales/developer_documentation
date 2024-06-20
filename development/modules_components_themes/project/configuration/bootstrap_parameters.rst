Bootstrap parameters
====================

In OXID Shop application, parameters can be defined in environment file and are typically used to store configuration values that may vary between environments.
You can find and customize parameters inside ``.env`` .

OXID_DB_URL
^^^^^^^^^^^

The database connection information is stored as an environment variable called ``OXID_DB_URL`` .

.. code:: php

    ``OXID_DB_URL=mysql://root:root@mysql:3306/example?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=''"``

OXID_BUILD_DIRECTORY
^^^^^^^^^^^^^^^^^^^^

Directory will be used to compile shop files.

.. code:: php

    ``OXID_BUILD_DIRECTORY=/var/www/source/tmp/``

OXID_LOG_LEVEL
^^^^^^^^^^^^^^

You can set the log level to one of the levels defined by `PsrLogLevel <https://www.php-fig.org/psr/psr-3>`__.
This level will be used by the default PSR-3 logging implementation of OXID eShop.

.. code:: php

    ``OXID_LOG_LEVEL=error``

.. note::

    Keep in mind that this is the minimum level to be logged and lower levels would not be logged, even if those log levels are used in the code.

    The message in the following code example will not be logged to any logging channel, if sLogLevel is set to ``warning``.
    You would have to set sLogLevel to ``debug`` to see something in the error log file.

    .. code:: php

        $logger->debug('Some debug message', [__CLASS__, __FUNCTION__]);

    Like this you are able to change the log level temporarily even in productive environments to see more information in
    your log file.

OXID_DEBUG_MODE
^^^^^^^^^^^^^^^

This parameter allows you to enable or disable debugging using `true` and `false` values. Please set this parameter to false in production mode.