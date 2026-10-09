Session Authentication
======================

The Session Authentication component protects AJAX endpoints where the user
already has an active OXID session in the browser.

Installation
------------

.. code:: bash

    composer require oxid-esales/session-authentication-component

Frontend Endpoints
------------------

Add ``#[SessionUser]`` to require an active frontend session:

|example|

.. code:: php

    use OxidEsales\SessionAuthComponent\Security\Attribute\SessionUser;
    use Symfony\Component\HttpFoundation\JsonResponse;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Attribute\Route;

    readonly class WishlistController
    {
        #[Route('/api/wishlist', methods: ['GET'])]
        #[SessionUser]
        public function getWishlist(Request $request): Response
        {
            $user = $request->attributes->get('_user');

            return new JsonResponse([
                'username' => $user->getUserIdentifier(),
            ]);
        }
    }

Admin Endpoints
---------------

Add ``#[AdminSessionUser]`` to require an active admin session:

|example|

.. code:: php

    use OxidEsales\SessionAuthComponent\Security\Attribute\AdminSessionUser;

    #[Route('/api/admin/dashboard', methods: ['GET'])]
    #[AdminSessionUser]
    public function getDashboard(Request $request): Response
    {
        $user = $request->attributes->get('_user');
        // ...
    }

Use ``roles`` to restrict to specific admin roles:

|example|

.. code:: php

    #[AdminSessionUser(roles: ['ROLE_ADMIN_MALL'])]
    public function createShop(Request $request): Response
    {
        // Only mall admins
    }

Roles
-----

``ROLE_ADMIN``
    Shop admins.

``ROLE_ADMIN_MALL``
    Mall admins (access across all subshops).

