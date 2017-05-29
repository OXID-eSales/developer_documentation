.. _copy_module_via_composer-20170217:

How to create a module installable via composer?
================================================

Modules are installed via Composer by using OXID `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

In order to install module correctly this plugin requires two fields to be described in module ``composer.json`` file:

- :ref:`type <module_type-20160524>`
- :ref:`extra <module_extra-20160524>`

**PayPal module example:**

.. code:: json

  {
    "name": "oxid-esales/paypal-module",
    "description": "This is PayPal module for OXID eShop.",
    "type": "oxideshop-module",
    "keywords": ["oxid", "modules", "eShop"],
    "homepage": "https://www.oxid-esales.com/en/home.html",
    "license": [
      "GPL-3.0",
      "proprietary"
    ],
    "extra": {
      "oxideshop": {
        "target-directory": "oe/oepaypal",
        "blacklist-filter": [
          "documentation/**/*.*"
        ]
      }
    }
  }

.. _module_type-20160524:

type
----

Module must have ``oxideshop-module`` value defined as a type.
This defines how the repository should be treated by the installer.

.. _module_extra-20160524:

extra: {oxideshop}
------------------

target-directory
^^^^^^^^^^^^^^^^

``target-directory`` value will be used to create a folder inside the Shop ``modules`` directory.
This folder will be used to place all files of the module.

.. important::

  It is strongly recommended to set the target directory value to ``<vendor of the module>`` + ``<module ID>``,
  e.g. ``oe/oepaypal``.

source-directory
^^^^^^^^^^^^^^^^

If ``source-directory`` is given, the value defines which directory will be used to define where the files and directories
will be picked from.
When the parameter is not given, the root directory of the module is used instead.

.. note::

  Usually this parameter should not be used if all files are placed in the module's root directory.

blacklist-filter
^^^^^^^^^^^^^^^^

If ``blacklist-filter`` is given, it will be used to filter out unwanted files
and directories while the copy from ``source-directory`` to
``target-directory`` takes place. The value of ``blacklist-filter`` must be a
list of strings where each item represents a glob filter entry and is described
as a relative path (relative to ``source-directory``).

Below is a list of **valid** entries:

* ``README.md`` - will filter one specific file ``README.md``;
* ``*.pdf`` - will filter all PDF documents from the source root directory;
* ``**/*.pdf`` - will filter all PDF documents from the source root directory
  and all of it's child directories;
* ``example/path/**/*`` - will filter all files and directories from the
  directory ``example/path``, including the given directory itself.

Below is a list of **non-valid** entries:

* ``/an/absolute/path/to/file`` - absolute paths are not allowed, only relative
  paths are accepted;
* ``some/path/`` - ambigious description of directory to filter, it's not clear
  if only the files are needed to be filtered or directories have to be included
  as well.

For the most up-to-date definition of what can be accepted as an argument,
please follow the
`tests <https://github.com/OXID-eSales/oxideshop_composer_plugin/blob/master/tests/Unit/Utilities/CopyFileManager/CopyGlobFilteredFileManagerTest.php>`_
which covers the behaviour.

