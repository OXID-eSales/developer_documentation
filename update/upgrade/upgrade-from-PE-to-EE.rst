Upgrading from the Professional Edition Edition to the Enterprise Edition
=========================================================================

Upgrading from the Professional Edition (PE) edition to the Enterprise Edition (EE).

|procedure|

#. Add `oxideshop-metapackage-ee` to your root :file:`composer.json`:

   .. code:: bash

    composer config repositories.oxid-esales composer https://enterprise-edition.packages.oxid-esales.com

#. Install `oxideshop-metapackage-ee` using composer without executing any scripts:

   .. code:: bash

     composer require oxid-esales/oxideshop-metapackage-ee:^8 --no-plugins --no-scripts

#. Run the shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views:

   .. code:: bash

    vendor/bin/oe-eshop-db_views_generate

#. Update the dependencies for your EE shop and modules:

   .. code:: bash

    composer update
