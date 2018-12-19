Events List
===========

FinalizingModuleActivationEvent
-------------------------------

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Module\Setup\Event\FinalizingModuleActivationEvent

This event will be dispatched at the last step of the module activation for a specific shop.

Usage example: run some module database migrations.

FinalizingModuleDeactivationEvent
---------------------------------

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Module\Setup\Event\FinalizingModuleDeactivationEvent

This event will be dispatched at the last step of the module deactivation for a specific shop.

.. attention::

    Module might be still active in another shop.

Usage example: clean-up some module related data from the database.

BeforeModuleDeactivationEvent
-----------------------------

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Module\Setup\Event\BeforeModuleDeactivationEvent

This event will be dispatched right before the module deactivation for a specific shop.

.. attention::

    Module might be still active in another shop.

Usage example: clean-up some module related data from the database.