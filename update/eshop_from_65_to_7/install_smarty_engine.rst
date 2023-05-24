Install smarty template engine
==============================

The Smarty template engine is not part of the OXID eShop Compilation Version 7. Nevertheless it is still
possible to install the smarty template engine and use smarty compatible themes.

.. important:: We strongly recommend to update to twig template engine and twig compatible themes.

This section will explain how to install smarty template engine assuming you have OXID eShop Version 7
already installed from metapackage. Example will be shown for Enterprise Edition.


Adapt root composer.json
------------------------

We have a little shortcoming of composer with removing components via composer which are not required
by root package. Composer cannot do that. Which means we first have to change our root composer.json
from including metapackages to directly include all currently installed packages.

Run the following command in shop root directory

.. code:: shell

   composer show --locked

It will show all components currently installed with exact versions.
Take this output and convert it into composer.json format

.. code:: shell

   "oxid-esales/oxideshop-ce":"v7.0.1",
   "oxid-esales/oxideshop-composer-plugin":"v7.1.0",
   "oxid-esales/oxideshop-db-views-generator":"v2.1.0",
   "oxid-esales/oxideshop-demodata-ce":"v8.0.0",
   ....

Please remove all occurences of oxideshop metapackages from this list as their requirements are already included.
Now replace  "require": { ...} section in your root composer.json with this content.
Backup your current composer.lock file.

Run composer update:

.. code:: shell

   composer update

Compare current composer.lock file with the backupped one. Only difference should be the missing
oxideshop-metapackage-* entries.


Remove twig and add smarty components
-------------------------------------

Next step is to remove the twig components

.. code:: shell

    composer remove --no-update --update-with-dependencies oxid-esales/twig-admin-theme
    composer remove --no-update --update-with-dependencies oxid-esales/twig-component-ee
    composer remove --no-update --update-with-dependencies oxid-esales/twig-component-pe
    composer remove --no-update --update-with-dependencies oxid-esales/twig-component
    composer remove --no-update --update-with-dependencies twig/twig

Ensure demodata is compatible with smarty theme:

.. code:: shell

    composer require --no-update oxid-esales/oxideshop-demodata-ce v7.1.0
    composer require --no-update oxid-esales/oxideshop-demodata-pe v7.1.0
    composer require --no-update oxid-esales/oxideshop-demodata-ee v7.1.0


Prepare installation of smarty template engine:

.. code:: shell

    composer config repositories.oxid-esales/smarty-component-pe \
            --json '{"type":"git", "url":"https://github.com/OXID-eSales/smarty-component-pe.git"}'

    composer config repositories.oxid-esales/smarty-component-ee \
            --json '{"type":"git", "url":"https://github.com/OXID-eSales/smarty-component-ee.git"}'

    composer require --no-update oxid-esales/smarty-component v1.0.0
    composer require --no-update oxid-esales/smarty-component-pe v1.0.0
    composer require --no-update oxid-esales/smarty-component-ee v1.0.0


Prepare installation of compatible themes:

.. code:: shell

    composer require --no-update oxid-esales/smarty-admin-theme v1.0.0
    composer require --no-update oxid-esales/wave-theme v3.0.0


Now that everything is prepared, please run

.. code:: shell

   composer update

Please clear the shop caches

.. code:: shell

   ./vendor/bin/oe-console oe:cache:clear

Then log in to admin backend and activate a smarty compatible theme (wave in our example).