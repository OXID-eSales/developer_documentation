Usage of logging in the code
============================

OXID eShop exposes a `PSR-3 <https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md>`__
compatible logger implementation, which is provided by ``Registry::getLogger()``. Please also read about
the :doc:`system architecture </system_architecture/logging>` and :doc:`configuration / extension in your project </project/index>`.

The following code example uses different logger methods, which correspond to different log levels.
It is a best practice to pass some context information to the logger.
In the case of an exception, this is the only way to get information about the stack trace.

.. code:: php

        $logger = Registry::getLogger();
        try () {
            // Do something. E.g. Apply some discount.
            $logger->debug(
                'Discount applied',
                [
                    'class'  => __CLASS__,
                    'method' => __FUNCTION__,
                    'shopId' => $shopId,
                    'userId' => $userId,
                    'amount' => $amount,
                ]
            );
        } catch (\Exception $exception) {
            // report exception
            $logger->error($exception->getMessage(), [$exception]);

            // Handle the exception. E.g. cleanup
        }

.. note::

    Only the methods defined by PSR-3, are exposed.

    For the sake of compatibility you will not be able to use implementation specific methods like
    ``\Monolog\Logger::addError`` or ``\Monolog\Logger::pushProcessor``, as the implementation itself
    will not be exposed.

If you are writing a module for a specific e-commerce project you are able to provide fine grained information by using
different log levels, which you can turn on or of by setting the minimum log level in the OXID eShop configuration file :file:`config.inc.php`.
