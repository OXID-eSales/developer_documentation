Event-Driven Architecture
=========================

The payment component uses a PSR-14 compatible event-driven architecture.
This decouples payment modules from downstream consumers such as ERP, CRM or shipping systems.

Traditional approach (tightly coupled)::

   PaymentService → ShippingService → CRMService → ERPService

Event-driven approach (loosely coupled)::

   PaymentCapturedEvent → [ShippingHandler, CRMHandler, ERPHandler]
                          (independent, parallel execution)

Benefits:

- Modules don't depend on each other
- Add/remove integrations without code changes
- Each handler fails independently
- Easy to test in isolation

How It Works
------------

::

   ┌─────────────────┐     ┌────────────────────┐     ┌─────────────────┐
   │  Payment Module │────▶│  EventDispatcher   │────▶│  Your Handler   │
   │  (Stripe, etc.) │     │  (PSR-14)          │     │  (CRM, ERP...)  │
   └─────────────────┘     └────────────────────┘     └─────────────────┘
           │                        │                         │
           │ dispatch(event)        │ notify subscribers      │ handle(event)
           ▼                        ▼                         ▼
      PaymentCapturedEvent    EventListenerProvider     Update external system

Event Flow
----------

1. **Payment module** performs an action (capture, refund, etc.)
2. **Event** is dispatched with relevant context data
3. **EventDispatcher** notifies all registered handlers
4. **Your handler** receives the event and processes it
5. Each handler operates independently — failures don't affect others
