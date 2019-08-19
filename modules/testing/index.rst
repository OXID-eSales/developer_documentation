.. _test_module-20170217:

Testing
=======

It is recommended to write tests by using `OXID Testing Library. <https://github.com/OXID-eSales/testing_library/>`__

OXID Testing Library helps to test single module by:

- Adding helpers to write tests.
- Adding communication with OXID eShop layer.
- Ensuring that tests do not affect each other due to database usage.
- Stabilizing Selenium tests.
- Allows to test compilation intercompatibility:
    OXID eShop allows several modules to work at the same time and they might interact with each other.
    Testing Library allows to easily run tests for each module to check intercompatibility.


.. toctree::
    :titlesonly:
    :glob:

    *
    codeception/index
