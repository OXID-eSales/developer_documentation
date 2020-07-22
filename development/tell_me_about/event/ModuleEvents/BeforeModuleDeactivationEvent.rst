BeforeModuleDeactivationEvent
==============================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Event\BeforeModuleDeactivationEvent

This event will be dispatched right before the module deactivation for a specific shop.

.. attention::

    Module might be still active in another shop. only in this specific shop, module is deactivated.

Usage example: clean-up some module related data from the database.
