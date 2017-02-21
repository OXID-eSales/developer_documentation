.. _modules_structure-20170217:

Module Structure
================

Module structure in OXID eShop
------------------------------

All modules exist in the OXID eShop modules directory.

To separate modules it is:
  - **Recommended** to group them by unique **vendor**.
  - **Required** to give them unique id.
  - **Required** to store module files in a directory with a name equal to **module_id**.

So the final structure of a module should be:

.. code::

  .
  └── source
      └── modules
          └── <vendor>
              └── <module_id>
                  ├── composer.json
                  ├── Controller
                  ├── metadata.php
                  ├── Model
                  ├── README.md
                  ├── ...
                  └── tests

Module structure in module repository
-------------------------------------

In the repository it is recommended to keep module files without vendor or module directory.
This allows to clone and use module directly in OXID eShop modules directory.
Possible structure of the module in the repository:

.. code::

  .
  ├── composer.json
  ├── Controller
  ├── metadata.php
  ├── Model
  ├── README.md
  ├── ...
  └── tests


Module transformation
---------------------

:ref:`OXID Composer Plugin<copy_module_via_composer-20170217>` could be used in order to to create vendor and module_id directories
