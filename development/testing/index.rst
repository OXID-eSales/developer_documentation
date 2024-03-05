
.. _testing-20221123:

Testing
=======

Automated tests are an essential part of ongoing development in large projects. There are many types of automated tests
and definitions often differ from project to project. In OXID, the following definitions are used:

 - Unit tests
 - Integration tests
 - Acceptance tests

OXID uses few standard testing frameworks:

 - PHPUnit for unit and integration testing
 - Codeception for acceptance testing


.. note::

        The following development tools have to be installed to run OXID eShop tests:

        * `Developer Tools component <https://github.com/OXID-eSales/developer-tools>`__
        * For unit/integration tests
            * `PHPUnit framework <https://github.com/sebastianbergmann/phpunit>`__
            * `Prophecy <https://github.com/phpspec/prophecy-phpunit>`__
            * `vfsStream <https://github.com/bovigo/vfsStream>`__
        * For Codeception tests
            * `Codeception framework <https://github.com/Codeception/Codeception>`__
            * `Codeception Module Asserts <https://github.com/Codeception/module-asserts>`__
            * `Codeception Module DB <https://github.com/Codeception/module-db>`__
            * `Codeception Module Filesystem <https://github.com/Codeception/module-filesystem>`__
            * `Codeception Module WebDriver <https://github.com/Codeception/module-webdriver>`__
            * `OXID eShop Codeception Modules <https://github.com/oxid-esales/codeception-modules>`__
            * `OXID eShop Codeception Page Objects <https://github.com/oxid-esales/codeception-page-objects>`__



.. toctree::
   :titlesonly:
   :glob:
   :maxdepth: 1

   unit
   integration
   acceptance
   codeception/index
