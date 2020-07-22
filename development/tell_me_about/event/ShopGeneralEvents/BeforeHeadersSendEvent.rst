BeforeHeadersSendEvent
=======================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\BeforeHeadersSendEvent

This event will be dispatched before the shop sends the headers.

.. Note::
 modules should only register headers in

.. code-block:: php

    \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Core\Header::class);

but leave actual sending of headers to shop.

Usage example: reverse proxy (varnish) uses this event to set its cookies and decide if
reverse proxy functionality should be used for this response or not.
