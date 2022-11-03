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

        The following development tools have to be installed to run all OXID eShop tests:

        * `Codeception framework <https://github.com/Codeception/Codeception>`__ for Codeception tests
        * `Codeception asserts module <https://github.com/Codeception/module-asserts>`__ for Codeception test
        * `Codeception db module <https://github.com/Codeception/module-db>`__ for Codeception test
        * `Codeception file system module <https://github.com/Codeception/module-filesystem>`__ for Codeception test
        * `Codeception webdriver module <https://github.com/Codeception/module-webdriver>`__ for Codeception test
        * `OXID eShop Codeception Modules <https://github.com/oxid-esales/codeception-modules>`__ for Codeception test
        * `OXID eShop Codeception Page Objects <https://github.com/oxid-esales/codeception-page-objects>`__ for Codeception test
        * `Developer Tools component <https://github.com/Codeception/oxid-esales/developer-tools>`__ for Codeception test
        * `PHPUnit framework <https://github.com/sebastianbergmann/phpunit>`__ for unit/integration tests
        * `vfsStream <https://github.com/bovigo/vfsStream>`__ for unit/integration tests
        * `PHPUnit Prophecy <https://github.com/phpspec/prophecy-phpunit>`__ for unit/integration tests


.. toctree::
   :titlesonly:
   :glob:
   :maxdepth: 2

   unit
   integration
   acceptance
   codeception/index
