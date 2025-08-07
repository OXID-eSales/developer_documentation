Environment variables
=====================

OXID eShop supports loading environment variables via a `.env` file.

This feature simplifies the management of sensitive configuration values and environment-specific settings.

Feature Overview
----------------

Define environment variables in a `.env` file located in the root directory of your project.

These variables can then be accessed using:

* The `getenv()` PHP function
* Injection into container parameters

Using environment variables
---------------------------

1. Create a `.env` file in the root directory of your project. Define your environment variables in the following format:

   .. code-block:: ini

      # .env
      OXID_ENV=production
      AI_EMBEDDINGS_DATABASE=mysql://user:password@127.0.0.1:3306/db_name
      API_KEY=your_api_key_here

#. Access the loaded environment variables in one of the following two ways:

   * Use `getenv()` in your PHP code:

     .. code-block:: php

        <?php

        $environment = getenv('OXID_ENV');
        echo "Current environment: $environment";

   * Define the environment variables in your `services.yaml` configuration file to be used in services:

     .. code-block:: yaml

        parameters:
            app.env: '%env(OXID_ENV)%'
            embeddings.db: '%env(AI_EMBEDDINGS_DATABASE)%'
            api.key: '%env(API_KEY)%'

        services:
            App\Service\SomeService:
                arguments:
                    $env: '%app.env%'
                    $dbUrl: '%embeddings.db%'

Implementing Best Practices
---------------------------

* To prevent sensitive data from being pushed to version control, do not commit the `.env` file. Instead, add it to your `.gitignore` file.
* To help other developers set up their local environment, provide a `.env.dist` file with default values.
