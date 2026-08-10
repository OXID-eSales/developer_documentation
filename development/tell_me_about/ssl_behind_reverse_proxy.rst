HTTPS Detection Behind SSL Offloaders
=====================================

When TLS is terminated by an upstream SSL offloader (reverse proxy, load balancer, or CDN) that
forwards the request to the shop over plain HTTP, the shop can still detect that the original
request was HTTPS from the forwarded headers.

``\OxidEsales\Eshop\Core\Config::isSsl()`` treats the request as HTTPS when the offloader sets a
common forwarded scheme header such as ``X-Forwarded-Proto`` or ``Forwarded``, including the
usual non-standard variants (for example ``X-Forwarded-Ssl`` or ``Front-End-Https``).

.. important::

    Forwarded headers are only trusted when the request comes from a configured trusted proxy.
    If none are configured, they are ignored.

Configuration
-------------

Add the offloader's IP addresses (or CIDR ranges) to the
``oxid_esales.request.trusted_proxies`` parameter in :file:`var/configuration/configurable_services.yaml`:

|example|

.. code:: yaml

    parameters:
      oxid_esales.request.trusted_proxies:
        - '127.0.0.1'
        - '10.0.0.0/8'

.. note::

    The container cache must be rebuilt after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code:: bash

       ./vendor/bin/oe-console oe:cache:clear

To serve the shop over SSL, an SSL shop URL must also be configured (``sSSLShopURL``, or
``sMallSSLShopURL`` for a subshop in Enterprise Edition mall setups). For the admin panel,
configuring ``sAdminSSLURL`` alone is also sufficient.
