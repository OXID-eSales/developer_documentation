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
