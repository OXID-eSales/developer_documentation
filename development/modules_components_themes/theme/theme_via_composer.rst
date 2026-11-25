Creating a theme installable via composer
=========================================

Install themes via Composer by using `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

To install a theme correctly, the plugin requires the :ref:`type <theme_type-20160524>` field in the
``composer.json`` file and a valid ``metadata.yaml`` file in the theme package.

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
        "minimum-stability": "dev"
    }

Activating a theme
------------------

Installing a theme via Composer does not make it the shop's active theme. Activate it
either in the admin area, or via console command:

.. code:: bash

    vendor/bin/oe-console oe:theme:activate <theme-id>

.. _theme_type-20160524:

type
----

Theme must have ``oxideshop-theme`` value defined as a type.
This defines how the repository should be treated by the installer.

Installation
------------

The shop reads theme files directly from the theme package in the ``vendor`` directory. The ``assets``
directory of the theme package is linked to ``source/out/<theme-id>``, where ``<theme-id>`` is the ``id``
from the theme's ``metadata.yaml``. A theme package without a valid ``metadata.yaml`` is skipped with a
warning.
