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

Preparations
^^^^^^^^^^^^

You need to update your system to use the highest compatible PHP version
   * for OXID eShop 6.0.6 please use PHP 7.0

   * for OXID eShop 6.1.6 we have two alternatives to switch from composer 1 to composer 2.
     It is possible to use PHP 7.0 or 7.1, but then a forked version of ocramius/package-versions is needed
     or the shop will have to be run on PHP 7.4 which is not officially supported with this OXID eShop version.

     The ocramius/package-versions is required by ocramius/proxy-manager which in turn is
     needed because of doctrine migrations. The lowest official version compatible with composer 1 and 2 is
     ocramius/package-versions 1.8.0 and that one is only compatible with PHP 7.4 and up.
     So either a forked ocramius version that supports Composer-plugin.api 1 and 2 and PHP 7.0 has to be used, or
     you try to run OXID eShop 6.1.6 on PHP 7.4.
     OXID never tested OXID eShop 6.1.6 on PHP 7.4 for a release but locally it looks working.

   * for OXID eShop 6.2.2 please use PHP 7.4
     ... to be continued


Manually assemble the composer.json
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. In the OXID eShop`s root directory, run the following command:

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
#. Remove all packages from require-dev section of the original composer.json (like "oxid-esales/testing-library" and "incenteev/composer-parameter-handler")
#. Remove "scripts" and "extra" section from the new composer.json
#. Replace the :code:`"require": { ...}` section in your root :file:`composer.json` file with this content.
#. Backup your current :file:`composer.lock` file.


Generate composer.json by script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. alternative, prepare a composer.json from the provided example script which you might adapt to your needs
   .. literalinclude:: convertLockToComposer.php
      :language: php

   The example script automatically excludes all the packages we know to not be needed in your custom composer.json.


Update to composer 2 and verify results
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now we need to change the composer-plugin-api 1 components to a branch supporting composer 1 as well as composer 2
or immediately go the 'full way' and switch to composer 2.

.. important::
     As stated before, OXID eShop 6.1.6 can be made to work with composer 2, when updating to PHP 7.4 and switching to
     .. code:: shell
       composer config repositories.oxideshop_composer_plugin git https://github.com/OXID-eSales/oxideshop_composer_plugin
       composer config repositories.oxideshop-unified-namespace-generator git https://github.com/OXID-eSales/oxideshop-unified-namespace-generator
       composer require --no-update oxid-esales/oxideshop-composer-plugin dev-b-2.x-OXDEV-9162
       composer require --no-update oxid-esales/oxideshop-unified-namespace-generator dev-b-2.x-OXDEV-9162
       composer require --no-update ocramius/package-versions 1.8.0
       composer require --no-update ocramius/proxy-manager 2.1.1

.. important::
     Alternatively OXID eShop 6.1.6 can be made to work with composer 1 and 2 when using PHP 7.0 or 7.1 and using a fork of ocramius/package-versions
     .. code:: shell
       composer config repositories.oxideshop_composer_plugin git https://github.com/OXID-eSales/oxideshop_composer_plugin
       composer config repositories.oxideshop-unified-namespace-generator git https://github.com/OXID-eSales/oxideshop-unified-namespace-generator
       composer config repositories.package-versions git https://github.com/hkreuter/PackageVersions
       composer require --no-update oxid-esales/oxideshop-composer-plugin dev-b-2.x-OXDEV-9162
       composer require --no-update oxid-esales/oxideshop-unified-namespace-generator dev-b-2.x-OXDEV-9162
       composer require --no-update ocramius/package-versions "dev-b-1.x-OXDEV-9162 as 1.2.0"

.. important::
   For OXID eShop 6.0.6, please ensure the following packages are used
   .. code:: shell
     composer config repositories.oxideshop_composer_plugin git https://github.com/OXID-eSales/oxideshop_composer_plugin
     composer config repositories.oxideshop-unified-namespace-generator git https://github.com/OXID-eSales/oxideshop-unified-namespace-generator
     composer require --no-update oxid-esales/oxideshop-composer-plugin dev-b-2.x-OXDEV-9162
     composer require --no-update oxid-esales/oxideshop-unified-namespace-generator dev-b-1.x-OXDEV-9162

#. Run composer update:
   Please keep in mind that we expect this no longer to be possible with composer 1 after 2025-08-01.
   In that case, please first update to composer 2 (composer self-update --2) and then run composer update.

   .. code:: shell

      composer update --no-scripts --no-plugins
      composer update


#. Compare the current :file:`composer.lock` file with the one you have backed up.

   Make sure the only difference is the missing :code:`oxideshop-metapackage-*`,
   require-dev entries and the changes above mentioned packages.


Fetching updated packages directly from the source
--------------------------------------------------

Packages tagged after 2025-02-01 will not be delivered from packagist via composer 1.
It is possible to directly register package sources in your composer.json, you then just need to add the specific
package version that has to be required.

You will need to try out, if this approach works in your specific case.

