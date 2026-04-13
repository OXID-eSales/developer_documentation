API Controllers
===============

As of OXID eShop version 7.5, you can create RESTful API endpoints using Symfony routing attributes.

The new :file:`api.php` entry point provides a lightweight alternative to traditional OXID controllers
for building JSON APIs, microservices, and headless commerce solutions.

Unlike view controllers, API controllers don't render templates and can return structured data (JSON, XML, etc.)
directly to the client.

Overview
--------

API controllers leverage:

- Symfony HttpKernel for request/response handling
- Symfony Routing with PHP attributes for URL mapping
- Dependency Injection Container for service management
- Route auto-discovery from public services

Key differences from view controllers:

+------------------------+-----------------------------------------------+---------------------------------------------+
|                        | **API controllers**                           | **View controllers**                        |
+========================+===============================================+=============================================+
| **Entry point**        | ``api.php`` (Symfony HttpKernel)              | ``index.php`` (legacy ``ShopControl``)      |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Routing**            | ``#[Route]`` attributes, compiled at          | ``cl=`` query parameter, resolved at        |
|                        | container build time                          | runtime                                     |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Base class**         | None — pure PHP class, can be ``readonly``    | Must extend ``BaseController``              |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Request access**     | Explicit ``Request $request`` parameter       | Static ``Registry::getRequest()``           |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Output**             | Return a ``Response`` object                  | Return a template name string               |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Error responses**    | JSON with HTTP status code                    | HTML error page                             |
+------------------------+-----------------------------------------------+---------------------------------------------+
| **Session**            | Stateless by default; opt-in                  | Always started                              |
+------------------------+-----------------------------------------------+---------------------------------------------+

Creating a Simple API Endpoint
-------------------------------

Controller Class
^^^^^^^^^^^^^^^^

Create a simple API controller that returns a list of active products:

|example|

.. code:: php

    <?php

    declare(strict_types=1);

    namespace MyVendor\MyModule\Controller\Api;

    use Symfony\Component\HttpFoundation\JsonResponse;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Attribute\Route;

    readonly class ProductApiController
    {
        public function __construct(
            private ProductServiceInterface $productService
        ) {
        }

        #[Route('/api/products', methods: ['GET'])]
        public function listProducts(): Response
        {
            $products = $this->productService->getActiveProducts();

            return new JsonResponse([
                'products' => $products,
                'total' => count($products),
            ]);
        }
    }

.. note::

    API controllers don't need to extend `BaseController`. They can be simple readonly classes
    that accept dependencies via constructor injection.


.. important::

    All API routes must start with ``/api/`` prefix.

Service Registration
^^^^^^^^^^^^^^^^^^^^

Register your API controller as a public service in :file:`services.yaml`:

|example|

.. code:: yaml

    MyVendor\MyModule\Controller\Api\ProductApiController:
        public: true

The controller must be public so that the RoutePass compiler can discover its routes.


Accessing the Endpoint
^^^^^^^^^^^^^^^^^^^^^^^

Your API endpoint is now accessible at:

.. code:: text

    https://<shop-url>/api/products

Route Attributes
----------------

The `#[Route]` attribute provides powerful routing capabilities:

Path Parameters
^^^^^^^^^^^^^^^

Define dynamic path segments using `{parameter}` syntax:

|example|

.. code:: php

    #[Route('/api/products/{id}', methods: ['GET'])]
    public function getProduct(string $id): Response
    {
        $product = $this->productService->getProductById($id);

        if (!$product) {
            return new JsonResponse(['error' => 'Product not found'], 404);
        }

        return new JsonResponse($product);
    }

URL: ``/api/products/abc123``

Route Requirements
^^^^^^^^^^^^^^^^^^

Add regex constraints to path parameters:

|example|

.. code:: php

    #[Route('/api/products/{id}', requirements: ['id' => '[a-f0-9]{32}'], methods: ['GET'])]
    public function getProduct(string $id): Response
    {
        // $id is guaranteed to be a 32-character hex string
    }

Multiple Parameters
^^^^^^^^^^^^^^^^^^^

Combine multiple path parameters:

|example|

.. code:: php

    #[Route('/api/categories/{categoryId}/products/{productId}', methods: ['GET'])]
    public function getCategoryProduct(string $categoryId, string $productId): Response
    {
        // Access both parameters
    }

Query Parameters
^^^^^^^^^^^^^^^^

Access query parameters via the Request object:

|example|

.. code:: php

    use Symfony\Component\HttpFoundation\Request;

    #[Route('/api/products', methods: ['GET'])]
    public function listProducts(Request $request): Response
    {
        $limit = (int) $request->query->get('limit', 10);
        $offset = (int) $request->query->get('offset', 0);
        $search = $request->query->get('search', '');

        $products = $this->productService->getProducts($limit, $offset, $search);

        return new JsonResponse([
            'products' => $products,
            'limit' => $limit,
            'offset' => $offset,
        ]);
    }

URL: ``/api/products?limit=20&offset=40&search=laptop``

HTTP Methods
^^^^^^^^^^^^

Restrict routes to specific HTTP methods:

|example|

.. code:: php

    #[Route('/api/products', methods: ['POST'])]
    public function createProduct(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        // Create product
        return new JsonResponse(['id' => $newId], 201);
    }

    #[Route('/api/products/{id}', methods: ['PUT'])]
    public function updateProduct(string $id, Request $request): Response
    {
        // Update product
        return new JsonResponse(['updated' => true]);
    }

    #[Route('/api/products/{id}', methods: ['DELETE'])]
    public function deleteProduct(string $id): Response
    {
        // Delete product
        return new JsonResponse(null, 204);
    }

Route Auto-Discovery
--------------------

Routes are automatically discovered during container compilation through the RoutePass compiler pass.

How It Works
^^^^^^^^^^^^

1. During container build, `RoutePass` scans all public services
2. For each public service, it checks for `#[Route]` attributes
3. All discovered routes are compiled into a routing table
4. The compiled routes are stored in the container parameter `oxid.routes`
5. At runtime, `api.php` uses this compiled routing table for fast matching

.. important::

    Routes are only discovered from **public services**. If your API controller is not marked
    as `public: true` in `services.yaml`, its routes will not be available.

Performance Considerations
^^^^^^^^^^^^^^^^^^^^^^^^^^

Route compilation happens during container build, not on every request. This means:

- First request after code change may require container rebuild
- Production environments benefit from persistent container cache
- Development environments may need frequent cache clearing

Rate Limiting
-------------

All ``/api/*`` requests are rate-limited by default. See :doc:`Rate Limiting <rate_limiting>`
for configuration, response headers, and how to exclude specific routes.

Security and Authentication
---------------------------

.. warning::

    **As of version 7.5, API controllers do NOT provide automatic authentication or authorization.**

    You are responsible for implementing your own security layer.

Unlike traditional OXID controllers that integrate with shop authentication, API controllers
are stateless by design. You must implement your own authentication mechanism.

Common Approaches
^^^^^^^^^^^^^^^^^

**1. API Key Authentication**

|example|

.. code:: php

    readonly class SecureApiController
    {
        public function __construct(
            private ApiKeyValidatorInterface $apiKeyValidator
        ) {
        }

        #[Route('/api/secure/data', methods: ['GET'])]
        public function getData(Request $request): Response
        {
            $apiKey = $request->headers->get('X-API-Key');

            if (!$this->apiKeyValidator->isValid($apiKey)) {
                return new JsonResponse(['error' => 'Unauthorized'], 401);
            }

            // Proceed with authenticated request
        }
    }

**2. JWT Token Authentication**

OXID eShop provides a JWT Authenticator component for token-based authentication.

The component includes:

- User authentication and JWT token generation
- Symfony Security integration with ``#[IsGranted]`` and ``#[CurrentUser]`` attributes
- Role-based access control
- Ready-to-use login and profile endpoints

For complete documentation, see :doc:`JWT Authentication </development/tell_me_about/api/jwt_authentication>`.

**3. OAuth 2.0**

For more complex scenarios, consider implementing OAuth 2.0 using libraries like
`league/oauth2-server`.

Best Practices
--------------

Dependency Injection
^^^^^^^^^^^^^^^^^^^^

Always use constructor injection for dependencies:

.. code:: php

    // Good ✓
    readonly class ProductApiController
    {
        public function __construct(
            private ProductServiceInterface $productService,
            private LoggerInterface $logger
        ) {
        }
    }

    // Bad ✗ - Don't use ContainerFacade
    class ProductApiController
    {
        public function listProducts(): Response
        {
            $service = ContainerFacade::get(ProductServiceInterface::class);
        }
    }

Troubleshooting
---------------

Route Not Found Error
^^^^^^^^^^^^^^^^^^^^^

**Symptom**: ``No routes found for "/api/products"``

**Causes**:

1. Controller not registered as public service
2. Container cache is stale
3. Route attribute syntax error

Debug Mode
^^^^^^^^^^

To get detailed error messages and stack traces, enable debug mode by setting the ``OXID_DEBUG_MODE`` environment variable:

.. code:: bash

    # In .env file
    OXID_DEBUG_MODE=1

    # Or set directly
    export OXID_DEBUG_MODE=1
