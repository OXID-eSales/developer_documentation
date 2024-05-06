Upgrade from CE edition to PE edition
=====================================

This page describes how you can upgrade from OXID eShop CE to PE edition.
You need to perform all of the following actions step by step:

#. Add `oxideshop-metapackage-pe` to your root :file:`composer.json`:

    .. code:: bash

        composer config repositories.oxid-esales composer https://professional-edition.packages.oxid-esales.com

#. Install `oxideshop-metapackage-pe` using composer without executing any scripts:

    .. code:: bash

        composer require oxid-esales/oxideshop-metapackage-pe:^6 --no-plugins --no-scripts

#. Run shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate database views:

   .. code:: bash

      vendor/bin/oe-eshop-db_views_generate

#. Update your dependencies for PE shop and modules:

   .. code:: bash

      composer update