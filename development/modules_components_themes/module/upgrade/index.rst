Compatible modules with eshop version 7.0-rc.1
==============================================

In eshop version 7.0-rc.1, we do not copy modules files and folder from `vendor` folder to the `source/modules` directory,
therefore to make our modules compatible with it, following steps should be done:

- Metadata version:
    In version 7.0-rc.1, we only support metadata version >= 2.0. So as the first
    step we should change our metadata structure to use the proper version.

    :ref:`More information <metadata_version2-20170427>`

- Namespaced classes:
    We do not support `not namespaced classes`. So as the next step,
    the module should be refactored to use only namespaced classes.

    :ref:`More information <autoloading-of-classes-20170427>`

- Entry points:
    If the module has entry points (direct calls to php files),
    it should be refactored to use controllers instead.

    :ref:`More information <module-controllers-20170427>`

- Module templates path:
    Paths for module templates in the metadata.php should be
    changed to be relative to the module root directory.

    :ref:`More information <module-templates-20170427>`

- Composer autoloader:
    Composer autoloader in composer.json should be refactored
    to point to the module root directory in vendor

    :ref:`More information <copy_module_via_composer-20170217>`

- Assets:
    Assets should be copied to <module-root-directory>/assets folder.
    If you keep the directory structure of your assert it should work without additional effort.
    For example if you have <module-root-directory>/out/js/my.js and move to <module-root-directory>/assets/out/js/my.js

    :ref:`More information <modules_structure-20170217>`

- Module thumbnails:
    Module thumbnail should be copied also to the `assets` directory (<module-root-directory>/assets)

    :ref:`More information <modules_structure-20170217>`

- Composer.json:
    `blacklist-filter`, `target-directory`, and `source-directory` should be removed from composer.json

    :ref:`More information <copy_module_via_composer-20170217>`

- Rename the underscore method by removing their prefix underscore

Based on the psr-12 (`more info <https://www.php-fig.org/psr/psr-12>`__), method names MUST NOT be
prefixed with a single underscore to indicate protected or private visibility.
That is, an underscore prefix explicitly has no meaning.

In the shop, we have already renamed all the underscore methods by removing their prefix underscore.
This step has to be done for modules as well, because if there is any call for the shop underscore methods,
they will not work anymore. On the other hand, the modules underscore methods should be
also renamed to make them compatible with psr-12.

It can be done either manually or via rector which helps us to do it faster.
We already have provided a rector for this purpose and it can be run with the following steps:

- Update composer with adding ``rector/rector`` package:

.. code::

    "require-dev": {
        "rector/rector": "dev-master"
    },
    "repositories": {
        "rector/rector": {
            "type": "vcs",
            "url": "https://github.com/OXID-eSales/rector"
        }
    }

- Renaming underscore methods:

.. code::

    # e.g. for oxid-esales/paypal-module
    cp vendor/rector/rector/templates/oxidEsales/oxid_V7_underscored_methods_renamer_rector.php.dist  ./rector.php && sed -i 's/MODULE_VENDOR_PATH/oxid-esales\/paypal-module/g' rector.php && vendor/bin/rector process
