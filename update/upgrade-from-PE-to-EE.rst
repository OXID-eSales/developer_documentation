Upgrading from PE edition to EE edition
=======================================

This page describes how you can upgrade from OXID eShop PE to EE edition.
You need to perform all of the following actions step by step:

#. Add `oxideshop-metapackage-ee` to your root :file:`composer.json`:

   .. code:: bash

    composer config repositories.oxid-esales composer https://enterprise-edition.packages.oxid-esales.com

#. install `oxideshop-metapackage-ee` using composer without executing any scripts:

   .. code:: bash

     composer require oxid-esales/oxideshop-metapackage-ee --no-plugins --no-scripts

#. run shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate database views:

   .. code:: bash

    vendor/bin/oe-eshop-db_views_generate

#. Update your dependencies for EE shop and modules:

   .. code:: bash

    composer update
