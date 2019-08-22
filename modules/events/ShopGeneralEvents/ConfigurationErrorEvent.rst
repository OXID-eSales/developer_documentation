ConfigurationErrorEvent
=======================

Namespace:

.. code-block:: php

	Namespace: OxidEsales\EshopCommunity\Internal\Application\Events\ConfigurationErrorEvent

This is a generic event that should never be dispatched as itself. This event should
be subclassed for various configuration errors (an example is the `ServicesYamlConfigurationErrorEvent`).
This parent class defines an error level that can be called with `getErrorLevel()`. This error level
may for example be mapped to a log level.