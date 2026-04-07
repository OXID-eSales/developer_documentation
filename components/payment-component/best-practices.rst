Best Practices
==============

Handle Failures Gracefully
--------------------------

.. code-block:: php

   public function handle(object $event): void
   {
       try {
           // Your logic
       } catch (\Throwable $e) {
           // Log but don't rethrow
           $this->logger->error('Handler failed', [
               'handler' => static::class,
               'event' => get_class($event),
               'error' => $e->getMessage(),
           ]);
           // Consider: queue for retry, alert, etc.
       }
   }

Use Idempotency
---------------

Webhooks may be delivered multiple times. Handle duplicates:

.. code-block:: php

   public function handle(object $event): void
   {
       $eventId = $event->getContext()->get('eventId');

       if ($this->processedEvents->has($eventId)) {
           return; // Already processed
       }

       // Process event...

       $this->processedEvents->markProcessed($eventId);
   }

Keep Handlers Fast
------------------

For slow operations, queue them:

.. code-block:: php

   public function handle(object $event): void
   {
       // Quick: dispatch to queue
       $this->queue->push(new ERPExportJob(
           $event->getContext()->toArray()
       ));
   }

Test Your Handlers
------------------

.. code-block:: php

   class ERPOrderExportHandlerTest extends TestCase
   {
       public function testExportsOrderOnPaymentCaptured(): void
       {
           $erpClient = $this->createMock(ERPApiClient::class);
           $erpClient->expects($this->once())
               ->method('createOrder')
               ->willReturn('ERP-12345');

           $handler = new ERPOrderExportHandler($erpClient, new NullLogger());

           $event = new PaymentCapturedEvent(new EventContext([
               'orderId' => 'OXID-123',
               'amount' => 99.99,
               'currency' => 'EUR',
           ]));

           $handler->handle($event);
       }
   }
