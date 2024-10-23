Configuration parameters
========================

.. note::

    The container cache must be rebuild after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code::

        ./vendor/bin/oe-console o:c:c

Email configuration
-------------------

oxid_esales.email.disable_order_emails
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This parameter controls whether emails are sent for new orders to user and owner within the shop.

    - Enabled (default): Emails are sent to both the user who placed the order and the shop owner.
    - Disabled: Emails are not sent. A notice message is logged to the system for informational purposes.

Example Configuration (Enabled):

.. code:: yaml

    oxid_esales.email.disable_order_emails = false;