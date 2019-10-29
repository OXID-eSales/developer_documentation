Logging
=======

OXID eShop provides a `PSR-3 <https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md>`__
compatible logging mechanism.

Usage
-----

In a nutshell, you would log something in your code like this:

.. code:: php

        $logger = Registry::getLogger();
        $logger->warning('Some message ...', [__CLASS__, __FUNCTION__]);

Please, read also the :doc:`detailed usage <logging_usage>` information.


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

    [2018-05-09 12:05:50] OXID Logger.ERROR: EXCEPTION_SYSTEMCOMPONENT_CLASSNOTFOUND MyVendor\MyModule\Application\Foo ["[object] (OxidEsales\\Eshop\\Core\\Exception\\SystemComponentException(code: 0): EXCEPTION_SYSTEMCOMPONENT_CLASSNOTFOUND MyVendor\\MyModule\\Application\\Foo at /var/www/oxideshop/source/Core/UtilsObject.php:222)\n[stacktrace]\n#0 /var/www/oxideshop/source/oxfunctions.php(101): OxidEsales\\EshopCommunity\\Core\\UtilsObject->oxNew('MyVendor\\\\MyModu...')\n#1 /var/www/oxideshop/source/Application/Controller/ArticleDetailsController.php(208): oxNew('MyVendor\\\\MyModu...')\n#2 /var/www/oxideshop/source/Core/ViewConfig.php(955): OxidEsales\\EshopCommunity\\Application\\Controller\\ArticleDetailsController->getNavigationParams()\n#3 /var/www/oxideshop/source/tmp/smarty/6ce77b7a9d9444335a4b8f5ea13cf8cb^%%08^08A^08ABD53A%%details.tpl.php(11): OxidEsales\\EshopCommunity\\Core\\ViewConfig->getNavUrlParams()\n#4 /var/www/oxideshop/vendor/smarty/smarty/libs/Smarty.class.php(1270): include('/var/www/oxides...')\n#5 /var/www/oxideshop/source/Core/ShopControl.php(488): Smarty->fetch('page/details/de...', 'ox|0|0|0|0|85b4...')\n#6 /var/www/oxideshop/source/Core/ShopControl.php(344): OxidEsales\\EshopCommunity\\Core\\ShopControl->_render(Object(OxidEsales\\Eshop\\Application\\Controller\\ArticleDetailsController))\n#7 /var/www/oxideshop/source/Core/ShopControl.php(276): OxidEsales\\EshopCommunity\\Core\\ShopControl->formOutput(Object(OxidEsales\\Eshop\\Application\\Controller\\ArticleDetailsController))\n#8 /var/www/oxideshop/source/Core/ShopControl.php(137): OxidEsales\\EshopCommunity\\Core\\ShopControl->_process('OxidEsales\\\\Esho...', NULL, NULL, NULL)\n#9 /var/www/oxideshop/source/Core/Oxid.php(26): OxidEsales\\EshopCommunity\\Core\\ShopControl->start()\n#10 /var/www/oxideshop/source/index.php(15): OxidEsales\\EshopCommunity\\Core\\Oxid::run()\n#11 /var/www/oxideshop/source/oxseo.php(28): require('/var/www/oxides...')\n#12 {main}\n"] []


.. note::

    You can easily change this format by using a :doc:`custom logger implementation <custom_logger_implementation>`.
