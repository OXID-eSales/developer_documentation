OXID eShop installation via Composer
====================================

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

   .. note::

      When installing PE and EE dist will be used instead of sources for this compilation. This is done because only Dist are available in Satis server.
      Run ``composer install --prefer-source`` if you want to take sources directly from GitHub.
      Have in mind that credentials to access private repositories will be needed.

#. Setup web server

   The document root of your webserver should point to the `source/` directory.

#. Change files permissions.

   Those and subdirectories must be writable all the time:

      * ./source/out/pictures/ (including files, which are inside this directory)
      * ./source/out/media/
      * ./source/log/
      * ./source/tmp/

   During installation those must be writable

      * ./source/config.inc.php
      * ./source/.htaccess

   After installation those must be read-only

      * ./source/config.inc.php
      * ./source/.htaccess

   and set the export dir to writable

      * ./source/export

   .. note::

      For development purposes, easiest way to add permissions, is to run this command:

      .. code:: bash

         sudo chmod 777 -R source/config.inc.php source/.htaccess source/tmp/ source/log/ source/out/pictures/ source/out/media/ source/export

#. Open web server URL and go through setup steps.

Adding 3-rd party dependencies
------------------------------

Additional dependencies should be added via same composer.json file. For example if there is a need to add runtime
library like monolog run:

.. code:: bash

   composer require monolog/monolog

If there is a need to add a development dependency like the OXID eShop testing library:

.. code:: bash

   composer require oxid-esales/testing-library:dev-master --dev
   
In case you would get conflicts because of already installed dependencies, it's possible to add additional dependency without installing it and later on run update command:

.. code:: bash

   composer require oxid-esales/testing-library:dev-master --dev --no-update
   composer update

Change versions of already existing components
----------------------------------------------

Metapackage defines with which exact version of dependency was the Shop tested.
Having same version in project ensure that Shop always works as predicted.
Sometimes one needs to change dependency.
To do that add alias in the project composer file to the needed version as it is in example:

.. code:: bash

    {
        "require": {
            "doctrine/cache":"v1.6.0 as v1.6.1"
        }
    }

This lowers doctrine cache version to v1.6.0 even while metapackage require v1.6.1.

To read more check `the documentation <https://getcomposer.org/doc/articles/aliases.md#require-inline-alias>`__
or `this issue in GitHub <https://github.com/composer/composer/issues/3387>`__

Building your own metapackage
-----------------------------

Metapackage is a composer file which contains information about dependencies between components.
One can create it's own metapackage for two reasons:

**To change predefined dependencies:**

* Create new metapackage by using existing one as a template
* Define needed components together with their versions

  * Define different version of existing component
  * Remove default component
  * Add new component

**To add new dependencies to compilation:**

* Create new metapackage
* Require new dependencies
* Require existing metapackage

Make this new metapackage available through
`Packagist <https://getcomposer.org/doc/05-repositories.md#packages>`__,
`GitHub <https://getcomposer.org/doc/05-repositories.md#vcs>`__,
`file system <https://getcomposer.org/doc/05-repositories.md#path>`__
or `any other supported way <https://getcomposer.org/doc/05-repositories.md#git-alternatives>`__.
Edit existing composer.json by adding requirement to your metapackage instead of default one.

.. NOTE::

   Leave Satis repository if you use Professional or Enterprise version.
