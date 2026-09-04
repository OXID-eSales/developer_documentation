.. _module_bootstrap_services:

Bootstrap services
==================

Besides :ref:`services.yaml <services_01>`, a module may provide an optional
:file:`bootstrap-services.yaml` file in its root directory. Services registered there are
loaded for every **installed** module, independently of whether the module is activated.

.. contents::
    :local:


How it differs from services.yaml
---------------------------------

.. list-table::
   :header-rows: 1
   :widths: 25 35 40

   * - File
     - Loaded when
     - Typical content
   * - :file:`services.yaml`
     - the module is **activated**
     - the regular services of the module
   * - :file:`bootstrap-services.yaml`
     - the module is **installed** (also while it is deactivated)
     - services that must exist before or around activation (see below)

When a module is installed, its :file:`bootstrap-services.yaml` is imported into the shop's
generated project services (the same way a component's :file:`services.yaml` is registered), and
removed again on uninstall. It is therefore loaded into the shop container on every request,
regardless of the module's activation state.


When to use it
--------------

Use :file:`bootstrap-services.yaml` only for services that have to be present independently of the
module's activation state:

- **Module lifecycle event subscribers** — react to your own module being activated or
  deactivated. The subscriber has to be in the container already when activation happens, which
  is only possible from :file:`bootstrap-services.yaml`. See
  :ref:`Module Events <module_setup_events>`.
- **Tagged migration path providers** — expose your module's migrations so they can be run
  before the module is activated (see :ref:`Database Migration <module_migrations>`).


When not to use it
------------------

.. warning::

    Services declared in :file:`bootstrap-services.yaml` are loaded even while the module is
    **deactivated**. Do not put the regular functionality of your module there — a deactivated
    module must not influence the shop. Regular services belong in :ref:`services.yaml
    <services_01>`, which is only loaded while the module is active.


Registering a service
----------------------

Services are registered exactly as in :ref:`services.yaml <services_01>`, but in the
:file:`bootstrap-services.yaml` file in the module root. For example, a module lifecycle event
subscriber:

.. code:: yaml

    services:
        _defaults:
            public: false
            autowire: true

        MyVendor\MyModule\Setup\ModuleLifecycleSubscriber:
            tags:
                - { name: kernel.event_subscriber }

.. note::

    A service registered here runs for every installed module, so it must stay inert until its
    trigger. A lifecycle subscriber must ignore events that belong to other modules — see
    :ref:`Module Events <module_setup_events>` for a complete example.
