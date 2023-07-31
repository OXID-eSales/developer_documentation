Unified or Concrete Class names - which to use and when?
========================================================

Historically, after the introduction of the
`Symfony DependencyInjection Component (DIC) <https://symfony.com/doc/current/components/dependency_injection.html>`__,
OXID eShop code “diverged” into 2 application areas:

- New, “DI” namespaces (e.g. `Internal`)
- “Non-DI”, aka “Traditional” namespaces (e.g. `Core`, `Application`).

DI Namespaces
-------------

.. note::

    Always use concrete class names with DIC!

The Symfony DIC can manage all the "newer" namespaces
(such namespaces can be identified by the presence of `services.yaml` file in their root directory,
see `source/Internal/services.yaml` or similar).

Because DIC functionality "supersedes" the Inheritance Chain there,
we should never use `oxNew()` and Unified Namespaces and stick only to the concrete class names for all classes in DI Namespaces.

  |example| *using the concrete interface name for the injected service*

.. code:: php

    public function __contruct(
        \OxidEsales\EshopCommunity\Internal\ServiceInterface $service
    ) {
        $this->service = $service;
    }

More information:

- :ref:`Service Container <service_container_01>`
- :ref:`Services <services_01>`


Non-Di Namespaces
-----------------

.. note::
    Never use concrete class names with oxNew()!

In the "Traditional" code, using the concrete class names instead of the Unified Namespaces, will circumvent the creation
of the Inheritance Chain and oxNew functionality.
Therefore, using the "real" class names for extendable classes in Non-Di Namespaces is discouraged.

  |example| *using the Unified Namespace for model instantiation*

.. code:: php

    $myModel = oxNew(\OxidEsales\Eshop\Application\Model\MyModel::class);

More information:

- :ref:`Unified Namespace Generator <unified_namespace_generator_01>`
- :ref:`Inheritance chain of Unified Namespace classes <system_architecture-namespaces-inheritance_chain>`
