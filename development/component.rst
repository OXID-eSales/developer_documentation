OXID eShop Component
====================

OXID eShop component is a simple way for a project to add reusable code to the application via composer packages.
You can write classes that have new or extended functionality and you may wire these classes together in your
composer package :doc:`by using the Service Container </development/service_container>`.

In contrast to modules, components do not need to be activated but just installed by composer.

How it works
------------

On installation the OXID composer plugin will include your components :file:`services.yaml` file in a file
named :file:`generated_services.yaml` that is read when the DI container is assembled.
You will find this file in :file:`var/generated` but you should not alter it manually.


Component type
--------------

It's necessary that component would have `oxideshop-component` type in `composer.json` file:

.. code:: json

    {
        //...
        "type": "oxideshop-component",
        //...
    }
