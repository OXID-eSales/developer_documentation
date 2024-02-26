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

[2024-02-26 18:17:17] OXID Logger.ERROR: Template "page/shop/start" nicht gefunden ["[object] (OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateNotInChainException(code: 0): Error building inheritance chain for the template `@__main__/page/shop/start.html.twig`. at /var/www/vendor/oxid-esales/twig-component/src/Resolver/TemplateChain/TemplateChainValidator.php:21)\n[stacktrace]\n#0 /var/www/vendor/oxid-esales/twig-component/src/Resolver/TemplateChain/TemplateChainBuilderAggregate.php(38): OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateChainValidator->validateTemplateChain(Object(OxidEsales\\Twig\\Resolver\\TemplateChain\\DataObject\\TemplateChain), Object(OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateType\\DataObject\\ShopTemplateType))\n#1 /var/www/vendor/oxid-esales/twig-component/src/Resolver/TemplateChain/TemplateChainResolver.php(35): OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateChainBuilderAggregate->getChain(Object(OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateType\\DataObject\\ShopTemplateType))\n#2 /var/www/vendor/oxid-esales/twig-component/src/TwigEngine.php(44): OxidEsales\\Twig\\Resolver\\TemplateChain\\TemplateChainResolver->getLastChild('page/shop/start...')\n#3 /var/www/source/Internal/Framework/Templating/TemplateRenderer.php(28): OxidEsales\\Twig\\TwigEngine->render('page/shop/start...', Array)\n#4 /var/www/source/Core/ShopControl.php(436): OxidEsales\\EshopCommunity\\Internal\\Framework\\Templating\\TemplateRenderer->renderTemplate('page/shop/start', Array)\n#5 /var/www/vendor/oxid-esales/oxideshop-ee/Core/ShopControl.php(203): OxidEsales\\EshopCommunity\\Core\\ShopControl->render(Object(OxidEsales\\Eshop\\Application\\Controller\\StartController))\n#6 /var/www/source/Core/ShopControl.php(317): OxidEsales\\EshopEnterprise\\Core\\ShopControl->render(Object(OxidEsales\\Eshop\\Application\\Controller\\StartController))\n#7 /var/www/vendor/oxid-esales/oxideshop-ee/Core/ShopControl.php(90): OxidEsales\\EshopCommunity\\Core\\ShopControl->formOutput(Object(OxidEsales\\Eshop\\Application\\Controller\\StartController))\n#8 /var/www/source/Core/ShopControl.php(241): OxidEsales\\EshopEnterprise\\Core\\ShopControl->formOutput(Object(OxidEsales\\Eshop\\Application\\Controller\\StartController))\n#9 /var/www/source/Core/ShopControl.php(124): OxidEsales\\EshopCommunity\\Core\\ShopControl->process('OxidEsales\\\\Esho...', NULL, NULL, NULL)\n#10 /var/www/source/Core/Oxid.php(27): OxidEsales\\EshopCommunity\\Core\\ShopControl->start()\n#11 /var/www/source/index.php(16): OxidEsales\\EshopCommunity\\Core\\Oxid::run()\n#12 {main}\n"] []


.. note::

    You can easily change this format by using a :doc:`custom logger implementation <custom_logger_implementation>`.
