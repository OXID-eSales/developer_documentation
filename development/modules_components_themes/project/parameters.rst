Configuration parameters
========================

.. note::

    The container cache must be rebuilt after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code:: bash

       ./vendor/bin/oe-console oe:cache:clear

E-mail configuration
--------------------

E-mail transport (Symfony Mailer)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OXID eShop supports Symfony Mailer as an alternative email transport layer. This allows flexible configuration of email delivery using DSN (Data Source Name) strings.

Enabling Symfony Mailer
"""""""""""""""""""""""

By default, the legacy PHPMailer is used. To enable Symfony Mailer, set the ``oxid_esales.mailing.use_symfony_mailer`` parameter to ``true``.

.. code-block:: yaml
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.mailing.use_symfony_mailer: true

Configuring the transport DSN
"""""""""""""""""""""""""""""

The transport is configured via the ``oxid_esales.mailing.dsn`` parameter. The default value is ``native://default``, which uses PHP's native ``mail()`` function.

.. code-block:: yaml
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.mailing.use_symfony_mailer: true
      oxid_esales.mailing.dsn: 'smtp://user:password@smtp.example.com:587'

Common DSN examples
"""""""""""""""""""

**Native PHP mail function (default):**

.. code-block:: yaml

    oxid_esales.mailing.dsn: 'native://default'

**SMTP server:**

.. code-block:: yaml

    oxid_esales.mailing.dsn: 'smtp://user:password@smtp.example.com:587'

**SMTP with TLS encryption:**

.. code-block:: yaml

    oxid_esales.mailing.dsn: 'smtp://user:password@smtp.example.com:465?encryption=ssl'

**Sendmail:**

.. code-block:: yaml

    oxid_esales.mailing.dsn: 'sendmail://default'

**Null transport (disables email sending, useful for testing):**

.. code-block:: yaml

    oxid_esales.mailing.dsn: 'null://null'

For more information on DSN formats and available transports, refer to the `Symfony Mailer documentation <https://symfony.com/doc/current/mailer.html>`_.

Disabling order notification e-mails
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, when a new order is received, the system sends an e-mail to the customer and the shop owner.

If required, deactivate the sending of these e-mail notifications.

Disabling e-mail notifications can be useful, for example, if your ERP is responsible for sending out order confirmations. In this case, a log entry is created.

|procedure|

To disable order e-mail notifications, in the ``source/Internal/Utility/Email/services.yaml`` file, set the ``oxid_esales.email.disable_order_emails`` to ``true``.

.. code-block:: yaml
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.email.disable_order_emails: true

|result|

If order notification e-mails are disabled, in ``source/log/oxideshop.log`` the following notice messages are logged to the system for informational purposes:

* "Order email not sent to user due to disabled configuration option."
* "Order email not sent to owner due to disabled configuration option."

.. note::

    The default log level is *error*.

    To have the notice messages logged, in the :file:`config.inc.php` file, set the log level
    parameter ``$this->sLogLevel``  to ``notice``.
