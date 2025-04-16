Switch OXID eShop Compilation 6.2.0-6.2.2  from Composer 1 to Composer 2
========================================================================

OXID Compilations below 6.2.3 are still using composer 1 which will
be shut down in two steps starting 2025-02-01.

From 2025-02-01 on, composer 1.x metadata will be readonly. No new packages will be shipped by packagist via composer 1. Means
for example when a new module was released after first of February, you will not be able to pull
it via packagist when using composer 1.
The second stage will be on 2025-08-01 when all support of composer 1 ends for packagist. You will only be able to
restore and existing state of your application as long as you have a composer.lock file.

.. note::

     Even after 1.x metadata access is shut down, you can still run composer install with existing lock files.
     These lock files contain all the necessary download information and don't require metadata
     from Packagist.org unless you attempt to update dependencies.


You might have seen the following message when running composer install or update:

.. important::

   Warning from https://repo.packagist.org:  Support for Composer 1 will be shutdown on August 1st 2025. You should upgrade to Composer 2.


OXID eShop Compilation metapackages from 6.0.0 to below 6.2.3 are not compatible with composer 2.
More specific, the components named oxid-esales/oxideshop-unified-namespace-generator and
oxid-esales/oxideshop-composer-plugin require the composer-plugin-api version 1.
We provide compatible branches of those components which work with both composer 1 and composer 2 to help you
switching your existing application to composer 2.

In order to switch your composer 1 OXID eShop to composer 2, you will need to prepare a custom composer.json,
then replace composer 1 with composer 2 and then verify, that the installation can be successfully run with composer 2.

Preparations
^^^^^^^^^^^^

#. Please update your system to use the highest compatible PHP version, which is PHP 7.4 for OXID eShop Compilation 6.2.2.
#. Backup your existing composer.json and composer.lock files residing in the shop's root directory.

Building a custom metapackage and switching to composer 2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Building a custom metapackage means, you first have to change your root :file:`composer.json` file from
including OXID eShop Compilation metapackages to directly including all packages currently installed.

In the following sections we explain two possibilities for assembling your custom composer.json.
Either by a script (example provided) or manually.

.. important::
   Give the installation an ample amount of test runs on a development system or at least some separate directory.
   Do not run composer update on your live system
   until proven to recreate the existing installation modulo some development requirements and packages incompatible
   with composer-plugin-api 1.

Generate composer.json by script
--------------------------------

Prepare a composer.json from the provided example script which you might have to adapt to your needs

.. literalinclude:: ./examples/convertLockToComposer.php
   :language: php

The example script automatically excludes all the packages we know to not be needed in your custom composer.json.
Script will write output into a file name `generated_composer.json` which you then need to copy or rename
as `composer.json`.

What the script is doing as well is to register all packages' repositories in the `generated_composer.json`'s
repository section. This slows down composer installation considerably but we expect this to come in handy
in case you need to update your system after 2025-08-01.
Please experiment with registering those repositories, it might be sufficient to simply use the repository section from your
original composer.json.

Alternatively assemble the composer.json manually
-------------------------------------------------

#. Create backups (cannot mention this often enough).

#. Remove all occurrences of OXID eShop metapackages (:code:`oxideshop-metapackage-*`) from the original composer.json's require section.

#. Remove all packages from require-dev section of the original composer.json (like :code:`oxid-esales/testing-library` and :code:`incenteev/composer-parameter-handler`)

#. Remove "scripts" and "extra" section from the original composer.json

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


#. Replace the :code:`"require": { ...}` section in your root :file:`composer.json` file with this content.
#. Backup your current :file:`composer.lock` file.


Update to composer 2 and verify results
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now we need to change the composer-plugin-api 1 components to a branch supporting composer 1 as well as composer 2
or immediately go the 'full way' and switch to composer 2.

.. important::
   For OXID eShop 6.2.2, please ensure the following packages are used

   .. code:: shell

       composer config repositories.oxideshop/composer_plugin git https://github.com/OXID-eSales/oxideshop_composer_plugin
       composer config repositories.oxideshop/unified-namespace-generator git https://github.com/OXID-eSales/oxideshop-unified-namespace-generator
       composer require --no-update oxid-esales/oxideshop-composer-plugin v2.0.5
       composer require --no-update oxid-esales/oxideshop-unified-namespace-generator v2.0.2

#. Run composer update:
   Please keep in mind that we expect this no longer to be possible with composer 1 after 2025-08-01.
   In that case, please first update to composer 2 (composer self-update --2) and then run composer update.

   .. code:: shell

      composer update --no-scripts --no-plugins
      composer update


#. Compare the current :file:`composer.lock` file with the one you have backed up.
   Make sure the only difference is the missing :code:`oxideshop-metapackage-*`,
   require-dev entries and the changes above mentioned packages.

#. Refer to the update section to update your Shop to the desired version.


Fetching updated packages directly from the source
--------------------------------------------------

Packages tagged after 2025-02-01 will not be delivered from packagist via composer 1.
It is possible to directly register package sources in your composer.json, you then just need to add the specific
package version that has to be required. Above mentioned script as stated already can generate that
repository section for your composer.json file.

You will need to try out, if this approach works in your specific case.

