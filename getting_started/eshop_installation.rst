eShop installation via composer
===============================

There are several ways to get OXID eShop source code, one of the simplest is to use composer. Information how to install
composer you can find `here <https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx>`_.

Steps for installing OXID eShop compilation via composer
--------------------------------------------------------

#. Create a composer.json file with contents:

   .. code:: json

      {
        "name": "vendor-name/oxideshop-compilation",
        "type": "project",
        "minimum-stability": "dev",
        "prefer-stable": true,
        "repositories": {
          "oxid-esales/oxideshop-metapackage-ce": {
            "type": "vcs",
            "url": "https://github.com/OXID-eSales/oxideshop_metapackage_ce"
          },
          "oxid-esales/oxideshop-composer-plugin": {
            "type": "vcs",
            "url": "https://github.com/OXID-eSales/oxideshop_composer_plugin"
          }
        },
        "config": {
          "vendor-dir": "source/vendor"
        },
        "require": {
          "oxid-esales/oxideshop-metapackage-ce": "*"
        }
      }

#. Setup web server

   OXID eShop document root is under `source/`, so define it in web configuration.

#. Open web server URL and go though setup steps.

Adding 3-rd party dependencies
------------------------------

Additional dependencies should be added via same composer.json file. For example if there is a need to add runtime
library like monolog run:

.. code:: bash

   composer require monolog/monolog

If there is a need to add development dependency like OXID eShop testing library:

.. code:: bash

   composer require --dev oxid-esales/testing-library