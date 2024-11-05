Configuration parameters
========================

E-mail configuration
--------------------

Disabling order notification e-mails
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, when a new order is received, the system sends an e-mail to the customer and the shop owner.

If required, deactivate the sending of these e-mail notifications.

.. todo: #HR/#AB: Verify the use case:

Disabling e-mail notifications can be useful, for example, if you use an ERP system or if you have a test system. In this case, a log entry is created.

|procedure|

.. todo: #HR/#AB: Verify the following: is it done in ``config.inc.php`` file?

To disable order e-mail notifications, in the ``config.inc.php`` file, set the ``oxid_esales.email.disable_order_emails`` to ``true``.

.. code:: yaml

    $this->oxid_esales.email.disable_order_emails = true;

|result|

Order notification e-mails are not sent. A notice message is logged to the system for informational purposes.

.. todo: #HR/#AB: Where do I find the log, how does it look like?

