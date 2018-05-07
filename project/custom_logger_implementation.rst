Implement a custom PSR-3 logger
===============================

Changing the PSR-3 implementation, which is used by OXID eShop is as easy as creating a PHP function named ``getLogger()`` in the file :file:`source/modules/functions.php`.

This new global function will completely override the implementation as defined in :file:`source/overridablefunctions.php`.

.. note::

    The file :file:`source/modules/functions.php` does not exist by default and may have to be created first.


``\getLogger()`` must return an instance of a PSR-3 compatible logging implementation.
Of course you can write your own implementation.
But you can also use `Monolog <https://github.com/Seldaek/monolog>`__ as a base. It offers plenty of possibilities
with lots of existing Handlers, Formatters or Processors.


Code example
------------

The following code example implements ``\getLogger()`` using `Monolog <https://github.com/Seldaek/monolog>`__ and
`phpdotenv <https://github.com/vlucas/phpdotenv>`__. It is just a quick sketch to give you an idea, of what if possible.

.. code:: php

    /**
     * Return an instance of a PSR-3 compatible logger
     *
     * @return \Psr\Log\LoggerInterface
     */
    function getLogger()
    {
        $exceptionFormatter = new \Monolog\Formatter\LineFormatter();
        $exceptionFormatter->includeStacktraces(true);

        /**
         * In development environments everything will be logged to the browser console
         */
        if ('DEV' === getenv('ENVIRONMENT')) {
            // See custom formatter example below
            // $exceptionFormatter = new \MyNamespace\ExceptionFormatter();
            // $exceptionFormatter->includeStacktraces(true);

            $debugHandler = new \Monolog\Handler\BrowserConsoleHandler(\Monolog\Logger::DEBUG);
            $debugHandler->setFormatter($exceptionFormatter);

            $logger = new Logger('test logger');
            $logger->pushHandler($debugHandler);
        }

        /**
         * In testing environments nothing will be logged.
         * This may no make a lot of sense, depending on the use case.
         */
        if ('TEST' === getenv('ENVIRONMENT')) {
            $logger = new Psr\Log\NullLogger();
        }

        /**
         * In staging and productive environments errors are collected in Sentry.
         */
        if (
            'STAGE' === getenv('ENVIRONMENT') ||
            'PROD' === getenv('ENVIRONMENT')
        ) {
            //
            $ravenClient = new \Raven_Client(getenv('SENTRY_DSN'));
            $errorHandler = new Monolog\Handler\RavenHandler(
                $ravenClient,
                \Monolog\Logger::ERROR
            );
            $errorHandler->setFormatter($exceptionFormatter);

            $logger = new Logger('MyShop logger');
            $logger->pushHandler($debugHandler);
        }

        /**
         * Really critical stuff should be logged to an instant messaging channel
         * like Pushover or Slack.
         */
        if ('PROD' === getenv('ENVIRONMENT')) {
            $criticalHandler = new \Monolog\Handler\PushoverHandler(
                getenv('PUSHOVER_TOKEN'),
                [getenv('PUSHOVER_PRIMARY_SUPPORT_LEVEL_USER'), getenv('PUSHOVER_CTO_USER')],
                'Critical error on shop XY. Your immediate action required.',
                \Monolog\Logger::CRITICAL
            );

            $logger = new Logger('MyShop logger');
            $logger->pushHandler($criticalHandler);
        }

        /**
         * You may use a processor, which enriches the log record with contextual information,
         * like the Session ID, shop ID or the current memory usage.
         */
         // $myProcessor = new \MyNamespace\Processor();
         // $logger->pushProcessor($myProcessor);

        return $logger;
    }


Changing the default log Monolog message structure
--------------------------------------------------

The `message structure <https://github.com/Seldaek/monolog/blob/master/doc/message-structure.md>`__ used by Monolog can easily be
`customized by configuration <https://github.com/Seldaek/monolog/blob/master/doc/01-usage.md#customizing-the-log-format>`__.

If the configuration options are not sufficient for you needs, you can also implement a custom LineFormatter like this:

.. code:: php

    /**
     * This code is for PHP versions 7.x ONLY
     */
    class ExceptionFormatter extends LineFormatter
    {

        /**
         * {@inheritdoc}
         */
        public function format(array $record)
        {
           if ($record['context'][0] instanceof \Throwable) {
                /** @var \Exception $exception */
                $exception = $record['context'][0];

                /** @var DateTime $dateTime */
                $dateTime = $record['datetime'];
                $timestamp = $dateTime->format("Y-m-d\TH:i:s.uO");
                $exceptionClass = get_class($exception);
                $file = $exception->getFile();
                $line = $exception->getLine();
                $code = $exception->getCode();
                $message = $exception->getMessage();

                $output = "[$timestamp] [{$record['level_name']}] [type $exceptionClass] [file {$file}] [line {$line}] [code {$code}] [message {$message}]" . PHP_EOL;

                $trace = $exception->getTraceAsString();
                $lines = explode(PHP_EOL, $trace);
                foreach ($lines as $line) {
                    $output .= "[$timestamp] [{$record['level_name']}] [stacktrace] " . $line . PHP_EOL;
                }
            }

            return $output;
        }
    }

    // You would use it instead of the default formatter in the example above
    $exceptionFormatter = new \MyNamespace\ExceptionFormatter();
    $exceptionFormatter->includeStacktraces(true);
