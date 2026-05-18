ClearShopCacheEvent
===================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Cache\Event\ClearShopCacheEvent

This event is dispatched when the shop cache is cleared, for example
through ``./vendor/bin/oe-console oe:cache:clear`` or any other caller
of ``ShopCacheFacade::clear()`` / ``ShopCacheFacade::clearAll()``. When
``clearAll()`` is used, the event is dispatched once per shop ID.

The event carries the affected shop ID via ``getShopId(): int``.

Usage example: a module that maintains its own cache layer can
subscribe to this event and invalidate its caches in sync with the
core shop cache, so the two never drift apart.
