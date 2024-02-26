:orphan:
Terms, conditions and checklist
===============================


.. todo: #HR: #tbd 7.x: section needs to be updated later

General
-------

* The module certification by OXID eSales will be done for the latest version of OXID eShop.
* An existing certification is valid for the patch versions of a certified module
  (e.g. 6.0.1, 6.0.2 are patches of 6.0).
* Within the period of 24 months, one re-certification is included. (Independent of OXID provided updates). Further re-certification requests within the time period of 24 months will be charged additionally.
* The module must be re-certified when a minor version of OXID eShop is released.
* When doing the certification, OXID will not distinguish between OXID eShop editions (Community, Professional, Enterprise, B2B).

Checklist
---------

This following overview contains an overview of all conditions for developing certifiable eShop modules for OXID eShop versions
6.0 and higher. Details to the single issues will be communicated in the offered trainings and are noted in the training
materials respectively.

Software tests
^^^^^^^^^^^^^^

* One test class per module class
* ``Class MODULKLASSETest extends UnitTestCase``
* At least 1 test per method
* Demonstrative & destructive tests
* ``NO assertTrue(true)``
* Atomic tests
* ``MODULNAMETest.php`` for automatic execution of all tests
* Code coverage > 90%; classes that are pure data containers don’t include any logic (only getters and setters), can be excluded from test coverage; code coverage includes non-public methods
* Minimal disturbance of the eShop tests

Software quality
^^^^^^^^^^^^^^^^
* No globals
* No global functions
* PHP5/7 Code
* Extensions of ``Base``
* Getters & Setters
* Usage of ``StandardException``
* Maximum length of methods < 80 lines (best practice: < 40 lines)
* Maximum NPath complexity < 200
* Maximum cyclomatic complexity = 4
* Maximum C.R.A.P. index < 30
* Template extensions using blocks
* Individual language files and templates must be inside the module directory
* Database access should be master-slave compatible (only relevant for OXID eShop Enterprise Edition)

Inter-module compatibility
^^^^^^^^^^^^^^^^^^^^^^^^^^

* prefix before database field names
* prefix before table names
* prefix before config parameters
* prefix before language constants
* ``::parent`` call
* ``oxNew``
* Visibility of methods: don’t change the extended methods visibility. Visibility is public, protected or private. If you want to extend an original method, don’t change your new methods visibility from protected to public and from private to protected!

Documentation
^^^^^^^^^^^^^

* :file:`Readme.md`
* :file:`Changelog.md`
* PHPDoc
* PHP comments
* Additional documentation materials in a dedicated directory

Packaging
^^^^^^^^^

* Language files,
* templates,
* block files are inside the module directory

General terms and conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* The module can be certified for the latest version of OXID eShop.
* Patch versions of the module do not change its features.
* The tests can be executed both on OXID eShop CE and EE.
