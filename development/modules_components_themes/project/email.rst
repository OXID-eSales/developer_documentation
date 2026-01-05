.. _email_transport-20250105:

E-mail transport
================

OXID eShop uses PHPMailer by default, but supports Symfony Mailer as an alternative email transport layer. This section explains how to extend the transport layer and implement asynchronous mail sending.

.. contents::
    :local:
    :depth: 2


Extending the transport
-----------------------

You can customize the email transport by implementing your own ``TransportFactoryInterface``.

Transport decorator
^^^^^^^^^^^^^^^^^^^

To add cross-cutting concerns (logging, metrics, etc.), create a decorator implementing ``Symfony\Component\Mailer\Transport\TransportInterface`` that wraps the original transport and adds your logic in the ``send()`` method.


Asynchronous mail sending
-------------------------

For high-traffic shops, sending emails asynchronously improves performance by offloading delivery to a background process.

Using Symfony Messenger
^^^^^^^^^^^^^^^^^^^^^^^

Symfony Mailer integrates with Symfony Messenger for async delivery. To enable this:

1. Install Symfony Messenger:

   .. code-block:: bash

       composer require symfony/messenger

2. Configure the ``MailerInterface`` service to use a message bus by passing a ``MessageBusInterface`` instance as the ``$bus`` argument.

3. Create a message handler for ``Symfony\Component\Mailer\Messenger\SendEmailMessage``.

4. Configure a transport (database, Redis, RabbitMQ) for the messenger queue.

5. Run the worker to process queued emails:

   .. code-block:: bash

       ./vendor/bin/oe-console messenger:consume async

For more details, refer to the `Symfony Messenger documentation <https://symfony.com/doc/current/messenger.html>`_.

Custom queue implementation
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Alternatively, implement your own queue solution:

1. Create a ``TransportInterface`` implementation that stores emails in a queue (database table, Redis, etc.) instead of sending immediately.

2. Create a console command or cron job to process the queue and send emails via the actual transport.

3. Register your queued transport as the default transport in ``services.yaml``.