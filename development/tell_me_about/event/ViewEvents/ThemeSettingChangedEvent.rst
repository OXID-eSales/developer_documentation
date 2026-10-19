ThemeSettingChangedEvent
========================

.. note::

    This event is deprecated and will be removed in OXID eShop 8.0, where ``ThemeConfigurationChangedEvent`` replaces it.

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Framework\Theme\Event\ThemeSettingChangedEvent

This event will be triggered when theme settings have been changed in database.

Usage example: Modules can use this event to invalidate parts of cache depending on places
affected by configuration change.
