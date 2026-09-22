ThemeConfigurationChangedEvent
==============================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Theme\Configuration\Event\ThemeConfigurationChangedEvent

This event is dispatched whenever a theme's YAML configuration is written or deleted for
a shop, for example when a theme package is installed or uninstalled, when the theme
settings are saved in the admin area, and (Enterprise Edition) when a new subshop is created.

The shop itself listens for this event to evict the resolved theme configuration cache
and clear the cache of that one shop (not the whole installation, in a multishop setup).
The Twig component also listens for it to invalidate the template chain cache.
