Container parameters
====================

You can set parameters within the service container, allowing you to utilize them directly or incorporate them into service definitions. This approach helps to decouple values that are likely to change frequently, making it easier to manage and update your application.
All parameters can be got from container:

Using ContainerFacade:

.. code:: php

    ContainerFacade::getParameter('some_parameter_value')

Using argument binding:

.. code:: yaml

      SomeService:
        arguments:
          - '%some_parameter_value%'


Parameters can be set under

.. code:: yaml

    parameters:
        oxid_custom_parameter: some-value

oxid_build_directory
^^^^^^^^^^^^^^^^^^^^

Directory will be used to compile shop files is set from environment parameter :ref:`OXID_BUILD_DIRECTORY`.

oxid_shop_source_directory
^^^^^^^^^^^^^^^^^^^^^^^^^^

Path to source directory.