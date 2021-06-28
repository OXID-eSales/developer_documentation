Update 6.3.x to 7.0.0
=====================

This page describes update process for OXID eShop version 6.2.x to 7.0.0. If you want to update to any other
version, please switch to the appropriate version of the documentation.

.. warning::

    Starting from version 7.0.0, OXID eShop stops using MySQL ENCODE() string encryption. As a consequence - all
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
`OXID eShop update component <https://github.com/OXID-eSales/oxideshop-update-component/tree/b-7.0>`__
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
                "oxid-esales/oxideshop-metapackage-ce": "v7.0.0"
            },
            "require-dev": {
                "oxid-esales/testing-library": "^v7.1.0",
                "incenteev/composer-parameter-handler": "^v2.0.0",
                "oxid-esales/oxideshop-ide-helper": "^v3.1.2",
                "oxid-esales/azure-theme": "^v1.4.2"
            }
        }


    `Example: updated values for OXID eShop CE v7.0.0`

    You can find current :file:`composer.json` values for your shop edition in OXID eShop project repository:

    - CE: https://github.com/OXID-eSales/oxideshop_project/blob/b-7.0-ce/composer.json
    - PE: https://github.com/OXID-eSales/oxideshop_project/blob/b-7.0-pe/composer.json
    - EE: https://github.com/OXID-eSales/oxideshop_project/blob/b-7.0-ee/composer.json

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

   .. important::

      Composer will ask you to overwrite module and theme files. E.g.: "Update operation will overwrite oepaypal files in
      the directory source/modules. Do you want to overwrite them? (y/N)"
      If you include modules by ``"type": "path",`` in your :file:`composer.json` file like described in
      :doc:`Best practice module setup </development/modules_components_themes/module/tutorials/module_setup>`, answer ``No`` to this question..


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

6. Make modules compatible with psr-12
--------------------------------------

Based on the psr-12 (`more info <https://www.php-fig.org/psr/psr-12>`__), method names MUST NOT be
prefixed with a single underscore to indicate protected or private visibility.
That is, an underscore prefix explicitly has no meaning.

In the shop, we have already renamed all the underscore methods by removing their prefix underscore.
This step has to be done for modules as well, because if there is any call for the shop underscore methods,
they will not work anymore. On the other hand, the modules underscore methods should be
also renamed to make them compatible with psr-12.

It can be done either manually or via rector which helps us to do it faster.
We already have provided a rector for this purpose and it can be run with the following steps:

- Update composer with adding ``rector/rector`` package:

.. code::

    "require-dev": {
        "rector/rector": "dev-master"
    },
    "repositories": {
        "rector/rector": {
            "type": "vcs",
            "url": "https://github.com/OXID-eSales/rector"
        }
    }

- Renaming underscore methods:

.. code::

    # e.g. for oxid-esales/paypal-module
    cp vendor/rector/rector/templates/oxidEsales/oxid_V7_underscored_methods_renamer_rector.php.dist  ./rector.php && sed -i 's/MODULE_VENDOR_PATH/oxid-esales\/paypal-module/g' rector.php && vendor/bin/rector process