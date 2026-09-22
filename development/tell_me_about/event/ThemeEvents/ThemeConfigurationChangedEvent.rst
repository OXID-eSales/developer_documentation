ThemeConfigurationChangedEvent
===============================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Theme\Event\ThemeConfigurationChangedEvent

This event is dispatched whenever a theme's YAML configuration is written or deleted for
a shop — on installation, on a settings save, and as a side effect of activating another
theme.

The shop itself listens for this event to evict the resolved theme configuration cache
and clear the cache of that one shop (not the whole installation, in a multishop setup).
The Twig component also listens for it to invalidate the template chain cache.
