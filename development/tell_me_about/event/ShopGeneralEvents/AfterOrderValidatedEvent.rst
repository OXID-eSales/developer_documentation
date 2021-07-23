AfterOrderValidatedEvent
========================

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Transition\ShopEvents

This event will be dispatched after passing successfully validation in Order model.
Event subscribers can extend validation process with additional rules.
Event passes back to model values of additional validation status (valid/invalid)
and code of validation status (see `\OxidEsales\Eshop\Application\Model\Order::ORDER_STATE_OK` etc. for details)

.. note::
    Event propagation for this event is stopped as soon as validation fails in one of its subscribers.

Usage example: performing validation of custom Order fields.
