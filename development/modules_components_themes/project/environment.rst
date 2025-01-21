Environment variables
=====================

OXID eShop now supports loading environment variables via a `.env` file. This feature simplifies the management of sensitive configuration values and environment-specific settings.

**Feature Overview**
--------------------

Define environment variables in a `.env` file located in the root directory of your project. These variables can then be accessed using:

- The `getenv()` PHP function.
- Injection into container parameters.

**How to Use**
--------------

### Step 1: Create a `.env` File

Create a `.env` file in the root directory of your project. Define your environment variables in the following format:

.. code-block:: ini

    # .env
    OXID_ENV=production
    DATABASE_URL=mysql://user:password@127.0.0.1:3306/db_name
    API_KEY=your_api_key_here

### Step 2: Access Environment Variables

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

**Best Practices**
------------------

1. **Do not commit the `.env` file**: Add the `.env` file to your `.gitignore` to prevent sensitive data from being pushed to version control.

2. **Use `.env.dist` for defaults**: Provide a `.env.dist` file with default values to help other developers set up their local environment.