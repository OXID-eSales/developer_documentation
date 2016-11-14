OXID eShop installation via Composer
====================================

.. important:: Currently installation process which is described below doesn't work. This note will be removed when
   this way of installing OXID eShop will be finished.

There are multiple ways to get the OXID eShop source code, one of the simplest is to use Composer. You can find details how to install Composer `here <https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx>`_.

How to install OXID eShop compilation via Composer
--------------------------------------------------

#. Depending on OXID eShop edition run script bellow to download compilation:

   * For Community Edition:

     .. code:: bash

        composer create-project oxid-esales/oxideshop-project project_name dev-b-6.0-ce
   * For Professional Edition:

     .. code:: bash

        composer create-project oxid-esales/oxideshop-project project_name dev-b-6.0-pe

   * For Enterprise Edition:

     .. code:: bash

        composer create-project oxid-esales/oxideshop-project project_name dev-b-6.0-ee

    .. note::

      Enter credentials to access PE or EE repositories.

#. Setup web server

   The document root of your webserver should point to the `source/` directory.

#. Open web server URL and go through setup steps.

Adding 3-rd party dependencies
------------------------------

Additional dependencies should be added via same composer.json file. For example if there is a need to add runtime
library like monolog run:

.. code:: bash

   composer require monolog/monolog

If there is a need to add a development dependency like the OXID eShop testing library:

.. code:: bash

   composer require --dev oxid-esales/testing-library
