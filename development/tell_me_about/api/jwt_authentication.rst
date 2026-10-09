JWT Authentication
==================

As of OXID eShop version 7.5, you can use the JWT Authenticator component to add token-based
authentication to API endpoints exposed via the :doc:`API entrypoint <api_controllers>`.

The component provides a complete authentication solution including user validation,
token generation, role-based access control, and ready-to-use API controllers.

Overview
--------

The JWT Authenticator component provides:

- JWT token generation and validation
- Integration with OXID user system
- Role-based access control with Symfony Security
- ``#[IsGranted]`` and ``#[CurrentUser]`` attributes for protecting endpoints
- Ready-to-use login and profile endpoints

Key features:

- Stateless authentication suitable for APIs and headless commerce
- Automatic user role resolution from OXID user data
- Configurable role hierarchy
- Symfony Security integration for consistent authorization

Installation
------------

Install the component via Composer:

.. code:: bash

    composer require oxid-esales/jwt-authentication-component

The component is automatically registered as an OXID eShop component and its services
are immediately available.

Configuration
-------------

JWT Secret Key
^^^^^^^^^^^^^^

Set the JWT secret key in your ``.env`` file:

.. code:: text

    API_JWT_SECRET=your-secret-key-here

Generate a secure secret key using OpenSSL:

.. code:: bash

    openssl rand -base64 64

.. warning::

    **Never commit your JWT secret to version control.** Always use environment variables
    or secure configuration management.

Role Hierarchy
^^^^^^^^^^^^^^

Configure role inheritance in your project's :file:`services.yaml`:

|example|

.. code:: yaml

    parameters:
      oxid_jwt_authenticator.role_hierarchy:
        ROLE_ADMIN_MALL:
          - ROLE_ADMIN

With this configuration, users with ``ROLE_ADMIN_MALL`` automatically inherit ``ROLE_ADMIN``
permissions.

For more complex role hierarchies, you can reimplement ``RoleResolverInterface`` to define
custom resolution logic. See `Custom Roles`_ below.

Available Endpoints
-------------------

The component provides these built-in API endpoints:

Public Endpoints
^^^^^^^^^^^^^^^^

These endpoints are accessible without authentication:

**POST /api/login**

Authenticates a user and returns a JWT token.

|example|

.. code:: bash

    curl -X POST https://your-shop.com/api/login \
      -H "Content-Type: application/json" \
      -d '{"username": "user@example.com", "password": "password"}'

Response:

.. code:: json

    {
      "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
      "user": {
        "username": "user@example.com",
        "roles": ["ROLE_USER"]
      }
    }

Protected Endpoints
^^^^^^^^^^^^^^^^^^^

These endpoints require authentication via JWT token in the ``Authorization`` header:

**GET /api/profile**

Returns the authenticated user's profile. Requires ``IS_AUTHENTICATED``.

|example|

.. code:: bash

    curl -X GET https://your-shop.com/api/profile \
      -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc..."

Response:

.. code:: json

    {
      "username": "user@example.com",
      "roles": ["ROLE_USER"]
    }

Protecting Your Endpoints
--------------------------

Use Symfony's ``#[IsGranted]`` attribute to protect your API endpoints:

Basic Authentication
^^^^^^^^^^^^^^^^^^^^

Require any authenticated user:

|example|

.. code:: php

    <?php

    declare(strict_types=1);

    namespace MyVendor\MyModule\Controller\Api;

    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Attribute\Route;
    use Symfony\Component\Security\Http\Attribute\IsGranted;

    final readonly class DataController
    {
        #[Route('/api/data', methods: ['GET'])]
        #[IsGranted('IS_AUTHENTICATED')]
        public function getData(): Response
        {
            // Only authenticated users can access this
        }
    }

Role-Based Authorization
^^^^^^^^^^^^^^^^^^^^^^^^^

Require specific roles:

|example|

.. code:: php

    use OxidEsales\AuthComponent\Security\User\ApiUser;
    use Symfony\Component\HttpFoundation\JsonResponse;
    use Symfony\Component\Security\Http\Attribute\CurrentUser;
    use Symfony\Component\Security\Http\Attribute\IsGranted;

    final readonly class AdminController
    {
        #[Route('/api/admin/settings', methods: ['GET'])]
        #[IsGranted('ROLE_ADMIN')]
        public function getSettings(#[CurrentUser] ApiUser $user): Response
        {
            return new JsonResponse([
                'admin_user' => $user->getUserIdentifier(),
            ]);
        }
    }

.. note::

    The ``#[IsGranted]`` attribute automatically returns a 403 Forbidden response
    if the user doesn't have the required role.

Accessing Authenticated User
-----------------------------

Using #[CurrentUser] Attribute
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The recommended approach is to use Symfony's ``#[CurrentUser]`` attribute:

|example|

.. code:: php

    use OxidEsales\AuthComponent\Security\User\ApiUser;
    use Symfony\Component\HttpFoundation\JsonResponse;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Attribute\Route;
    use Symfony\Component\Security\Http\Attribute\CurrentUser;
    use Symfony\Component\Security\Http\Attribute\IsGranted;

    final readonly class ProfileController
    {
        #[Route('/api/profile', methods: ['GET'])]
        #[IsGranted('IS_AUTHENTICATED')]
        public function getProfile(#[CurrentUser] ApiUser $user): Response
        {
            return new JsonResponse([
                'id' => $user->getOxid(),
                'username' => $user->getUserIdentifier(),
                'roles' => $user->getRoles()
            ]);
        }
    }

Optional Authentication
^^^^^^^^^^^^^^^^^^^^^^^^

To make authentication optional, use nullable type:

|example|

.. code:: php

    #[Route('/api/info', methods: ['GET'])]
    public function getInfo(#[CurrentUser] ?ApiUser $user): Response
    {
        return new JsonResponse([
            'authenticated' => $user !== null,
            'user' => $user ? [
                'id' => $user->getOxid(),
                'username' => $user->getUserIdentifier(),
            ] : null,
        ]);
    }

Available Roles
---------------

The component resolves user roles from OXID's user data:

``ROLE_USER``
    All authenticated users automatically receive this role.

``ROLE_ADMIN``
    Users with OXID admin rights (``OXRIGHTS`` field).

``ROLE_ADMIN_MALL``
    Users with mall admin rights (``OXRIGHTS = 'malladmin'``).

Custom Roles
^^^^^^^^^^^^

You can extend role resolution by decorating the ``RoleResolverInterface``:

|example|

.. code:: php

    <?php

    declare(strict_types=1);

    namespace MyVendor\MyModule\Security;

    use OxidEsales\AuthComponent\Security\User\RoleResolverInterface;

    readonly class CustomRoleResolver implements RoleResolverInterface
    {
        public function __construct(
            private RoleResolverInterface $inner
        ) {
        }

        public function resolveRoles(string $rights): array
        {
            $roles = $this->inner->resolveRoles($rights);

            // Add custom role logic
            $roles[] = 'ROLE_CUSTOM';

            return $roles;
        }
    }

Register the decorator in :file:`services.yaml`:

.. code:: yaml

    MyVendor\MyModule\Security\CustomRoleResolver:
        decorates: OxidEsales\AuthComponent\Security\User\RoleResolverInterface
        arguments:
            $inner: '@.inner'