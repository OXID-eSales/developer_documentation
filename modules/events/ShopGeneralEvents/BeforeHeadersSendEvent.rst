BeforeHeadersSendEvent
=======================

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeHeadersSendEvent

This event will be dispatched before the shop sends the headers.
The event takes the shopcontrol and current view object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\ShopControl               $shopControl ShopControl object
     * @param \OxidEsales\Eshop\Core\Controller\BaseController $controller  Controller
     */
    public function __construct(
        \OxidEsales\Eshop\Core\ShopControl $shopControl,
        \OxidEsales\Eshop\Core\Controller\BaseController $controller
    ) {
        $this->shopControl = $shopControl;
        $this->controller = $controller;
    }

NOTE: modules should only register headers in

.. code-block:: php

    \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Core\Header::class);

but leave actual sending of headers to shop.

Usage example: reverse proxy (varnish) uses this event to set its cookies and decide if
reverse proxy functionality should be used for this response or not.