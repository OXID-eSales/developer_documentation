.. _test_module-20170217:

Testing
=======

It is recommended to write tests by using the `OXID Testing Library. <https://github.com/OXID-eSales/testing_library/>`__

The OXID Testing Library helps to test single module by:

- Adding helpers to write tests.
- Adding communication with the OXID eShop layer.
- Ensuring that tests do not affect each other due to database usage.
- Stabilizing Selenium tests.
- Testing compilation intercompatibility:
    The OXID eShop is able to use several modules simultaneously and they might interact with each other.
    The Testing Library easily runs tests for each module to check intercompatibility.


.. toctree::
    :titlesonly:
    :glob:

    *
    codeception/index
