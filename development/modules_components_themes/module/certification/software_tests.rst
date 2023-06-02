Software tests
==============

Testing standards
-----------------

Edge cases
^^^^^^^^^^

You should test methods for proper input handling as well as for failure cases and for edge cases.

* What happens on correct input?
* What happens on incorrect input?
* What happens in edge cases?

Atomic tests
^^^^^^^^^^^^

Each method should be tested on its own. There shouldn’t be any dependencies between the tests. If there are, use stubs
and dependency injection. See the PHPUnit Manual: Test Doubles.

.. _testcreation-20180118:

Test creation conventions
-------------------------

Test creation for all module files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Tests must be written for all module files (frontend and admin controllers, components, models). Only third party files
can be excluded from testing (for example some API, since wrappers exist).

One test class per module class
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There should be a test class for each module class and each class should be stored in a separate file.

Assistive classes for testing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Helper classes must be stored in a separate directory or managed by `Composer`.

Test classes
^^^^^^^^^^^^

The classes should be declared as follows:

.. code:: php

    namespace VendorNamespace\ModuleName\Tests\Unit;

    class [Class name]Test extends \PHPUnit\Framework\TestCase
    {

    }

Test methods should be declared using ``test`` as a prefix with the function that shall be tested. E.g. a method named

.. code:: php

    public function testSomeFunctionName()

contains the test for a method named someFunctionName() in the tested class. By sticking to that schema it can easily be
determined which test method is responsible for testing a certain method of a module's class.

An example
^^^^^^^^^^

.. code:: php

    namespace OxidProfessionalServices\ModuleGenerator\Tests\Unit;

    class ModuleGeneratorFileSystemTest extends \PHPUnit\Framework\TestCase
    {
    }

Write at least one test per method
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For each method there should be at least one test in the test method respectively. Hint: The amount of tests for a
method should be as high as the NPath complexity. NPath complexity=7 results in 7 tests.
Tests must be written only for public methods. All protected and private methods must be tested through public methods.

Code coverage > 90 percent
^^^^^^^^^^^^^^^^^^^^^^^^^^

The code coverage has to be greater than 90%. This refers to the code coverage for Lines of Code (LOC).

Minimal disturbance of eShop tests
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your unit tests should interfere as little as possible with the shop tests. If you run all tests at once (e.g. eShop unit
tests and module unit tests afterwards), no shop test should fail. Only shop tests of methods that are overloaded by your
module(s) may fail, when a change of the return values was intended.

Directory structure
-------------------

Module directory structure
^^^^^^^^^^^^^^^^^^^^^^^^^^

The module structure basically must be like the example structure shown in the picture below. The test folder must be a
subdirectory in the module directory. Please stick to the :ref:`structure example given in modules/structure <modules_structure-20170217>`.

OXID test folder usage
^^^^^^^^^^^^^^^^^^^^^^

* Sample tests can be found in the
  `Module Template repository on GitHub <https://github.com/OXID-eSales/module-template>`__

Running tests, creating and reading reports
-------------------------------------------

Running tests
^^^^^^^^^^^^^

See :doc:`testing sections </development/testing/index>`

.. todo:  #HR: 'OXVM' is mentioned but not explained; clarify later
    Run module tests before applying for certification
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    Before sending module for certification to OXID eSales first follow these steps:
    * Generate a clean setup of the OXVM (with testing tools)
    * Follow the instructions (see Readme file of the OXVM) to install the desired shop version and edition.
      A clean instance will be created automatically on provision (by vagrant).
    * Install your module following the instructions delivered with the module.
    * Run all shop and module tests.
    * Check whether all tests are working and do not fail (prepare explanations for failing shop tests).
