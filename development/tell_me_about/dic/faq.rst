Service Container Troubleshooting and FAQs
==========================================

.. contents::
    :local:


FAQs:
-----

Should I override or decorate services in my Project?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When overriding a Symfony Service, you replace the whole service definition in such a way that the original
service is lost. Although there might be use-cases for such drastic modification,
whenever you just need to extend the existing functionality, you should use the less destructive
`Decorator Pattern <https://symfony.com/doc/current/service_container/service_decoration.html>`_ instead

Cane I reconfigure a public service as private in my Project?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Technically yes, but it's better to avoid changing visibility of the service from `public` to `private`.
Such configuration modification will make this service inaccessible via the Service Locator pattern
E.g. this code in one of the modules:

.. code:: php

 ContainerFacade::get(\OxidEsales\Internal\OxidPublicService::class)->doSomething();

that was working before, will start throwing a `ServiceNotFound` exception after the change!

Troubleshooting guide:
----------------------

I deactivated my module in the Admin and want to refresh the application caches
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:Problem:
    Programmatic configuration change.
:Description:
    Every critical configuration change in the application triggers its full Container Cache rebuild automatically.
:Solution:
    No additional user interaction is normally needed.

----------

I changed var/configuration YAML manually and want to refresh the application caches
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Problem:
    Manual configuration change.
Description:
    Despite the configuration change, the application (Service Container) is still functional.
Solution:
    Cache can be cleared manually by executing the following command:

       .. code:: bash

         vendor/bin/oe-console oe:cache:clear

----------

I've made some manual configuration change and now oe:cache:clear console command is broken (an error occurs)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Problem:
    Application malfunction.
Description:
    Cached version of Service Container contains references to non-existing services, etc.
Solution:
    Cache can be cleared by removing the corresponding :file:`container_cache_*.php` file in the OXID eSales' build directory:

       .. code:: bash

         rm /var/www/var/cache/container/container_cache_shop_1.dev.php
