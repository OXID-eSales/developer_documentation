ThemeActivatedEvent
=====================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Theme\Event\ThemeActivatedEvent

This event is dispatched after a theme is activated for a shop.

The shop itself listens for this event to evict the resolved theme configuration cache
and clear the cache of that one shop (not the whole installation, in a multishop setup).
The Twig component also listens for it to invalidate the template chain cache.
