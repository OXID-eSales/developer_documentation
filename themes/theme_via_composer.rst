How to create a theme installable via composer?
===============================================

Themes are installed via Composer by using `OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

In order to install theme correctly this plugin requires two fields to be described in theme ``composer.json`` file:

- :ref:`type <theme_type-20160524>`
- :ref:`extra <theme_extra-20160524>`

**Flow theme example:**

.. code:: json

    {
       "name": "oxid-esales/flow-theme",
       "description": "This is Flow theme for OXID eShop.",
       "type": "oxideshop-theme",
       "keywords": ["oxid", "themes", "eShop"],
       "homepage": "https://www.oxid-esales.com/en/home.html",
       "license": [
           "GPL-3.0",
           "proprietary"
       ],
       "extra": {
         "oxideshop": {
           "target-directory": "flow",
           "assets-directory": "out/flow"
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
