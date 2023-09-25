.. _dependencies_01:

Defining dependencies between modules
=====================================

Define dependencies between modules, if required.

Use this option if you have a base module with core functionalities which are mandatory to be active for other modules to work.

This means that the module with dependencies cannot be activated until the dependent modules are activated.

Conversely, an active module cannot be deactivated if it depends on an active module.

.. note::
    We recommend developing independent modules and using dependencies between modules as a last resort only.

|procedure|

To define dependencies between modules, perform the following steps:

#. Add a ``dependencies.yaml`` file to the root directory of the module.

    ::

        └── <module-with-dependencies>
            └── dependencies.yaml

#. In the yaml file, define the dependency(s) as follows.

    .. code:: yaml

      modules:
        - <module-1-id>
        - <module-2-id>

    In our example, ``<module-with-dependencies>`` has 2 dependencies:

        * <module-1-id>
        * <module-2-id>

|result|

To be able to activate ``<module-with-dependencies>``, you must first activate <module-1> and <module-2>.

To be able to deactivate <module-1> and/or <module-2>, you must first deactivate <module-with-dependencies>.