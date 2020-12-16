Upgrade from 6.2.x CE edition to 6.2.x PE edition
=================================================

This page describes how you can upgrade from OXID eShop version 6.2.x CE edition to 6.2.x PE edition.
You need to perform all of the following actions step by step:

#. Add `oxideshop-metapackage-pe` to your root :file:`composer.json`:

    .. code:: bash

        composer config repositories.oxid-esales composer https://professional-edition.packages.oxid-esales.com

#. install `oxideshop-metapackage-pe` using composer without executing any scripts:

    .. code:: bash

        composer require oxid-esales/oxideshop-metapackage-pe --no-plugins --no-scripts

#. run shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate database views:

   .. code:: bash

      vendor/bin/oe-eshop-db_views_generate

#. Update your dependencies for PE shop and modules:

   .. code:: bash

      composer update