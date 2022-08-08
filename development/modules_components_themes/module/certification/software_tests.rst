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

    class [Class name]Test extends \OxidEsales\TestingLibrary\UnitTestCase
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

    class ModuleGeneratorFileSystemTest extends \OxidEsales\TestingLibrary\UnitTestCase
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
  `Module Certification Tools repository on GitHub <https://github.com/OXID-eSales/module_certification_tools>`__
* Use :file:`additional.inc.php` to add additional includes, helpers or startup scripts.
  The required libraries should be managed by Composer or, if not namespaced, located in the ``Libs`` directory.
* If you extend the ``OxidTestCase::setUp`` function, you should also call the parent method.
* All demodata (SQL snippets, files needed for testing) must be stored in :file:`Tests/Unit/Testdata`, for
  example, if you need some SQL before tests, it is enough to call the function:

.. code:: php

    $DbHandler = new DatabaseHandler();
    $DbHandler->import(TESTS_DIRECTORY."Unit/Testdata/DemoDataFile.sql");

Running tests, creating and reading reports
-------------------------------------------

Running tests
^^^^^^^^^^^^^

See `README file of the testing library <https://github.com/OXID-eSales/testing_library#running-tests>`__

Generating a code coverage report
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To run all the tests and generate the coverage report for the module, do the following:

1. If you use the Testing Library, switch to PHP 7.
   |br|
   Background: Due to a dependency on PHPUnit 8, the Testing Library doesn't support code coverage generation with PHP 8.
#. Ensure that all directories and files which are not part of the module in particular (3rd party libraries, for example) are excluded from testing (see :ref:`Test creation <testcreation-20180118>`).
#. To start generating the code coverage report, run :command:`vendor/bin/runtests-coverage`.
   |br|
   After the script is finished, you will find a directory named report inside the module’s tests folder (`yourmodule/tests/report`) which contains the code coverage files.



Interpreting the code metrics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Run :file:`vendor/bin/runmetrics` to generate the metrics information. Two files, :file:`metrics.xml` and
  :file:`metrics.txt` will be generated. The information needed for certification is stored in the file
  :file:`metrics.txt`.
* As a result you will get the total average ("AVG") over all classes and the averages for each class.
  No class average may be higher than the values listed below in the chapter "Software quality".

Run module tests before applying for certification
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Before sending module for certification to OXID eSales first follow these steps:

* Generate a clean setup of the OXVM (with testing tools)
* Follow the instructions (see Readme file of the OXVM) to install the desired shop version and edition.
  A clean instance will be created automatically on provision (by vagrant).
* Install your module following the instructions delivered with the module.
* Run all shop and module tests (:file:`runtests`, :file:`runtests-coverage`, :file:`runmetrics`).
* Check whether all tests are working and do not fail (prepare explanations for failing shop tests).
