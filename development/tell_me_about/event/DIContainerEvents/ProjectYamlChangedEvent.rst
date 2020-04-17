ProjectYamlChangedEvent
=======================

Namespace:

.. code-block:: php

	Namespace: OxidEsales\EshopCommunity\Internal\Application\Events\ProjectYamlChangedEvent

This event will be dispatched after the generated services file for the DI container has changed.
This happens when a module that has its own `services.yaml` file is activated, for example.

Usage example: Reset the DI container when the `generated_services.yaml` file changes (there
is probably no other use case).
