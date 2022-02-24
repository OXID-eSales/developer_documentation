Development quality tools and requirements
==========================================

To ensure the quality of the developed modules and tools (next "Solution" will be used instead),
OXID eSales have several requirements for the newly created solutions code.

Main requirements
-----------------

Any new solution must fulfill the following requirements:

* PHP 7.4 and 8.0 must be supported (8.1 support is a nice to have and will be required quite soon).
* Code should be properly structured and tested.
    - Dependency injection through constructor should be preferred instead of direct/static calls to classes where possible.
    - All main functionality should be implemented as Services and accessed through DI.
    - Services should be easy to understand, splitted by small testable units.
* All files should use strict_types flag.
* Readme file should present in the root directory of a tool with detailed description of:
    - Module installation process
    - Installation of the module for development purposes
    - Instructions how to run solution tests and other tools

Code quality requirements
-------------------------

Quality is everyone's responsibility. High quality should be one of the main goals
throughout the development process.

* Tests should cover be at least 80% of the functionality.
* Correct type of tests should be used:
    - Service units tested with phpunit tests
    - More heavy, integration between the components, tested with phpunit but in separate directory
    - Frontend workflow chains are tested with acceptance framework
* Code C.R.A.P Index is under 30.
* Methods cyclomatic complexity is under 10.

Tools requirements
------------------

Every solution should have easy to run, preconfigured, quality tools as dev dependencies.
We strongly suggest using these:

* The CodeSniffer with PSR-12 standard (https://github.com/squizlabs/PHP_CodeSniffer)
* PHP Mess Detector (https://phpmd.org/)
* One of static analizers, like Psalm or Phpstan:
    - Phpstan minimum of level 5 or Higher
    - Psalm level 4 or Lower

Other nice to have points
-------------------------

There are quite a lot of great tools available for us nowadays, and OXID eSales would be happy to see
them used and publicly available for other developers (those who works with and develops the solution).

* Sonarcloud as a final report point for psalm issues, coverage reports, code duplications analisys.
* Github actions with all required tools integrated and running constantly during development.


Development process
-------------------

* All new code should go through the review process of another team member.
* The TDD principle should be followed during the development.
