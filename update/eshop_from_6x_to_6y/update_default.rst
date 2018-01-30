Default update (minor/patch) starting from version 6.0.0
========================================================

1. Please edit the `oxid-esales/oxideshop-metapackage` version requirement in your root `composer.json` file by changing
   version to new compilation version, for example: "v6.0.1".
2. In the project, run:

   .. code:: bash

      composer update --no-plugins --no-scripts

   for updating dependencies.

3. In the project, run:

   .. code:: bash

      composer update

   for executing all necessary scripts.

4. In the project, run:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate

   for executing possible database migrations.
