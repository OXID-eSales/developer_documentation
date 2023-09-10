.. _dependencies_01:

Defining dependencies between modules
=====================================

Define dependencies between modules.

.. todo: #DK/#HR: What is the use case? What problem does the option solve? "Use this option if ..."

This means that the module with dependencies cannot be activated until the dependent modules are activated.

Conversely, an active module cannot be deactivated if it depends on an active module.

.. todo: #DK/#HR: "the module with dependencies can not be activated until the dependencies are activated" sounds circular. Do we mean (in the example below), I have to activate module-2-id before I can activate module-1-id, so module-1-id is the "depending module"? Somehow, I have to begin activating one module or the other, correct?

.. note::
    We recommend developing independent modules and using dependencies between modules as a last resort only.

|procedure|

To define dependencies between modules, perform the following steps:

1. Add a ``dependencies.yaml`` file to the root directory of the module.
#. In the yaml file, define the dependency as follows.

   In our example, <module-1-id> is the depending module that can only be activated or deactivated if <module-2-id> has been activated or deactivated before.

   .. code:: yaml

      modules:
        - <module-1-id>
        - <module-2-id>
