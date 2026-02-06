.. _email_transport-20250105:

E-mail transport
================

OXID eShop uses PHPMailer by default, but supports Symfony Mailer as an alternative email transport layer. This section explains how to configure, extend the transport layer and implement asynchronous mail sending.

.. contents::
    :local:
    :depth: 2


Configuration
-------------

Enabling Symfony Mailer
^^^^^^^^^^^^^^^^^^^^^^^

By default, the legacy PHPMailer is used. To enable Symfony Mailer, use one of the following methods:

**Via environment variable** (see :doc:`environment`):

.. code-block:: ini
   :caption: .env

    OXID_MAILING_SYMFONY_MAILER=true

**Via configuration parameter:**

.. code-block:: yaml

    parameters:
      oxid_esales.mailing.use_symfony_mailer: true

Configuring the transport DSN
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The transport DSN defines how emails are delivered. The default value is ``native://default``, which uses PHP's native ``mail()`` function.

**Via environment variable:**

.. code-block:: ini
   :caption: .env

    OXID_MAILING_DSN=smtp://user:password@smtp.example.com:587

**Via configuration parameter:**

.. code-block:: yaml

    parameters:
      oxid_esales.mailing.dsn: 'smtp://user:password@smtp.example.com:587'

For more information on DSN formats and available transports, refer to the `Symfony Mailer documentation <https://symfony.com/doc/current/mailer.html>`__.


Extending the transport
-----------------------

You can customize the email transport by implementing your own ``TransportFactoryInterface``.

Transport decorator
^^^^^^^^^^^^^^^^^^^

To add cross-cutting concerns (logging, metrics, etc.), create a decorator implementing ``Symfony\Component\Mailer\Transport\TransportInterface`` that wraps the original transport and adds your logic in the ``send()`` method.


Asynchronous mail sending
-------------------------

For high-traffic shops, sending emails asynchronously improves performance by offloading delivery to a background process.

Symfony Mailer integrates with `Symfony Messenger <https://symfony.com/doc/current/messenger.html>`__ for async delivery. Once configured, run the worker to process queued emails.