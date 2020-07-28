AllCookiesRemovedEvent
======================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\AllCookiesRemovedEvent

This event will be dispatched after the shop called the cookie removal method. For example in case of cookie note decline,
shop has to remove all cookies.

Usage example: reverse proxy (varnish) can use this event to remove module specific cookies as well.
