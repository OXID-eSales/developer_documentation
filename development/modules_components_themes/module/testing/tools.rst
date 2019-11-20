Tools
=====

Developer Tools component
-------------------------

`The Developer Tools component <https://github.com/OXID-eSales/developer-tools/>`__ is a collection of utilities added
to assist during development stage.
Please follow the link below to find more about available commands and their usage:

    https://github.com/OXID-eSales/developer-tools

The reset-shop command
----------------------

The :code:`reset-shop` command is a part of `OXID Testing Library. <https://github.com/OXID-eSales/testing_library/>`__
It can be used to quickly retrieve a working OXID eShop installation in case the application is failing to start properly
(e.g. due to misconfiguration).

Running  :code:`reset-shop`:
    - initiates :doc:`generation of unified namespace classes</system_architecture/unified_namespace/unified_namespace_generator>`
    - resets project configuration
    - calls ShopInstaller service to:
        - clear temporary files
        - drop and re-create database
        - install initial data, demo data, etc

.. note::
    Existing multi-shop setup (applicable for EE only) after executing :code:`reset-shop` will be reverted
    to a single shop configuration.

To reset your application run:

.. code:: bash

    vendor/bin/reset-shop

.. warning::
   Developer tools usage may cause data loss and should never occur on live system.