.. _copy_module_via_composer-20170217:

Composer.json for an OXID eShop Module
======================================

OXID eShop modules with :doc:`metadata version greater 2.0 </development/modules_components_themes/module/skeleton/metadataphp/index>` are installed via Composer by using the
`OXID eShop Composer Plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__.

In order to install a module correctly, this plugin requires four fields to be described in module ``composer.json`` file:

- :ref:`name <module_name-20170926>`
- :ref:`type <module_type-20160524>`
- :ref:`require <module_require-20170926>`
- :ref:`autoload <module_autoload-20170926>`

.. todo: #Support/#Igor: provide up-to-date example; decide how urgent it is;  needs to be updated (theroretical module instead of PayPal, symfony 6)

**PayPal module example:**

.. code:: json

    {
        "name": "oxid-esales/paypal-module",
        "description": "This is the PayPal module for the OXID eShop.",
        "type": "oxideshop-module",
        "keywords": ["oxid", "modules", "eShop"],
        "homepage": "https://www.oxid-esales.com/en/home.html",
        "license": [
            "GPL-3.0-only",
            "proprietary"
        ],
        "require": {
            "php": ">=8.0",
            "ext-curl": "*",
            "ext-openssl": "*",
            "symfony/dotenv": "^5.1"
        },
        "autoload": {
            "psr-4": {
                "OxidEsales\\PayPalModule\\": ""
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

.. _module_require-20170926:

require
------------------

Here you must define all dependencies your module has.
You must define:

* a minimum PHP version. In the example PHP >=8.0 is required
* the required PHP extension and their versions, if applicable. In the example the PHP extensions curl and openssl must be activated
* the required composer components, if applicable. In the example the are no requirements defined



.. _module_autoload-20170926:

Autoload
--------

Composer autoloader is used to load classes. In order to load module classes
the module needs to register it's namespace to the root module path:

::

  "autoload": {
    "psr-4": {
      "<vendor>\\<module-name>\\": ""
    }
  },
