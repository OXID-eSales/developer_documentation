Component
=========

OXID eShop component is a simple way for a project to add reusable code to the application via composer packages.
You can write classes that have new or extended functionality and you may wire these classes together in your
composer package by using the Symfony :doc:`Service Container <service_container>`.

How it works
------------

On installation the OXID composer plugin will include your components :file:`services.yaml` file in a file
named :file:`generated_services.yaml` that is read when the DI container is assembled.
You will find this file in :file:`var/generated but you should not alter it manually`.

.. important::

    You can't overwrite the definition of services that are already defined in the container
    in your components :file:`services.yaml` file. The composer plugin will not include your
    file if you try to do this. Because if several components would override the same definition,
    It would be completely arbitrary which component would win, depending on the sequence of the installation.


Component type
--------------

It's necessary that component would have `oxideshop-component` type in `composer.json` file:

.. code:: json

    {
        //...
        "type": "oxideshop-component",
        //...
    }
