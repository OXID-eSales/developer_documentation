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
           "target-directory": "oe/oepaypal"
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

.. note:: It is strongly recommended to use same target directory value as ID plus vendor of the module.
