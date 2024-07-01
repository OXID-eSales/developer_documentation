extend
======

.. note::
    Watch a short video tutorial on YouTube: `Shop Class Extensions <https://www.youtube.com/watch?v=hMClX5pAC-A>`_.

Description:
    On this place shall be defined which shop classes are extended by this module.
Type:
    associative array

Mandatory:
    no

Example
    .. code:: php

        // with namespaces
        'extend'      => [
            \OxidEsales\Eshop\Application\Model\User::class => \OxidEsales\ModuleTemplate\Model\User::class,
            \OxidEsales\Eshop\Application\Controller\StartController::class => \OxidEsales\ModuleTemplate\Controller\StartController::class
        ],

.. note::
   For namespaced classes: You should extend only OXID eShop classes within
   :ref:`Unified Namespace <modules-unified_namespaces-20170526>` (``\OxidEsales\Eshop``). If you try to extend
   e.g a class of the namespace ``\OxidEsales\EshopCommunity``, you are not able to activate the module and get a
   warning message in the OXID eShop admin.