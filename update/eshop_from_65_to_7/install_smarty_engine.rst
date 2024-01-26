Switching to the legacy Smarty template engine
==============================================

If required, install the Smarty template engine.

We assume you have OXID eShop Version 7 already installed from the metapackage.

We will give an example for the Enterprise Edition.

|background|

The Smarty template engine is not part of the OXID eShop Compilation Version 7.

Nevertheless, you can install the Smarty template engine and use Smarty-compatible themes.

.. important:: We strongly recommend using the Twig template engine and Twig-compatible themes.


Building a custom metapackage
-----------------------------

We have a little shortcoming of composer with removing components via composer which are not required
by the root package. Composer cannot do that.

This means, you first have to change your root :file:`composer.json` file from including metapackages to directly including all packages currently installed.

|procedure|

.. todo: #tbd: add screenshots

1. In the OXID eShop`s root directory, run the following command:

   .. code:: shell

      composer show --locked

   All components currently installed are displayed with their exact version numbers.

#. Convert this output into :code:`composer.json` format:

   .. code:: shell

      "oxid-esales/oxideshop-ce":"v7.0.1",
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


Removing Twig and adding Smarty components
------------------------------------------

Remove Twig and add Smarty components.

|procedure|

1. Remove the Twig components:

   .. code:: shell

      composer remove --no-update --update-with-dependencies oxid-esales/twig-admin-theme
      composer remove --no-update --update-with-dependencies oxid-esales/twig-component-ee
      composer remove --no-update --update-with-dependencies oxid-esales/twig-component-pe
      composer remove --no-update --update-with-dependencies oxid-esales/twig-component
      composer remove --no-update --update-with-dependencies twig/twig

#. Ensure that the demo data is compatible with the Smarty theme:

   .. note:: In a shop installed from OXID eShop 7 metapackage, demo data for all editions will be included but only
      metadata compatible with your edition will be installable by the demodata-installer.

      Decide if and which demodata packages you wish to install.

   .. code:: shell

      composer require --no-update oxid-esales/oxideshop-demodata-ce v7.1.0
      composer require --no-update oxid-esales/oxideshop-demodata-pe v7.1.0
      composer require --no-update oxid-esales/oxideshop-demodata-ee v7.1.0

#. Prepare the Smarty template engine installation:

   .. code:: shell

      composer require --no-update oxid-esales/smarty-component v1.0.0
      composer require --no-update oxid-esales/smarty-component-pe v1.0.0
      composer require --no-update oxid-esales/smarty-component-ee v1.0.0

#. Prepare the installation of a compatible theme, Wave, for example:

   .. code:: shell

      composer require --no-update oxid-esales/smarty-admin-theme v1.0.0
      composer require --no-update oxid-esales/wave-theme v3.0.0


   The preparation is finished.

#. To install Smarty, execute the following command:

   .. code:: shell

      composer update

#. Clear the shop caches:

   .. code:: shell

      ./vendor/bin/oe-console oe:cache:clear

#. Log in to the admin backend and activate the Smarty-compatible theme (Wave, in our example).
