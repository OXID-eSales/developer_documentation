Best practice module development with composer
==============================================

There are several ways how to setup your module development environment with OXID eShop. The most common way is to
clone your composer module repository directly to the ``source/modules`` folder and register the namespace.
Like this all changes to your module will take place immediately.

- Checkout module to the modules directory in the OXID eShop.

.. code:: bash

  cd <shop_directory>/source/modules/<vendor>
  git clone <git_path_to_module_repository> <module_id>

- Register the namespace to the shop composer file.

::

    "autoload": {
        "psr-4": {
            "<namespace>": "./source/modules/<vendor>/<module_id>"
        }
    }


- Update the autoloader

.. code:: bash

  composer dump-autoload