ViewRenderedEvent
=================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\ViewRenderedEvent

This event will be dispatched after the shop has rendered the current
page for output. Before this event is sent, all processing of the current request
needs to be finished.

Usage example: reverse proxy (varnish) uses this event to set its cookies and decide if
reverse proxy functionality should be used for this response or not.
