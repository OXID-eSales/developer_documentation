Payment Component
=================

**Package:** ``oxid-esales/payment-component``

The ``oxid-esales/payment-component`` provides a provider-agnostic event-driven architecture
that allows third-party modules to react to payment lifecycle changes. It serves as the shared
foundation for payment modules such as Stripe Wallet and enables integrations with:

- **Shipping modules**: Update shipment status when payment is captured
- **CRM systems**: Sync customer data when orders are created
- **ERP systems**: Export orders when payment is confirmed
- **Inventory systems**: Reserve/release stock based on payment status
- **Notification services**: Send emails/SMS on payment events

.. toctree::
   :maxdepth: 1

   architecture
   events
   integration-examples
   best-practices
   database-schema
