Server and system requirements
==============================

OXID eShop can run on different server systems. The choice of a suitable hosting package depends, for example, on the number of products items, the expected number of visitors in the shop and the number of orders. If a small shop with a few hundred products, a few visitors a month and a manageable order volume is sufficient for a shared hosting system, a managed server system should be selected for larger shops. As the load increases, the operation of a server farm with load balancing and a database cluster should be considered. You can find advice and support in choosing the right system from our OXID partners (hosting). These partners provide solutions specially tailored to OXID eShop.

To operate OXID eShop Version 6, the system requirements below must be met. There are some changes to the system requirements for shop versions 4 and 5 including the supported versions for the web server Apache, for the MySQL database and for the server-side scripting and programming language PHP.

Web server
----------

* Apache versions 2.2 and 2.4 (on Linux)
* 500 MB web space needed for Community and Professional Edition
* 750 MB web space needed for Enterprise Edition
* Installed *mod_rewrite* extension

Please note that despite the *mod_rewrite* extension installed, the system health check may not meet the requirements. One reason for this is often the setting for *AllowOverride* in the Apache configuration of vHosts. This was changed to *AllowOverride None* by default with Apache 2.3.9.

Zend Guard Loader is not longer required because OXID eShop 6 isn't encoded anymore.

MySQL
-----

* MySQL 5.5 and 5.7

The database user needs sufficient privileges to create a database during installation if the database does not already exist. Database user also needs the privilege to create views.

The transaction isolation level must be left at the default value *REPEATABLE READ* of the InnoDB Storage Engine.

PHP
---

* PHP versions 7.0 and 7.1
* memory_limit of 60 MB is recommended, at least 32 MB
* PHP setting *session.auto_start* in php.ini should be set “OFF”
* We recommend to enable file uploads in PHP
* Activated allow_url_fopen and fsockopen to port 80
* Set Apache server variables REQUEST_URI or SCRIPT_URI
* ini_set allowed

The following PHP extensions must be installed:

* *GD LIB* version 2.x
* *PDO_MySQL*
* *BC Math*
* *JSON*
* *iconv*
* *tokenizer*
* *mbstring*
* *cURL*
* *SOAP*
* *DOM*

Composer
--------
Composer is required for the installation of OXID eShop and the necessary changes in file autoloading (not for runtime). Please make sure you always use the latest Composer version by running composer self-update. System requirements of Composer can be found here: `https://getcomposer.org/doc/00-intro.md#system-requirements <https://getcomposer.org/doc/00-intro.md#system-requirements>`_.

OpenSSL
-------
OpenSSL is required for the compilation.

* *openssl* >= 1.0.1