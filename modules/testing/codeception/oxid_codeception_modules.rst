.. _codeception-modules:

OXID Codeception modules and helpers
====================================

All actions and assertions that can be performed by the Actor object (``AcceptanceTester $I``) are defined in modules.
We will show later how you can extend the testing suite with your own actions by writing own Codeception modules.

To be able to use a Codeception module in a test suite it should be registered in the ``acceptance.suite.yml``.

.. code::

    modules:
        enabled:
            - \OxidEsales\Codeception\Module\Oxideshop



Currently the following `OXID's Codeception helper modules <https://github.com/OXID-eSales/codeception-modules.git/>`__
are available:

**Oxideshop Module** - This module will be used for some common actions like clean up database or clear cache.

**Database Module** - Will be used for changing configuration option values of the shop or deleting entries from the
database.

**Translator Module** - If you need to translate OXID language constants, please use this module:
``Translator::translate();``

**Context Module** - Will be used for configuration of some status on the page, like is user logged in or not.

**Fixtures Module** - During the bootstrap of the tests fixtures will be loaded and can later be used in the tests.

