Best practice module setup for development with composer
========================================================

There are several ways how to setup your module development environment with OXID eShop. The most common way is to
register path in project ``composer.json`` file.

1. Install module.

  .. code:: bash

     vendor/bin/oe-console oe:module:install <module sourcecode path>

2. Register module package in project ``composer.json``.

  .. code:: bash

    cd <shop_directory>
    composer config repositories.<package-name> path <module sourcecode path>
    composer require <package-name>:*

  * ``<package-name>`` - Is your module name, which is being used in ``composer.json`` file, for example "oxid-esales/module-template".

If all steps have been completed, module files will be autoloaded and you will be able to introduce
modifications to the module in ``<module sourcecode path>`` directory.

.. important::

  Autoloading could fail if the autoload directory in the module ``composer.json`` is not set to the composer vendor directory.
  Code snippet how to do this can be found :ref:`here <module_autoload-20170926>`.

More useful information about module development can be found :doc:`here <create_basic_module>`.

Dealing with other libraries
----------------------------

If your module has dependencies to other libraries they need to be registered in module ``composer.json`` file by
modifying it:

.. code:: json

    {
        "require": {
            "<package-name>": "<version>"
        }
    }

And run update command in project root directory:

.. code:: bash

  composer update
