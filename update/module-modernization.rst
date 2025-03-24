Module Modernization
====================

This document describes how to prepare your modules for the OXID eShop 8.0 update by modernizing them.
While these steps are optional, modernizing your modules before the update is recommended for
better compatibility and maintainability.

Prerequisites
-------------

Ensure you have installed the :doc:`OXID Update Component <update-component>`.

Using the Refactoring Command
-----------------------------

Before updating to OXID eShop 8.0, you can use the refactoring command to improve your module's code quality:

.. code:: bash

    bin/oe-console oe:update:refactor-module {module-path} [options]

Available options:

* ``--import-names``: Import names and remove unused imports
* ``--type-coverage-level``: Set type coverage level (0-50)
* ``--dead-code-level``: Set dead code level (0-50)
* ``--code-quality-level``: Set code quality level (0-50)
* ``--sets``: Enable prepared sets (multiple values allowed):
    * deadCode
    * codeQuality
    * codingStyle
    * naming
    * typeDeclarations
    * earlyReturn
    * strictBooleans
    * privatization

.. note::
    For more detailed information about levels and sets, please refer to the Rector documentation:

    * Levels: https://getrector.com/documentation/levels
    * Set Lists: https://getrector.com/documentation/set-lists

Recommended Steps Before Update
-------------------------------

1. Start with type declarations (improves compatibility with PHP 8.x):

   .. code:: bash

       bin/oe-console oe:update:refactor-module source/modules/mymodule --type-coverage-level=0

2. Add code quality improvements:

   .. code:: bash

       bin/oe-console oe:update:refactor-module source/modules/mymodule --code-quality-level=0

3. Remove dead code:

   .. code:: bash

       bin/oe-console oe:update:refactor-module source/modules/mymodule --dead-code-level=0

4. Apply specific sets:

   .. code:: bash

       bin/oe-console oe:update:refactor-module source/modules/mymodule --sets typeDeclarations --sets codingStyle

Best Practices
--------------

* Apply changes one level at a time
* Create separate branches for each modernization step
* Test thoroughly after each step
* Keep changes small and focused

After completing these modernization steps, proceed with the :doc:`update to OXID eShop 8.0 <update-to-8-0>`.
