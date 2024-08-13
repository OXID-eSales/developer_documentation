Environment variables
=====================

OXID eShop now supports loading environment variables via a `.env` file. This feature simplifies the management of sensitive configuration values and environment-specific settings.

Feature Overview
----------------

Define environment variables in a `.env` file located in the root directory of your project. These variables can then be accessed using:

- The `getenv()` PHP function.
- Injection into container parameters.

How to Use
----------

Step 1: Create a `.env` file
    Create a `.env` file in the root directory of your project. Define your environment variables in the following format:

    .. code-block:: ini

        # .env
        OXID_ENV=prod
        DATABASE_URL=mysql://user:password@127.0.0.1:3306/db_name
        API_KEY=your_api_key_here

Step 2: Access Environment Variables
    You can access the loaded environment variables in two ways:

    1. **Using `getenv()` in your PHP code:**

    .. code-block:: php

        <?php

        $environment = getenv('OXID_ENV');
        echo "Current environment: $environment";

    2. **Injecting Variables into `services.yaml`:**

    Define the environment variables in your `services.yaml` configuration file for use in services:

    .. code-block:: yaml

        parameters:
            app.env: '%env(OXID_ENV)%'
            database.url: '%env(DATABASE_URL)%'
            api.key: '%env(API_KEY)%'

        services:
            App\Service\SomeService:
                arguments:
                    $env: '%app.env%'
                    $dbUrl: '%database.url%'

Best Practices
--------------

1. **Do not commit the `.env` file**: Add the `.env` file to your `.gitignore` to prevent sensitive data from being pushed to version control.

2. **Use `.env.dist` for defaults**: Provide a `.env.dist` file with default values to help other developers set up their local environment.

.. centered::
    `***`

OXID_DB_URL
    The database connection information is stored as an environment variable called ``OXID_DB_URL`` .

    .. code:: php

        OXID_DB_URL=mysql://root:root@mysql:3306/example?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=''"

OXID_BUILD_DIRECTORY
    Directory will be used to compile shop files.

    .. code:: php

        OXID_BUILD_DIRECTORY=/var/www/source/tmp/

OXID_LOG_LEVEL
    You can set the log level to one of the levels defined by `PsrLogLevel <https://www.php-fig.org/psr/psr-3>`__.
    This level will be used by the default PSR-3 logging implementation of OXID eShop.

    .. code:: php

        OXID_LOG_LEVEL=error

    .. note::

        Keep in mind that this is the minimum level to be logged and lower levels would not be logged, even if those log levels
        are used in the code.

        The message in the following code example will not be logged to any logging channel if `OXID_LOG_LEVEL` is set to ``warning``.
        You would have to set `OXID_LOG_LEVEL` to ``debug`` to see something in the error log file.

        .. code:: php

            $logger->debug('Some debug message', [__CLASS__, __FUNCTION__]);

        Like this you are able to change the log level temporarily even in productive environments to see more information in
        your log file.

OXID_DEBUG_MODE
    This parameter allows you to enable or disable debugging using `true` and `false` values. Please set this parameter to false
    in production mode.

OXID_ENV
    To change the application's running environment, edit the ``OXID_ENV`` variable in ``.env`` file or in a ``.env.local``
    file if it has been created:

    .. code::

        # .env (or .env.local)
        OXID_ENV=prod


OXID_DEFAULT_TIMEZONE
    You can configure the shop's timezone using this environment variable, with the default set to Europe/Berlin.

OXID_SHOP_BASE_URL
    Set up the :ref:`shop url <oxid_esales.shop_url>` parameter.