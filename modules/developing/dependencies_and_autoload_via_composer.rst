.. _add_dependencies_and_autoload_via_composer-20170217:

Add dependencies and autoload via composer
==========================================

**Glossary:**

- ```<shop_directory>``` - OXID eShop directory of the project.
- ```<vendor>``` - Vendor name of the module.
- ```<module-vendor/module-name> ``` - Name of the module which is registered in the composer file.
- ```<branch_name>``` - Branch name which will be used to develop the module.

Steps how to add
----------------

These steps describes how to add module dependency to OXID eShop project.

- Checkout module to the modules directory in the OXID eShop.

.. code:: bash

  cd <shop_directory>/source/modules/<vendor>
  git clone <git_path_to_module_repository> <module_id>

- Add a link from module to the Shop composer file.

.. code:: bash

  cd <shop_directory>
  composer config repositories.<module-vendor/module-name> path <shop_directory>/source/modules/<vendor><module_id>

- Install module through a composer.

.. code:: bash

  composer require <module-vendor/module-name>:*


.. Note::

  Composer will silently take other branch or release if a requirement could not be solved differently.

  For example:
    - Module has a release without requirements.
    - Current code requires dependency in the module composer file.
    - System does not meet the requirement.
    - After composer install older module without requirements will be taken by composer.

  `Disable usage of Packagist <https://getcomposer.org/doc/05-repositories.md#disabling-packagist-org>`__ to avoid this situation.

Why in this way
---------------

- Adding module to the modules directory allows to change files of the module and see changes on the fly.
- Installing though the composer will:

  - Add all the dependencies of the module to the project.
  - Register module namespace so composer autoloader could be used to load objects.

.. _namespace-20170218:

Namespace
---------

Composer autoloader is used to load classes. In order to load module classes
the module needs to register it's namespace to the modules path:

::

  "autoload": {
    "psr-4": {
      "<vendor>\\<module-name>\\": "../../../source/modules/<vendor>/<module-name>"
    }
  },

.. Note::

  Shop v6 still supports modules for Shop v5.3.
  Classes without namespaces might be registered in the module metadata file.
  `Read more in OXID Forge. <https://oxidforge.org/en/extension-metadata-file.html>`__
