Configuration Environments
==========================

OXID eShop utilizes Configuration Environments functionality provided by the
`Symfony Dotenv Component <https://github.com/symfony/dotenv>`__.

The most recent and concise info for this component's features can be found in
`Configuration Based on Environment Variables <https://symfony.com/doc/current/configuration.html#configuration-environments>`__
section of the Symfony docs.

.. tip::
    If not sure, it's reasonable to follow the approach to the `.env` file's structure, recommended by Symfony developers,
    when planning your own environment configurations:

        * :file:`.env`: defines the default values of the env vars needed by the application;
        * :file:`.env.local`: overrides the default values for all environments but only on the machine which contains the file. This file should not be committed to the repository and it's ignored in the test environment (because tests should produce the same results for everyone);
        * :file:`.env.<environment>` (e.g. :file:`.env.test`): overrides env vars only for one environment but for all machines (these files are committed);
        * :file:`.env.<environment>.local` (e.g. :file:`.env.test.local`): defines machine-specific env var overrides only for one environment. It's similar to :file:`.env.local`, but the overrides only apply to one environment.
