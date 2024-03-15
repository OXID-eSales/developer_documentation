Troubleshooting
===============

I am asked for a github token
---------------------------------------------------

By default github has API access limits set for anonymous access. In order to overcome these limits one has to create a github token, which could be done as described in: https://help.github.com/articles/creating-an-access-token-for-command-line-use/


I get a Composer\\Downloader\\TransportException
------------------------------------------------

During the installation of OXID eShop Professional or Enterprise Edition you get the following error:

::

  [Composer\Downloader\TransportException]
  Invalid credentials for 'https://enterprise-edition.packages.oxid-esales.com/packages.json', aborting.


You may have stored some outdated or wrong credentials. Please review <your home directory>/.composer/auth.json and
delete the section, which begins with "professional-edition.packages.oxid-esales.com" resp. "enterprise-edition.packages.oxid-esales.com"


I am asked "Do you want to remove the existing VCS (.git, .svn..) history? [Y,n]"
---------------------------------------------------------------------------------

In general you can say "Yes". It is not normally important to keep VCS history locally. You can always look it up on github.


There was an error during the execution of the unified namespace generator
--------------------------------------------------------------------------

If the generation of the `unified namespace classes` fails, OXID eShop will not run properly.
In this case you should look :doc:`here</system_architecture/unified_namespace/unified_namespace_generator>` for possible fixes.

PHP8 requests result in empty index.php sent to user
------------------------------------------------------------

If Apache incorrectly responds to certain requests with

.. code:: shell

    - Content-Length = 0
    - HTTP response status code = "200 OK"

but works normally for other pages - please make sure the following does not apply to your setup:

    - `Apache2`
    - `mod_proxy_fcgi`
    - `PHP8`
    - `PHP-FPM`

Otherwise you may try to resolve the issue by letting `PHP-FPM` manage `PHP error logs` instead of sending them to `Apache`.
e.g. by setting:

.. code:: shell

        /usr/local/etc/php-fpm.d/www.conf

        php_admin_value[error_log] = /var/log/fpm-php.www.log
        php_admin_flag[log_errors] = on


Installing or updating a module fails
-------------------------------------

If you have installed the :productname:`OXID eShop Enterprise Edition` using the metapackage, to install a module, you use the default path.

Example (graphql):

   .. code:: bash

      vendor/bin/oe-console oe:module:install-configuration source/modules/oe/graphql-base
      vendor/bin/oe-console oe:module:install-configuration source/modules/oe/graphql-storefront

However, if installing a module (graphql, in the following example) fails, you might have, for example, installed the Community Edition as a root package and later upgraded to the Enterprise Edition.

In this case, try the following path:

.. code:: bash

   bin/oe-console oe:module:install-configuration source/modules/oe/graphql-base
   bin/oe-console oe:module:install-configuration source/modules/oe/graphql-storefront


Analogously, when updating modules, perform the commands to migrate the database and clear the cache as follows:

.. code:: bash

   bin/oe-eshop-db_migrate migrations:migrate

.. code:: bash

   bin/oe-console oe:cache:clear