.. _module_setup_events:

Module Events
==============

The shop dispatches these DI events while a module is set up. Subscribe to them to run code when
your module is activated or deactivated:

- :doc:`FinalizingModuleActivationEvent <FinalizingModuleActivationEvent>`
- :doc:`BeforeModuleDeactivationEvent <BeforeModuleDeactivationEvent>`
- :doc:`FinalizingModuleDeactivationEvent <FinalizingModuleDeactivationEvent>`

Each event carries the module id and the shop id.


Reacting to activation and deactivation
---------------------------------------

This is the supported replacement for the deprecated metadata.php
:ref:`events <metadataphpversion-events-20190911>` (``onActivate`` / ``onDeactivate``).

Register the subscriber in :ref:`bootstrap-services.yaml <module_bootstrap_services>` (not
:file:`services.yaml`), so it is already in the container when your module is activated:

.. code:: yaml

    services:
        MyVendor\MyModule\Setup\ModuleLifecycleSubscriber:
            tags:
                - { name: kernel.event_subscriber }

.. code:: php

    <?php declare(strict_types=1);

    namespace MyVendor\MyModule\Setup;

    use OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Event\BeforeModuleDeactivationEvent;
    use OxidEsales\EshopCommunity\Internal\Framework\Module\Setup\Event\FinalizingModuleActivationEvent;
    use Symfony\Component\EventDispatcher\EventSubscriberInterface;

    final class ModuleLifecycleSubscriber implements EventSubscriberInterface
    {
        private const MODULE_ID = 'myvendor_mymodule';

        public static function getSubscribedEvents(): array
        {
            return [
                FinalizingModuleActivationEvent::class => 'onActivate',
                BeforeModuleDeactivationEvent::class => 'onDeactivate',
            ];
        }

        public function onActivate(FinalizingModuleActivationEvent $event): void
        {
            if ($event->getModuleId() !== self::MODULE_ID) {
                return;
            }

            // your activation logic for $event->getShopId()
        }

        public function onDeactivate(BeforeModuleDeactivationEvent $event): void
        {
            if ($event->getModuleId() !== self::MODULE_ID) {
                return;
            }

            // your deactivation logic for $event->getShopId()
        }
    }

.. important::

    The ``self::MODULE_ID`` guard is required. The subscriber is loaded for every installed
    module, so without it the subscriber would react to the activation and deactivation of *all*
    modules.

Unlike the legacy metadata.php ``onActivate`` handler, the subscriber is a regular service in the
shop container: inject your dependencies through the constructor and use them directly, with no
need to build a separate container.


Migrating from metadata events
------------------------------

Before (metadata.php):

.. code:: php

    'events' => [
        'onActivate'   => '\MyVendor\MyModule\Core\ModuleEvents::onActivate',
        'onDeactivate' => '\MyVendor\MyModule\Core\ModuleEvents::onDeactivate',
    ],

After: remove the ``events`` entry from metadata.php and register the subscriber shown above in
:ref:`bootstrap-services.yaml <module_bootstrap_services>`.

.. note::

    Subscribe ``onDeactivate`` to ``BeforeModuleDeactivationEvent`` to keep the timing of the
    legacy metadata handler, which ran *before* the module was set inactive.
    ``FinalizingModuleDeactivationEvent`` is dispatched afterwards — once the module is already
    inactive and its :file:`services.yaml` import has been removed.


.. toctree::
    :titlesonly:
    :glob:
    :maxdepth: 1

    *
