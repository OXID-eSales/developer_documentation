Logger Usage
============

OXID eShop provides a `PSR-3 <https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md>`__
compatible logging mechanism.

Usage
-----

In a nutshell, you would log something in your code like this:

.. code:: php

        $logger = Registry::getLogger();
        $logger->warning('Some message ...', [__CLASS__, __FUNCTION__]);

Configuration and extension
---------------------------

All messages of log level ``error`` or higher will be written to :file:`source/log/oxideshop.log`.
The log level is :ref:`configurable in the file source/config.inc.php via the variables sLogLevel and iDebug <configincphp_sLogLevel>`.

.. note::

    Keep in mind that in OXID eShop there is also done some logging at ``warning`` level and in order to see those messages
    in your log file, you would have to set the level to ``warning`` in the file :file:`source/config.inc.php`.


When operating an OXID eShop, there may be very specific requirements to the logging mechanism.
Being an e-commerce framework, OXID eShop provides a simple and straight forward default logging mechanism.
You may want to use different channels for the different log levels in different environments and each channel may
require its own configuration.
You are able to adapt the logging to your needs by quickly :doc:`implementing a project and environment specific logger <custom_logger_implementation>`.

Example log file entry
----------------------

Under the hood OXID eShop uses the `Monolog implementation <https://github.com/Seldaek/monolog>`__ of the PSR-3 interface.
As the ``\Monolog\Formatter\LineFormatter`` including stack traces is used, the log file contains the default
`Monolog log messages <https://github.com/Seldaek/monolog/blob/master/doc/message-structure.md>`__.

In the example below you can see a typical line in :file:`source/log/oxideshop.log`:

::

    [2025-09-10 10:33:32] OXID Logger.ERROR: Controller "foo" cannot be resolved ["[object] (OxidEsales\\Eshop\\Core\\Exception\\RoutingException(code: 0): Controller \"foo\" cannot be resolved at /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/source/Core/ShopControl.php:191)\n[stacktrace]\n#0 /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/source/Core/ShopControl.php(867): OxidEsales\\EshopCommunity\\Core\\ShopControl->resolveControllerClass('foo')\n#1 /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/source/Core/ShopControl.php(122): OxidEsales\\EshopCommunity\\Core\\ShopControl->getControllerClass('foo')\n#2 /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/source/Core/Oxid.php(27): OxidEsales\\EshopCommunity\\Core\\ShopControl->start()\n#3 /var/www/oxideshop/source/index.php(16): OxidEsales\\EshopCommunity\\Core\\Oxid::run()\n#4 {main}\n"] []


.. note::

    You can easily change this format by using a :doc:`custom logger implementation <custom_logger_implementation>`.
