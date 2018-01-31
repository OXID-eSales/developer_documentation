Default update (minor/patch) starting from version 6.0.0
========================================================

The following steps need to be done when you want to update your compilation from any 6.x.x to a higher 6.x.x version. 
In case you need to do more we will explicitly name those steps.

1. Please edit the `oxid-esales/oxideshop-metapackage` version requirement in your root :file:`composer.json` file by changing
   version to new compilation version you want to update to, for example: "v6.0.1".
   
2. For updating dependencies (necessary to update all libraries), in the project folder run:

   .. code:: bash

      composer update --no-plugins --no-scripts

3. For executing all necessary scripts to actually gather the new compilation, in the project folder run:

   .. code:: bash

      composer update

4. For executing possible database migrations, in the project folder run:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate
