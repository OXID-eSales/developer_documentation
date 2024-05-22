Switching to Redis
==================
.. _redis-caching-tutorial-20240514:

Replace the default cache implementation with Redis by implementing the `CacheItemPoolFactoryInterface` to create a `Symfony redis adapter <https://symfony.com/doc/current/components/cache/adapters/redis_adapter.html>`_.

For an illustration, check our `demo component <https://github.com/OXID-eSales/component-template>`_.

|prerequisites|

* You have a running Redis server which is accessible from the PHP application.

  For more information, see `How to Deploy and Run Redis in a Docker Container <https://redis.io/learn/operate/orchestration/docker>`__.

|procedure|

1. Implementation of `CacheItemPoolFactoryInterface` and
using `Symfony redis adapter <https://symfony.com/doc/current/components/cache/adapters/redis_adapter.html>`_.
The key point here is to configure the namespace parameter.

.. code-block:: php

    return new RedisAdapter(
        RedisAdapter::createConnection($this->dsn),
        namespace: "cache_items_shop_$shopId",
    );

2. In the service YAML file, define the service. In the `cache.redis.dsn` parameter, use your own Redis server's DNS.

.. code-block:: yaml

    cache.redis.dsn: 'redis://localhost:6379'

    OxidEsales\EshopCommunity\Internal\Framework\Cache\Pool\CacheItemPoolFactoryInterface:
        class: OxidEsales\ComponentTemplate\Cache\RedisCacheItemPoolFactory
        arguments:
            $dsn: '%cache.redis.dsn%'

3. In the root service YAML file of the component, import the new factory service:

.. code-block:: yaml

    imports:
        - { resource: src/Cache/services.yaml }

|result|

After the installation of the component, the default filesystem caching is replaced with the new Redis-based caching.
