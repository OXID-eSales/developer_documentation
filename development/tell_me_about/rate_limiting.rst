API Rate Limiting
=================

As of OXID eShop version 7.5, the API includes built-in rate limiting to protect against
abuse and ensure fair resource usage.

Rate limiting restricts the number of API requests a client can make within a specified
time window, helping to prevent denial-of-service attacks and ensuring service availability.

Overview
--------

The rate limiter provides:

- Token bucket algorithm for smooth rate limiting
- Sliding window algorithm as an alternative
- Per-client tracking based on IP address
- Configurable limits, intervals, and excluded routes
- Standard rate limit headers in responses

Configuration
-------------

Configure rate limiting in your project's :file:`services.yaml` by overriding the parameters:

|example|

.. code:: yaml

    parameters:
        oxid_esales.rate_limiter.enabled: true
        oxid_esales.rate_limiter.limit: 100
        oxid_esales.rate_limiter.interval: 60
        oxid_esales.rate_limiter.policy: 'token_bucket'
        oxid_esales.rate_limiter.excluded_routes: []

Parameters
^^^^^^^^^^

``oxid_esales.rate_limiter.enabled``
    Enable or disable rate limiting. Default: ``true``

``oxid_esales.rate_limiter.limit``
    Maximum number of requests allowed per interval. Default: ``100``

``oxid_esales.rate_limiter.interval``
    Time window in seconds. Default: ``60``

``oxid_esales.rate_limiter.policy``
    Rate limiting algorithm. Options: ``token_bucket``, ``sliding_window``. Default: ``token_bucket``

``oxid_esales.rate_limiter.excluded_routes``
    Array of route patterns to exclude from rate limiting. Default: ``[]``

Excluding Routes
----------------

You can exclude specific routes from rate limiting using exact paths or wildcard patterns:

|example|

.. code:: yaml

    parameters:
        oxid_esales.rate_limiter.excluded_routes:
            - '/api/health'
            - '/api/public/*'

Pattern Matching
^^^^^^^^^^^^^^^^

Route matching supports exact paths and wildcard patterns using ``*``:

- ``*`` matches any number of characters

Examples:

- ``/api/health`` - exact match
- ``/api/public/*`` - matches ``/api/public/info``, ``/api/public/status``, etc.

Response Headers
----------------

Successful API responses include rate limit information headers:

``X-RateLimit-Limit``
    Maximum requests allowed per interval.

``X-RateLimit-Remaining``
    Remaining requests in current window.

``X-RateLimit-Reset``
    Unix timestamp when the rate limit resets.

|example|

.. code:: text

    HTTP/1.1 200 OK
    X-RateLimit-Limit: 100
    X-RateLimit-Remaining: 95
    X-RateLimit-Reset: 1699123456

Rate Limit Exceeded
-------------------

When a client exceeds the rate limit, the API returns a ``429 Too Many Requests`` response:

|example|

.. code:: json

    {
        "error": "rate_limit_exceeded",
        "message": "Too many requests. Please try again later.",
        "retry_after": 45
    }

The response includes these headers:

``Retry-After``
    Seconds until the client can retry.

``X-RateLimit-Reset``
    Unix timestamp when the rate limit resets.

Disabling Rate Limiting
-----------------------

To disable rate limiting entirely:

.. code:: yaml

    parameters:
        oxid_esales.rate_limiter.enabled: false

.. warning::

    Disabling rate limiting in production environments is not recommended as it
    exposes your API to potential abuse.

Best Practices
--------------

**Set appropriate limits**
    Consider your expected traffic and server capacity. Start conservative and
    adjust based on monitoring.

**Exclude health checks**
    Always exclude health check endpoints used by load balancers:

    .. code:: yaml

        parameters:
            oxid_esales.rate_limiter.excluded_routes:
                - '/api/health'
                - '/api/ping'

**Configure trusted proxies**
    If OXID eShop runs behind a reverse proxy or load balancer, configure trusted proxy IPs so clients are identified by their real IP address rather than the proxy IP:

    .. code-block:: yaml

        parameters:
          oxid_esales.request.trusted_proxies:
            - '127.0.0.1'
            - '10.0.0.0/8'

**Monitor rate limit hits**
    Track 429 responses in your monitoring to identify potential issues or attacks.

**Communicate limits**
    Document your rate limits for API consumers so they can implement appropriate
    retry logic.

Client Implementation
---------------------

API clients should handle rate limiting gracefully:

|example|

.. code:: php

    $response = $httpClient->request('GET', '/api/products');

    if ($response->getStatusCode() === 429) {
        $retryAfter = $response->getHeaderLine('Retry-After');
        sleep((int) $retryAfter);
        // Retry the request
    }

Customization
-------------

Custom Client Identifier
^^^^^^^^^^^^^^^^^^^^^^^^

By default, clients are identified by IP address. To customize this, create a service
implementing ``ClientIdentifierProviderInterface``:

|example|

.. code:: php

    <?php

    declare(strict_types=1);

    namespace MyVendor\MyModule\RateLimiter;

    use OxidEsales\EshopCommunity\Internal\Framework\RateLimiter\ClientIdentifierProviderInterface;
    use Symfony\Component\HttpFoundation\Request;

    class ApiKeyClientIdentifier implements ClientIdentifierProviderInterface
    {
        public function getClientIdentifier(Request $request): string
        {
            // Use API key as identifier if present, otherwise fall back to IP
            return $request->headers->get('X-API-Key')
                ?? $request->getClientIp()
                ?? 'unknown';
        }
    }

Register your implementation in :file:`services.yaml`:

.. code:: yaml

    OxidEsales\EshopCommunity\Internal\Framework\RateLimiter\ClientIdentifierProviderInterface:
        class: MyVendor\MyModule\RateLimiter\ApiKeyClientIdentifier

Storefront Rate Limiting
========================

Since OXID eShop version 7.6, the storefront request path has its own optional rate limiter,
independent of the API limiter above. It is **disabled by default** and is enabled and tuned
entirely through DI parameters.

The storefront limiter is **rule-driven**: you define a list of rules, each matching some requests
and applying its own limit. One blanket rule can cover every request; additional rules protect
sensitive actions such as login, password reset and registration.

Configuration
-------------

Configure the storefront limiter in your project's :file:`services.yaml`:

|example|

.. code:: yaml

    parameters:
        oxid_esales.rate_limiter.storefront.enabled: true
        oxid_esales.rate_limiter.storefront.excluded_routes: []
        oxid_esales.rate_limiter.storefront.excluded_ips: []
        oxid_esales.rate_limiter.storefront.rules:
            - { id: global, key: user, limit: 100, interval: '60 seconds' }

Parameters
^^^^^^^^^^

``oxid_esales.rate_limiter.storefront.enabled``
    Enable or disable the storefront limiter. Default: ``false``

``oxid_esales.rate_limiter.storefront.rules``
    The list of rate-limiting rules (see below). Default: a single ``global`` rule.

``oxid_esales.rate_limiter.storefront.excluded_routes``
    Route patterns (exact or ``*`` wildcard, matched against the request path) exempt from all rules. Default: ``[]``

``oxid_esales.rate_limiter.storefront.excluded_ips``
    Client IP addresses exempt from all rules. Default: ``[]``

Rules
-----

Each rule is a map with the following keys:

``id``
    A unique identifier for the rule.

``cl`` / ``fnc`` (optional)
    The controller key and function the rule applies to. A rule with neither ``cl`` nor ``fnc``
    matches **every** request (a blanket limit). ``fnc`` may be a single value or a list.

``key``
    How the client is identified for this rule:

    - ``user`` — the logged-in user id, falling back to the client IP for anonymous requests
    - ``ip`` — the client IP
    - ``email`` — the submitted login name (the ``lgn_usr`` request parameter) combined with the
      client IP, so requests from other sources cannot exhaust an account's bucket; requests
      without ``lgn_usr`` are not counted by ``email`` rules

``limit`` / ``interval``
    Maximum number of requests per interval, where ``interval`` is a relative time string such as
    ``'60 seconds'`` or ``'5 minutes'``.

Several rules may target the same action; a request is rejected as soon as any matching rule is
exceeded. Matching rules are enforced in the order ``ip``, ``user``, ``email``, regardless of
their configuration order. Bucket keys are stored as hashes — raw IP addresses, user ids and
login names never reach the storage.

Protecting sensitive actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Add rules for the login, password-reset, registration and form endpoints. For login, combine a
per-IP rule with a per-email rule, so a single account stays protected even across changing IP
addresses:

|example|

.. code:: yaml

    parameters:
        oxid_esales.rate_limiter.storefront.rules:
            - { id: global,          key: user,                                       limit: 100, interval: '60 seconds' }
            - { id: login_ip,        fnc: ['login', 'login_noredirect'], key: ip,     limit: 30,  interval: '5 minutes' }
            - { id: login_email,     fnc: ['login', 'login_noredirect'], key: email,  limit: 5,   interval: '1 minute' }
            - { id: forgotpwd_email, cl: forgotpwd,  fnc: forgotpassword, key: email, limit: 3,   interval: '15 minutes' }
            - { id: register_ip,     cl: register,   fnc: registeruser,   key: ip,    limit: 5,   interval: '10 minutes' }
            - { id: contact_ip,      cl: contact,    fnc: send,           key: ip,    limit: 5,   interval: '10 minutes' }

Response
--------

When a rule is exceeded, the storefront returns a ``429 Too Many Requests`` response with a
``Retry-After`` header and the ``X-RateLimit-Limit``, ``X-RateLimit-Remaining`` and
``X-RateLimit-Reset`` headers.

If the limiter's storage is unavailable, the request is allowed and the failure is logged —
a broken backend never blocks the storefront.

Blocked-Request Event
---------------------

Whenever a request is blocked, the limiter dispatches
``OxidEsales\EshopCommunity\Internal\Framework\RateLimiter\Storefront\Event\RateLimitExceededEvent``
carrying the rule id, the (hashed) bucket key and the retry-after seconds. Subscribe to it for
monitoring or alerting by registering an event subscriber with the ``kernel.event_subscriber`` tag.

Storage Backend
---------------

By default the limiter stores its counters on the local filesystem, which is per-node. For a
clustered setup, override the cache pool and lock store with shared implementations (for example
Redis) in your project's :file:`services.yaml`:

With the filesystem backend, expired bucket files accumulate under the cache directory until they
are pruned. Schedule the ``oe:rate-limiter:prune`` console command (for example daily, via cron)
to delete them; the Redis backend evicts expired entries automatically.

|example|

.. code:: yaml

    services:
        oxid_esales.rate_limiter.storefront.cache:
            class: Symfony\Component\Cache\Adapter\RedisAdapter
            arguments: [ '@my_redis_client', 'rate_limiter', 0 ]

        oxid_esales.rate_limiter.storefront.lock_store:
            class: Symfony\Component\Lock\Store\RedisStore
            arguments: [ '@my_redis_client' ]

Custom Keying
-------------

Key resolution is provided by the ``ThrottleKeyProvider`` service. To change how clients are
identified, override the registration of
``OxidEsales\EshopCommunity\Internal\Framework\RateLimiter\Storefront\Service\ThrottleKeyProviderInterface``
in your :file:`services.yaml` with your own implementation.
