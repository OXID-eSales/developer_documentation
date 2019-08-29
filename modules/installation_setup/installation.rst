Installation
============

This section describes module installation process in OXID eShop.

Installing module
-----------------

There are 2 ways of :ref:`installing <glossary-installation>` a module:

#. Composer installation
#. Manual installation

.. uml::

    @startuml
        start
        if (How?) then (Manual installation\ncopy/clone files\nmanually)
          :Copy/clone module files;
          :Execute installation command;
        else (Composer installation)
          :Execute composer installation;
        endif
          :Module installed;
        stop
    @enduml

Composer installation
^^^^^^^^^^^^^^^^^^^^^

Module can be installed with regular composer installation. Composer performs all necessary installation steps.
Example command how to install OXID eShop PayPal module with composer:

.. code:: bash

    composer require oxid-esales/paypal-module

Manual installation
^^^^^^^^^^^^^^^^^^^

Manual installation is another way of installing a module, which usually is used for module development.
The steps can be found in document: :doc:`best practice module setup for development </modules/best_practices/module_setup>`.

