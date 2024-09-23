Deactivation
============

by console
----------

.. _modules_deactivation_console_20240806:

To deactivate a module via :doc:`oe-console </development/tell_me_about/console>`, execute the following command:

.. code:: bash

    ./vendor/bin/oe-console oe:module:deactivate <module-id>

.. note::
    The parameter :code:`--shop-id` must be appended, if the module must be deactivated for a certain sub shop.

by administration area
----------------------

.. _modules_deactivation_administration_area_20240806:

1. Open OXID eShop administration panel and go to :menuselection:`Extensions --> Modules`.
2. Choose the module and click the :guilabel:`Deactivate` button.
