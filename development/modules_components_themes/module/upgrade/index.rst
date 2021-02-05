Compatible modules with eshop version 7.0.0
===========================================

In eshop version 7.0.0, we do not copy modules files and folder from `vendor` folder to the `source/modules` directory,
therefore to make our modules compatible with it, following steps should be done:

- Metadata version:
    In version 7.0.0, we only support metadata version >= 2.0. So as the first
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