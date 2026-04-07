Integration Examples
====================

ERP Order Export
----------------

Automatically export orders to your ERP when payment is captured:

.. code-block:: php

   <?php

   namespace YourCompany\ERPConnector\EventHandler;

   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\PaymentCapturedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Handler\EventHandlerInterface;
   use Psr\Log\LoggerInterface;

   class ERPOrderExportHandler implements EventHandlerInterface
   {
       public function __construct(
           private ERPApiClient $erpClient,
           private LoggerInterface $logger
       ) {}

       public function supports(object $event): bool
       {
           return $event instanceof PaymentCapturedEvent;
       }

       public function handle(object $event): void
       {
           if (!$event instanceof PaymentCapturedEvent) {
               return;
           }

           $context = $event->getContext();
           $orderId = $context->get('orderId');
           $amount = $context->get('amount');
           $currency = $context->get('currency');

           try {
               $erpOrderId = $this->erpClient->createOrder([
                   'external_id' => $orderId,
                   'amount' => $amount,
                   'currency' => $currency,
                   'status' => 'PAID',
                   'captured_at' => date('c'),
               ]);

               $this->logger->info('Order exported to ERP', [
                   'oxid_order_id' => $orderId,
                   'erp_order_id' => $erpOrderId,
               ]);

           } catch (\Throwable $e) {
               $this->logger->error('ERP export failed', [
                   'order_id' => $orderId,
                   'error' => $e->getMessage(),
               ]);
               // Don't rethrow - let other handlers continue
           }
       }
   }

CRM Customer Sync
-----------------

Sync customer data to CRM when an order is created:

.. code-block:: php

   <?php

   namespace YourCompany\CRMSync\EventHandler;

   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\OrderCreatedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Handler\EventHandlerInterface;

   class CRMCustomerSyncHandler implements EventHandlerInterface
   {
       public function __construct(
           private CRMApiClient $crmClient,
           private CustomerRepository $customerRepo
       ) {}

       public function supports(object $event): bool
       {
           return $event instanceof OrderCreatedEvent;
       }

       public function handle(object $event): void
       {
           if (!$event instanceof OrderCreatedEvent) {
               return;
           }

           $context = $event->getContext();
           $userId = $context->get('userId');
           $orderId = $context->get('orderId');

           $customer = $this->customerRepo->getById($userId);

           $this->crmClient->upsertCustomer([
               'email' => $customer->getEmail(),
               'name' => $customer->getFullName(),
               'last_order_id' => $orderId,
               'last_order_date' => date('c'),
               'total_orders' => $customer->getOrderCount() + 1,
           ]);
       }
   }

Shipping Fulfillment Trigger
-----------------------------

Trigger shipping fulfillment when payment is captured:

.. code-block:: php

   <?php

   namespace YourCompany\ShippingModule\EventHandler;

   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\PaymentCapturedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Handler\EventHandlerInterface;

   class ShippingFulfillmentHandler implements EventHandlerInterface
   {
       public function __construct(
           private ShippingApiClient $shippingApi,
           private OrderRepository $orderRepo
       ) {}

       public function supports(object $event): bool
       {
           return $event instanceof PaymentCapturedEvent;
       }

       public function handle(object $event): void
       {
           if (!$event instanceof PaymentCapturedEvent) {
               return;
           }

           $orderId = $event->getContext()->get('orderId');
           $order = $this->orderRepo->getById($orderId);

           $shipment = $this->shippingApi->createShipment([
               'order_id' => $orderId,
               'recipient' => [
                   'name' => $order->getDeliveryName(),
                   'street' => $order->getDeliveryStreet(),
                   'city' => $order->getDeliveryCity(),
                   'zip' => $order->getDeliveryZip(),
                   'country' => $order->getDeliveryCountry(),
               ],
               'items' => $order->getOrderArticles(),
               'weight' => $order->getTotalWeight(),
           ]);

           $order->setTrackingNumber($shipment->getTrackingNumber());
           $order->save();
       }
   }

Inventory Management
--------------------

Reserve stock when contract is created, release on cancel/expire:

.. code-block:: php

   <?php

   namespace YourCompany\Inventory\EventHandler;

   use OxidEsales\PaymentComponent\EventSystem\Event\Contract\ContractCreatedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Event\Contract\ContractCancelledEvent;
   use OxidEsales\PaymentComponent\EventSystem\Event\Contract\ContractExpiredEvent;
   use OxidEsales\PaymentComponent\EventSystem\Handler\EventHandlerInterface;

   class InventoryReservationHandler implements EventHandlerInterface
   {
       public function __construct(
           private InventoryService $inventory
       ) {}

       public function supports(object $event): bool
       {
           return $event instanceof ContractCreatedEvent
               || $event instanceof ContractCancelledEvent
               || $event instanceof ContractExpiredEvent;
       }

       public function handle(object $event): void
       {
           $context = $event->getContext();
           $contractId = $context->get('contractId');
           $basketItems = $context->get('basketItems');

           if ($event instanceof ContractCreatedEvent) {
               foreach ($basketItems as $item) {
                   $this->inventory->reserve(
                       $item['articleId'],
                       $item['quantity'],
                       $contractId
                   );
               }
           }

           if ($event instanceof ContractCancelledEvent
               || $event instanceof ContractExpiredEvent) {
               $this->inventory->releaseReservation($contractId);
           }
       }
   }

Webhook Notification Service
-----------------------------

Send notifications on payment events:

.. code-block:: php

   <?php

   namespace YourCompany\Notifications\EventHandler;

   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\PaymentCapturedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\PaymentRefundedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Event\Payment\PaymentFailedEvent;
   use OxidEsales\PaymentComponent\EventSystem\Handler\EventHandlerInterface;

   class PaymentNotificationHandler implements EventHandlerInterface
   {
       public function __construct(
           private NotificationService $notifications,
           private OrderRepository $orderRepo
       ) {}

       public function supports(object $event): bool
       {
           return $event instanceof PaymentCapturedEvent
               || $event instanceof PaymentRefundedEvent
               || $event instanceof PaymentFailedEvent;
       }

       public function handle(object $event): void
       {
           $context = $event->getContext();
           $orderId = $context->get('orderId');
           $order = $this->orderRepo->getById($orderId);
           $customerEmail = $order->getCustomerEmail();

           match (true) {
               $event instanceof PaymentCapturedEvent =>
                   $this->notifications->send($customerEmail, 'payment_confirmed', [
                       'order_number' => $order->getOrderNumber(),
                       'amount' => $context->get('amount'),
                   ]),

               $event instanceof PaymentRefundedEvent =>
                   $this->notifications->send($customerEmail, 'refund_processed', [
                       'order_number' => $order->getOrderNumber(),
                       'refund_amount' => $context->get('refundAmount'),
                   ]),

               $event instanceof PaymentFailedEvent =>
                   $this->notifications->send($customerEmail, 'payment_failed', [
                       'order_number' => $order->getOrderNumber(),
                       'reason' => $context->get('failureReason'),
                   ]),
           };
       }
   }

Registering Your Handler
-------------------------

Step 1: Create services.yaml
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In your module's :file:`services.yaml`:

.. code-block:: yaml

   services:
     YourCompany\ERPConnector\EventHandler\ERPOrderExportHandler:
       arguments:
         $erpClient: '@YourCompany\ERPConnector\ERPApiClient'
         $logger: '@Psr\Log\LoggerInterface'
       tags:
         - { name: 'payment.event_handler' }

     YourCompany\CRMSync\EventHandler\CRMCustomerSyncHandler:
       arguments:
         $crmClient: '@YourCompany\CRMSync\CRMApiClient'
         $customerRepo: '@YourCompany\CRMSync\CustomerRepository'
       tags:
         - { name: 'payment.event_handler' }

Step 2: Register with EventListenerProvider
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If using the payment-component's event system, register your handler:

.. code-block:: php

   <?php

   use OxidEsales\PaymentComponent\EventSystem\EventListenerProvider;

   // In your module activation or DI configuration
   $provider = $container->get(EventListenerProvider::class);
   $provider->addHandler($container->get(ERPOrderExportHandler::class));
