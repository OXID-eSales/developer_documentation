Available Events
================

Contract Lifecycle Events
-------------------------

These events track the payment contract through its lifecycle:

.. list-table::
   :header-rows: 1
   :widths: 35 30 35

   * - Event
     - When Fired
     - Use Case
   * - ``ContractCreatedEvent``
     - Customer initiates checkout
     - Reserve inventory
   * - ``ContractTransitionedToPendingEvent``
     - Payment process started
     - Lock basket items
   * - ``ContractReadyToCommitEvent``
     - All conditions met
     - Prepare order data
   * - ``ContractCommittedEvent``
     - Order created in shop
     - Create ERP order
   * - ``ContractFulfilledEvent``
     - Payment completed
     - Trigger fulfillment
   * - ``ContractCancelledEvent``
     - Payment cancelled
     - Release inventory
   * - ``ContractExpiredEvent``
     - Session timeout
     - Cleanup reservations
   * - ``ContractFailedEvent``
     - Payment failed
     - Log failure, notify

Payment Events
--------------

These events track payment-specific actions:

.. list-table::
   :header-rows: 1
   :widths: 35 30 35

   * - Event
     - When Fired
     - Use Case
   * - ``PaymentInitiatedEvent``
     - Customer starts payment
     - Analytics tracking
   * - ``PaymentAuthorizedEvent``
     - Payment authorized (not captured)
     - Fraud check
   * - ``PaymentCapturedEvent``
     - Funds captured
     - Ship order, sync ERP
   * - ``PaymentRefundedEvent``
     - Refund processed
     - Update CRM, restore stock
   * - ``PaymentFailedEvent``
     - Payment failed
     - Alert, retry logic
   * - ``OrderCreatedEvent``
     - Shop order created
     - Sync to external systems
   * - ``OrderCompletedEvent``
     - Order finalized
     - Send confirmation
   * - ``WebhookReceivedEvent``
     - Webhook from provider
     - Custom processing

EventContext Data Reference
---------------------------

Common data available in event context:

.. list-table::
   :header-rows: 1
   :widths: 20 15 65

   * - Key
     - Type
     - Available In
   * - ``orderId``
     - string
     - All order/payment events
   * - ``contractId``
     - string
     - All contract events
   * - ``userId``
     - string
     - All events
   * - ``amount``
     - float
     - Payment events
   * - ``currency``
     - string
     - Payment events
   * - ``refundAmount``
     - float
     - Refund events
   * - ``basketItems``
     - array
     - Contract events
   * - ``failureReason``
     - string
     - Failed events
