SettingChangedEvent
===================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Module\Setting\Event\SettingChangedEvent

This event will be triggered when shop module settings have been changed in database.

Usage example: reverse proxy (varnish) can use this event to invalidate parts of cache depending on places
affected by configuration change.
