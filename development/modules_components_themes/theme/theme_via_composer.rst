Creating a theme installable via composer
=========================================

Install themes via Composer by using `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

To install theme correctly, this plugin requires two fields to be described in the ``composer.json`` file:

- :ref:`type <theme_type-20160524>`
- :ref:`extra <theme_extra-20160524>`

**Apex theme example**

.. code:: json

    {
        "name": "oxid-esales/apex-theme",
        "description": "APEX Theme",
        "license": [
            "proprietary"
        ],
        "type": "oxideshop-theme",
        "keywords": [
            "oxid",
            "themes",
            "eShop"
        ],
        "authors": [
            {
                "name": "Tino Favetto, c&c concepts and creations GmbH"
            }
        ],
        "homepage": "https://github.com/OXID-eSales/apex-theme",
        "require": {
            "php": ">=8.0",
            "oxid-esales/twig-component": "*"
        },
        "minimum-stability": "dev",
        "extra": {
            "oxideshop": {
                "assets-directory": "out/apex",
                "blacklist-filter": [
                    "build/**/*",
                    "grunt/**/*",
                    ".gitignore",
                    "CHANGELOG.md",
                    "composer.json",
                    "Gruntfile.js",
                    "package.json"
                ],
                "target-directory": "apex"
            }
        }
    }

.. _theme_type-20160524:

type
----

Theme must have ``oxideshop-theme`` value defined as a type.
This defines how the repository should be treated by the installer.

.. _theme_extra-20160524:

extra: {oxideshop}
------------------

target-directory
^^^^^^^^^^^^^^^^

``target-director`` value will be used to create a folder inside the Shop ``Application/views`` directory.
This folder will be used to place all files of the module.

assets-directory
^^^^^^^^^^^^^^^^

Defines where public resources like ``css, js, images`` are placed inside the theme.
The plugin will copy those files to the Shop ``out`` directory.

.. note:: It is recommended to keep assets in out directory at a root level of the repository.

blacklist-filter
^^^^^^^^^^^^^^^^

If ``blacklist-filter`` is given, it will be used to filter out unwanted files and directories while the copying to
``target-directory`` takes place.
The value of ``blacklist-filter`` must be a list of strings where each item represents a glob filter entry and is
described as a relative path.

Below is a list of **valid** entries:

* ``README.md`` - will filter files and directories named ``README.md`` from root and all the subdirectories;
* ``*.pdf`` - will filter all PDF files and also directories which have ``pdf`` at the end of their name from root and all the subdirectories;
* ``docs`` - will filter files and directories named ``docs`` from root and all the subdirectories;
* ``docs/dir`` - will filter file or directory named ``dir`` from ``docs`` directory;
* ``docs/dir/test.txt`` - will filter file or directory named ``test.txt`` from ``docs/dir`` directory.

Below is a list of **non-valid** entries:

* ``/an/absolute/path`` - absolute paths are not allowed, only relative paths are accepted;
* ``some/path/`` - ambiguous description of directory to filter, it's not clear if only the files are needed to be filtered or directories have to be included as well;
* ``docs/*.txt`` - using wildcard character * within subdirectories is not allowed.
