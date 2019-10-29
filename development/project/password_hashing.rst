Configure password hashing
==========================

How does OXID eShop hash passwords?
-----------------------------------

By default, OXID eShop hashes passwords with the bcrypt algorithm. On a users login, OXID eShop converts all password
hashes with the current algorithm and options.

.. note::
    The password salt is included by default in the database table ``oxuser`` in the column ``OXPASSWORD``.
    It is not stored separately in the column ``OXPASSSALT`` any more.


Why should I configure password hashing?
----------------------------------------

Security is only a relative term. You should make sure, that your system is as secure as possible. For password
hashing, security is dependet e.g. on the performance of your server hardware and the PHP version. See the
section below for details.

How can I configure password hashing?
-------------------------------------

In this section we describe how to choose an already implemented password hashing algorithms and configure
it.

Currently there are two different algorithms for hashing passwords available in the OXID eShop:

* Bcrypt (Supported from PHP 7.0 on)
* Argon2I (Support from PHP 7.2 on)

Choose the best hash algorithm supported by your PHP version. Brypt has the configuration option
``oxid_esales.authentication.service.password_hash.bcrypt.cost``. The minimum cost is 4, maximum cost 31.
Argon2I has the configuration options ``oxid_esales.authentication.service.password_hash.argon2.memory_cost``,
``oxid_esales.authentication.service.password_hash.argon2.time_cost`` and
``oxid_esales.authentication.service.password_hash.argon2.threads``.

The options are directly coupled to the options of the PHP method ``password_hash``. See the
`PHP documentation for details on the options <https://www.php.net/manual/en/function.password-hash.php>`__.

Configure the options to require as much computing time as possible but not so much as to annoy a user when logging in.

An example how to change the algorithm to Argon2I and configure its options:

.. code-block:: php
   :caption: var/configuration/configurable_services.yaml

    parameters:
      oxid_esales.authentication.service.password_hash.argon2.memory_cost: 1024
      oxid_esales.authentication.service.password_hash.argon2.time_cost: 2
      oxid_esales.authentication.service.password_hash.argon2.threads: 2

    services:
      OxidEsales\EshopCommunity\Internal\Authentication\Service\PasswordHashServiceInterface:
        class: OxidEsales\EshopCommunity\Internal\Authentication\Service\Argon2IPasswordHashService
        arguments:
          - '@OxidEsales\EshopCommunity\Internal\Authentication\Policy\PasswordPolicyInterface'
          - '%oxid_esales.authentication.service.password_hash.argon2.memory_cost%'
          - '%oxid_esales.authentication.service.password_hash.argon2.time_cost%'
          - '%oxid_esales.authentication.service.password_hash.argon2.threads%'



After changing the configuration, you have to delete the container cache.

How can I hash passwords by my own implementation?
--------------------------------------------------

If you want to implement password hashing by your own, you have to implement the interfaces
``OxidEsales\EshopCommunity\Internal\Authentication\Service\PasswordHashServiceInterface``,
``OxidEsales\EshopCommunity\Internal\Authentication\Service\PasswordVerificationServiceInterface`` and
exchange the OXID eShop default services by your implementation in the file
:file:`var/configuration/configurable_services.yaml`.