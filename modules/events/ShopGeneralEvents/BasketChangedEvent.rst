BasketChangedEvent
==================

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BasketChangedEvent

This event will be dispatched when the basket was changed. It takes the basket component object
as a constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Application\Component\BasketComponent $basketComponent Basket component
     */
    public function __construct(\OxidEsales\Eshop\Application\Component\BasketComponent $basketComponent)
    {
        $this->basketComponent = $basketComponent;
    }

Usage example: reverse proxy (varnish) can use this event to decide if parts of cache need to be invalidated.
