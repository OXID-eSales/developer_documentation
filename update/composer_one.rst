Update from Compilation below 6.2.3
===================================

OXID Cbe shut downompilations below 6.2.3 are still using composer 1 which will
be shut down in two steps starting 2025-02-01.

From 2025-02-01 on, no new packages will be shipped by packagust via composer 1. Means
for example when a new modules was released after first of February, you will not be able to pull
it when using composer 1.
The second stage will be on 2025-08-01 when all support of composer 1 ends for packagist. You will only be able to
restore and existing state of your application as long as you have a composer.lock file.

You might have seen the following message when running composer install or update:

.. important::

   Warning from https://repo.packagist.org:  Support for Composer 1 will be shutdown on August 1st 2025. You should upgrade to Composer 2.


OXID eShop Compilation metapackages from 6.0.0 to below 6.2.3 are not compatible with composer 2.
More specific, the components named oxid-esales/oxideshop-unified-namespace-generator and
oxid-esales/oxideshop-composer-plugin require the composer plugin api version 1.
We provide compatible branches of those components which work with both composer 1 and composer 2 to help you
switching your existing application to composer 2.

In order to switch your composer 1 OXID eShop to composer 2, you will need to prepare your custom composer.json,
the replace composer 1 with composer 2 and then verify, that the installation can be successfully run with composer 2.

Building a custom metapackage
-----------------------------

This means, you first have to change your root :file:`composer.json` file from including metapackages to directly including all packages currently installed.

|procedure|

.. todo: #tbd: add screenshots

1. In the OXID eShop`s root directory, run the following command:

   .. code:: shell

      composer show --locked

   All components currently installed are displayed with their exact version numbers.

#. Convert this output into :code:`composer.json` format:

   .. code:: shell

      "oxid-esales/oxideshop-ce":"v6.0.0",
      "oxid-esales/oxideshop-composer-plugin":"v7.1.0",
      "oxid-esales/oxideshop-db-views-generator":"v2.1.0",
      "oxid-esales/oxideshop-demodata-ce":"v8.0.0",
      ....

#. Remove all occurrences of OXID eShop metapackages (:code:`oxideshop-metapackage-*`) from this list, as their requirements are already included.
#. Replace the :code:`"require": { ...}` section in your root :file:`composer.json` file with this content.
#. Backup your current :file:`composer.lock` file.
#. Run composer update:

   .. code:: shell

      composer update

#. Compare the current :file:`composer.lock` file with the one you have backed up.

   Make sure the only difference is the missing :code:`oxideshop-metapackage-*` entries.

