Default update (minor/patch) starting from version 6.0.0
========================================================

The following steps need to be done when you want to update your compilation from any 6.x.x to a higher 6.x.x version. 
In case you need to do more we will explicitly name those steps as notices.

   .. notice:: When updating from any 6.0.x version to any 6.1.x version, please think of updating the testing library version according to https://github.com/OXID-eSales/oxideshop_project/compare/b-6.0-ce...b-6.1-ce as well.

1. Please edit the `oxid-esales/oxideshop-metapackage` version requirement in your root :file:`composer.json` file by changing
   version to new compilation version you want to update to, for example: "v6.1.0".
   
2. For updating dependencies (necessary to update all libraries), in the project folder run:

   .. code:: bash

      composer update --no-plugins --no-scripts

3. For executing all necessary scripts to actually gather the new compilation, in the project folder run:

   .. code:: bash

      composer update #(You will be prompted wether to overwrite existing code for several components. The default value is N [no] but of course you should take care to reply with y [yes].)

4. For executing possible database migrations, in the project folder run:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate
