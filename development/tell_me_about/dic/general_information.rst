.. _service_container_01:

Using the Service Container
===========================

.. note::
    Watch a short video tutorial on YouTube: `Components & Services <https://www.youtube.com/watch?v=tgopDKPiUZE>`_.

The OXID eShop uses the Symfony DI Container to handle services.
For more information about the DI Container, see the `Symfony DI Container documentation <https://symfony.com/doc/current/components/dependency_injection.html>`_.

.. contents::
    :local:

Service  and its container configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Follow the documentation to find out:

- :doc:`how to create a module service (same instructions can be applied to components) </development/modules_components_themes/module/module_services>`
- :doc:`how to register a module service in the service container </development/modules_components_themes/module/module_services>`
- :doc:`how component services are registered in the service container </development/modules_components_themes/component>`

.. note::

    OXID eShop uses YAML for Symfony DI container configuration and prefers to have :file:`*.yaml` as the file extension for such files:

    - :file:`service.yaml, parameters.yaml` - recommended
    - :file:`service.yml, parameters.yml` - not recommended!

Difference between Module and Component services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **Module**:
    - needs to be installed (for all shops)
    - needs to be activated (for a specific shop)
    - after activation, module's services can be accessed only from the shop in which this module was activated
- **Component**
    - needs to be installed (for all shops)
    - after installation component's services can be accessed from any shop (already existing or created later)


Fetching services from the Container
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2 distinct application areas define the way in which a Service is retrieved from the Container:

- In DI-namespaces:
    - try to stick to the recommended service visibility (all Symfony Services are `private` by default)
    - always use the `Dependency Injection pattern <https://symfony.com/doc/current/service_container.html#injecting-services-config-into-a-service>`_
    - never use the Service Locator (`ContainerFactory` or `ContainerFacade`) here!

    .. code:: php

        class OxidClass
        {
            public function __construct(
                private InjectedServicesInterface $injectedService,
            ) {

- In non-DI-namespaces:
    - service must be declared as `public` to be accessible
    - you can not use Symfony DIC here
    - use the Service Locator (anti) pattern instead

    .. code:: php

        ContainerFacade::get(InjectedServicesInterface::class);

See also examples in :ref:`Module Services <inject_services-20191111>`.
