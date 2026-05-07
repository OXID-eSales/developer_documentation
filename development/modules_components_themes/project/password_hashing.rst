Configure password hashing
==========================

How does OXID eShop hash passwords?
-----------------------------------

By default, OXID eShop hashes passwords with the bcrypt algorithm. On a users login, OXID eShop converts all password
hashes with the current algorithm and options.

.. note::
    As of OXID eShop 7.6, the default bcrypt cost was increased to improve resistance against brute-force attacks.
    Existing password hashes are transparently rehashed with the new cost on the user's next login.

.. note::
    The password salt is included by default in the database table ``oxuser`` in the column ``OXPASSWORD``.
    It is not stored separately in the column ``OXPASSSALT`` any more.


Why should I configure password hashing?
----------------------------------------

Security is only a relative term. You should make sure, that your system is as secure as possible. For password
hashing, security is dependent e.g. on the performance of your server hardware and the PHP version. See the
section below for details.

How can I configure password hashing?
-------------------------------------

In this section we describe how to choose an already implemented password hashing algorithms and configure
it.

Currently there are two different algorithms for hashing passwords available in the OXID eShop:

* Bcrypt (Supported from PHP 7.0 on)
* Argon2I (Deprecated since OXID eShop 7.6)

Bcrypt has the configuration option ``oxid_esales.utility.hash.service.password_hash.bcrypt.cost``.
The minimum cost is 4, the default is 12, and the maximum is 31.

The option is directly coupled to the option of the PHP method ``password_hash``. See the
`PHP documentation for details on the options <https://www.php.net/manual/en/function.password-hash.php>`__.

Configure the option to require as much computing time as possible but not so much as to annoy a user when logging in.

.. warning::

    ``Argon2IPasswordHashService`` is deprecated since OXID eShop 7.6. Switch to the default bcrypt algorithm,
    or provide your own implementation — see `How can I hash passwords by my own implementation?`_ below.

After changing the configuration, you have to delete the container cache.

How can I hash passwords by my own implementation?
--------------------------------------------------
If you want to implement password hashing by your own, you have to implement the interfaces:

- ``OxidEsales\EshopCommunity\Internal\Utility\Hash\Service\PasswordHashServiceInterface``,
- ``OxidEsales\EshopCommunity\Internal\Domain\Authentication\Service\PasswordVerificationServiceInterface``

Then use ':ref:`How to Replacing OXID eShop services <how_to_replace_shop_services-20854932>`' guide to override the OXID eShop default services.