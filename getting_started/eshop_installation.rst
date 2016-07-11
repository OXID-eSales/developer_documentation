eShop installation via composer
===============================

.. important:: Currently installation process which is described bellow doesn't work. This note will be removed when
   this way of installing OXID eShop will be finished.

There are several ways to get OXID eShop source code, one of the simplest is to use composer. Information how to install
composer you can find `here <https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx>`_.

Steps for installing OXID eShop compilation via composer
--------------------------------------------------------

#. Create a composer.json file with contents:

   #. :doc:`Composer file for CE Shop <resources/ce/composer>`
   #. :doc:`Composer file for PE Shop <resources/pe/composer>`
   #. :doc:`Composer file for EE Shop <resources/ee/composer>`

#. Run ``composer install`` to download compilation

   .. note::
      Enter credentials to access PE or EE repositories.

   .. note::
      Dist will be used instead of sources for this compilation. This is done because only Dist are available in Satis server.
      Run ``composer install --prefer-source`` if you want to take sources directly from GitHub.
      Have in mind that credentials to access private repositories will be needed.

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
