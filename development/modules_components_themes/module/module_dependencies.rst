.. _dependencies_01:

<<<<<<< HEAD
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
=======
Dependencies between modules
============================

OXID eShop module is provided an option to define dependencies between modules. This means the module with dependencies
can not be activated until the dependencies are activated and vice versa, an active module can not be deactivated if it is a
dependency of an ``active`` module.

.. note::
    Note that, our recommendation is to stick with independent module development and using dependencies between
    modules as a last resort.

Define dependency
-----------------

Defining dependencies between module is quite easy, just follow the following steps:

1. Add ``dependencies.yaml`` file to the root directory of the module

2. Use the following structure in the yaml file:

.. code:: yaml

    modules:
      - <module-1-id>
      - <module-2-id>
>>>>>>> 4efe594 (OXDEV-7338 Add module dependencies)
