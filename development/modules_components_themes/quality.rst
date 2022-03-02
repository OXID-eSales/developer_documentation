Development quality tools and requirements
==========================================

To ensure the quality of the developed modules and tools (next "Solution" will be used instead),
OXID eSales have several requirements for the newly created solutions code.

Main requirements
-----------------

Any new solution must fulfill the following requirements:

* All PHP version, listed for the used eShop version should be supported.
* Code should be properly structured and tested.
    - Dependency injection through constructor should be preferred instead of direct/static calls to classes where possible.
    - All main functionality should be implemented as Services and accessed through DI.
    - Services should be easy to understand, splitted by small testable units.
* All files should use strict_types flag.
* Readme file should present in the root directory of a tool with detailed description of:
    - Module installation process
    - Installation of the module for development purposes
    - Instructions how to run solution tests and other tools

Extending and reusing the shop functionality
--------------------------------------------

There are several main requirements to shop extended classes and shop method used:

* Hook to shop events in place of direct extension if possible.
* Extended shop/module classes should be calling parent methods to not destroy a module chain.
* Deprecated methods should not be used.

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
* Commit messages should be informative.

Commit messages
^^^^^^^^^^^^^^^

Commit messages should describe the changes done in the commit:

    * 1st line: story or task id / bug id / both ids + short title (title of commit, NOT task)
    * 2nd line: Empty line
    * 3rd and further lines: Detailed description of commit, intention of commit.
    * Try to keep within 80 chars width (git console friendly)

Possible good examples:

    * ESDEV-1111 Fix the issue of tracking system (Id of task is used in this example)
    * 0001243 Update tracking system logic (Id of bug is used in this example)
    * ESDEV-1111 0001243 Fix the issue of tracking system (In case this is a task for fixing a bug that has known id)