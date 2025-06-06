Configuration parameters
========================

.. note::

    The container cache must be rebuilt after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code:: bash

       ./vendor/bin/oe-console oe:cache:clear

E-mail configuration
--------------------

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
