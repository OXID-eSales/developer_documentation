.. _copy_module_via_composer-20170217:

Install a module with composer
==============================

OXID eShop modules are installed via Composer by using the `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

In order to install a module correctly, this plugin requires four fields to be described in module ``composer.json`` file:

- :ref:`name <module_name-20170926>`
- :ref:`type <module_type-20160524>`
- :ref:`extra <module_extra-20160524>`
- :ref:`require <module_require-20170926>`
- :ref:`autoload <module_autoload-20170926>`

**PayPal module example:**

.. code:: json

    {
        "name": "oxid-esales/paypal-module",
        "description": "This is the PayPal module for the OXID eShop.",
        "type": "oxideshop-module",
        "keywords": ["oxid", "modules", "eShop"],
        "homepage": "https://www.oxid-esales.com/en/home.html",
        "license": [
            "GPL-3.0",
            "proprietary"
        ],
        "extra": {
            "oxideshop": {
                "blacklist-filter": [
                    "documentation/**/*.*"
                ],
                "target-directory": "oe/oepaypal"
            }
        },
        "require": {
            "php": ">=5.6",
            "lib-curl": ">=7.26.0",
            "lib-openssl": ">=1.0.1",
            "ext-curl": "*",
            "ext-openssl": "*"
        },
        "autoload": {
            "psr-4": {
                "OxidEsales\\PayPalModule\\": "../../../source/modules/oe/oepaypal"
            }
        }
    }


.. _module_name-20170926:

name
------------------

This is the name the OXID eShop module will be publicly known and installable.
E.g. in our example you could type

.. code:: bash

    composer require oxid-esales/paypal-module


.. _module_type-20160524:

type
----

Module must have ``oxideshop-module`` value defined as a type.
This defines how the repository should be treated by the installer.

.. _module_extra-20160524:

extra: {oxideshop}
------------------

..  _module_target-directory-20170926:

target-directory
^^^^^^^^^^^^^^^^

``target-directory`` value will be used to create a folder inside the Shop ``modules`` directory.
This folder will be used to place all files of the module.

.. important::

  It is strongly recommended to set the target directory value to ``<vendor of the module>`` + ``<module ID>``,
  e.g. ``oe/oepaypal``.

..  _module_source-directory-20170926:

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

.. _module_require-20170926:

require
------------------

Here you must define all dependencies your module has.
You must define:

* a minimum PHP version. In the example PHP >=5.6 is required
* the required system libraries and their versions, if applicable. In the example lib-curl >=7.26.0 and lib-openssl >=1.0.1 are required
* the required PHP extension and their versions, if applicable. In the example the PHP extensions curl and openssl must be activated
* the required composer components, if applicable. In the example the are no requirements defined

.. _module_autoload-20170926:

autoload
------------------

It is necessary to define a PSR-4 compatible auto loading mechanism.
For an easier development, we recommend to use "../../../source/modules/vendorname/moduleid".
You will find more detailed development related information :ref:`here<add_dependencies_and_autoload_via_composer-20170217>`

Keep in mind, that the :ref:`target-directory <module_target-directory-20170926>` in the section extra: {oxideshop} has to fit the
autoload path you define here.
In our PayPal example the PSR-4 autoload path points to a path inside the OXID eShop source/modules directory.
This path must match the path of the :ref:`target-directory <module_target-directory-20170926>` as defined in the extra: {oxideshop}
section, as the files will be copied there.

