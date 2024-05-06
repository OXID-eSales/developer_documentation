Upgrading from the Community Edition to the Professional Edition
================================================================

Upgrade your OXID eShop from the Community Edition (CE) to the Professional Edition (PE).

|procedure|

#. Add `oxideshop-metapackage-pe` to your root :file:`composer.json`:

   .. code:: bash

     composer config repositories.oxid-esales composer https://professional-edition.packages.oxid-esales.com

#. Install `oxideshop-metapackage-pe` using composer without executing any scripts:

   .. code:: bash

        composer require oxid-esales/oxideshop-metapackage-pe:^7 --no-plugins --no-scripts

#. Run the shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views:

   .. code:: bash

     vendor/bin/oe-eshop-db_views_generate

#. Update the dependencies for your PE shop and modules:

   .. code:: bash

     composer update


#. Clear the cache:

   .. code:: bash

     vendor/bin/oe-console oe:cache:clear
