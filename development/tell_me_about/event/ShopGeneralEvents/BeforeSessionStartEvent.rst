BeforeSessionStartEvent
=======================

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeSessionStartEvent

This event will be dispatched by shop to inform services that session is about to be started.

Usage example: reverse proxy (varnish) can use this event to set the required session cache limiter.