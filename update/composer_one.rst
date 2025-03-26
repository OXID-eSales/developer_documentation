Update from Compilation below 6.2.3
===================================

OXID Compilations below 6.2.3 are still using composer 1 which will
be shut down in two steps starting 2025-02-01.

From 2025-02-01 on, composer 1.x metadata will be readonly. No new packages will be shipped by packagist via composer 1. Means
for example when a new module was released after first of February, you will not be able to pull
it when using composer 1.
The second stage will be on 2025-08-01 when all support of composer 1 ends for packagist. You will only be able to
restore and existing state of your application as long as you have a composer.lock file.

"Even after 1.x metadata access is shut down, you can still run composer install with existing lock files.
 These lock files contain all the necessary download information and don't require metadata
 from Packagist.org unless you attempt to update dependencies."

You might have seen the following message when running composer install or update:

.. important::

   Warning from https://repo.packagist.org:  Support for Composer 1 will be shutdown on August 1st 2025. You should upgrade to Composer 2.


OXID eShop Compilation metapackages from 6.0.0 to below 6.2.3 are not compatible with composer 2.
More specific, the components named oxid-esales/oxideshop-unified-namespace-generator and
oxid-esales/oxideshop-composer-plugin require the composer-plugin-api version 1.
We provide compatible branches of those components which work with both composer 1 and composer 2 to help you
switching your existing application to composer 2.

In order to switch your composer 1 OXID eShop to composer 2, you will need to prepare your custom composer.json,
the replace composer 1 with composer 2 and then verify, that the installation can be successfully run with composer 2.

Building a custom metapackage and switching to composer 2
---------------------------------------------------------

This means, you first have to change your root :file:`composer.json` file from including metapackages to directly including all packages currently installed.

|procedure|

.. todo: #tbd: add screenshots

1. In the OXID eShop`s root directory, run the following command:

   .. code:: shell

      composer show --installed --format=json

   All components currently installed are displayed with their exact version numbers.

#. Convert this output into :code:`composer.json` format:

   .. code:: shell

      "oxid-esales/oxideshop-ce":"v6.2.4",
      "oxid-esales/oxideshop-composer-plugin":"v2.0.3",
      "oxid-esales/oxideshop-db-views-generator":"v1.2.0",
      "oxid-esales/oxideshop-demodata-ce":"v6.0.1",
      ....

#. Remove all occurrences of OXID eShop metapackages (:code:`oxideshop-metapackage-*`) from this list, as their requirements are already included.
#. Remove all packages from require-dev section of the original composer.json (like "oxid-esales/testing-library" and ""incenteev/composer-parameter-handler")
#. Remove "scripts" and "extra" section from he new composer.json
#. Replace the :code:`"require": { ...}` section in your root :file:`composer.json` file with this content.
#. Backup your current :file:`composer.lock` file.
#. Now we need to change the composer-plugin-api 1 components to a branch supporting composer 1 as well as composer 2.
   .. code:: shell
     composer config repositories.oxideshop_composer_plugin git https://github.com/OXID-eSales/oxideshop_composer_plugin.git
     composer config repositories.oxideshop-unified-namespace-generator git https://github.com/OXID-eSales/oxideshop-unified-namespace-generator.git
     composer require --no-update oxid-esales/oxideshop-composer-plugin dev-b-2.x-OXDEV-9162
     composer require --no-update oxid-esales/oxideshop-unified-namespace-generator dev-b-1.x-OXDEV-9162

#. Run composer update:
   Please keep in mind that we expect this no longer to be possible with composer 1 after 2025-08-01.
   In that case, please update to composer 2 (composer self-update --2) and then run composer update.

   .. code:: shell

      composer update

#. Compare the current :file:`composer.lock` file with the one you have backed up.

   Make sure the only difference is the missing :code:`oxideshop-metapackage-*` and require-dev entries and the changes in unified-namespace-generator and the composer-plugin.


