Best practice module setup for development with composer
========================================================

There are several ways how to setup your module development environment with OXID eShop. The most common way is to
clone your module repository directly to the ``source/modules`` directory and register path in project ``composer.json``
file. Like this all changes to your module will take place immediately.

1. Checkout module to the modules directory in the OXID eShop.

  .. code:: bash

    cd <shop_directory>/source/modules/<module-vendor>
    git clone <git-url-to-module-repository> <module-name>


  * ``<module-vendor>`` - Is your module vendor, for example "oe".
  * ``<module-name>`` - Is your module name, for example "oeloggerdemo".
  * ``<git-url-to-module-repository>`` - Is your module git URL, for example "https://github.com/OXID-eSales/logger-demo-module.git".

2. Install module configuration.

  .. code:: bash

    oe:module:install-configuration source/modules/<module-vendor>/<module-name>

3. Register module package in project ``composer.json``.

  .. code:: bash

    cd <shop_directory>
    composer config repositories.<package-name> path source/modules/<module-vendor>/<module-name>
    composer require <package-name>:*

  * ``<package-name>`` - Is your module name, which is being used in ``composer.json`` file, for example "oxid-esales/logger-demo-module".

.. danger::

  In case you'll be asked if you want to overwrite this module files, you need to select "No" for an answer, otherwise all files
  will be corrupted.

If all steps have been completed, module files will be autoloaded and you will be able to introduce
modifications to the module in ``source/modules/<module-vendor>/<module-name>`` directory.

.. important::

  Autoloading could fail if the autoload directory in the module ``composer.json`` is not set to the module directory, but
  composer vendor directory. Code snippet how to do this can be found :ref:`here <module_autoload-20170926>`.

More useful information about module development can be found :doc:`here <create_basic_module>`.

Dealing with other libraries
----------------------------

If your module has dependencies to other libraries they need to be registered in module ``composer.json`` file by
modifying it:

.. code:: json

    "require": {
        "<package-name>": "<version>"
    }

And run update command in project root directory:

.. code:: bash

  composer update
