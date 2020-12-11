Update
======

This page describes update process for OXID eShop version 6.2.x to 6.3.0. If you want to update to any other
version, please switch to the appropriate version of the documentation.

.. warning::

    Starting from version 6.3.0, OXID eShop stops using MySQL ENCODE() string encryption. As a consequence - all
    existing database records, encoded previously with the database-level encryption, will be decoded and stored as plain text.
    Please consider applying any application-level encryption/decryption, suitable to the needs of your application,
    before storing/retrieving sensitive data.

.. contents ::
    :local:
    :depth: 1

.. note::
    Please complete all update steps in provided order (steps cant not be skipped or swapped) to ensure data consistency.
    Don't forget to prepare a back-up copy for your database before starting.


1. Installing OXID eShop update component
-----------------------------------------
Start with installation of necessary version of
`OXID eShop update component <https://github.com/OXID-eSales/oxideshop-update-component/tree/b-6.3>`__
to prepare your application for updating:

    .. code:: bash

        composer require --update-no-dev oxid-esales/oxideshop-update-component:^v2.0.0

2. Decoding `oxconfig` values
-----------------------------

Decode values stored in `oxconfig` database table by running:

    .. code:: bash

        vendor/bin/oe-console oe:oxideshop-update-component:decode-config-values

3. Updating the application
---------------------------------------
#. Please edit your root :file:`composer.json` file by updating contents of `require` and `require-dev` nodes:

    .. code:: json

        {
            "require": {
                "oxid-esales/oxideshop-metapackage-ce": "v6.3.0"
            },
            "require-dev": {
                "oxid-esales/testing-library": "^v7.1.0",
                "incenteev/composer-parameter-handler": "^v2.0.0",
                "oxid-esales/oxideshop-ide-helper": "^v3.1.2",
                "oxid-esales/azure-theme": "^v1.4.2"
            }
        }


    `Example: updated values for OXID eShop CE v6.3.0`

    You can find current :file:`composer.json` values for your shop edition in OXID eShop project repository:

    - CE: https://github.com/OXID-eSales/oxideshop_project/blob/b-6.3-ce/composer.json
    - PE: https://github.com/OXID-eSales/oxideshop_project/blob/b-6.3-pe/composer.json
    - EE: https://github.com/OXID-eSales/oxideshop_project/blob/b-6.3-ee/composer.json

#. Clean up the :file:`tmp` folder

   .. code:: bash

      rm -rf source/tmp/*

#. Run following to update dependencies:

   .. code:: bash

      composer update --no-dev --no-plugins --no-scripts

#. Run the same command without arguments to initiate all necessary scripts and prepare the compilation:

   .. code:: bash

        composer update --no-dev

        #You might be prompted to allow overwriting existing code for several components.
        #The default value is N [no]

#. Run following to start database migration scripts:

   .. code:: bash

      vendor/bin/oe-eshop-db_migrate migrations:migrate

4. Decoding `oxuserpayments` values
-----------------------------------

Complete the decoding process by running:

    .. code:: bash

        vendor/bin/oe-console oe:oxideshop-update-component:decode-user-payment-values

.. note::

    These decoding commands (`decode-config-values` and `decode-user-payment-values`) are applicable only within the scope
    of this update and are not expected to be run more than once.

5. Removing OXID eShop update component
---------------------------------------

    .. code:: bash

        composer remove --update-no-dev oxid-esales/oxideshop-update-component
