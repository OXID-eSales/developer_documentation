Modules installation
====================

This document describes **what** is happening under the hood when module is being installed.
To find out **how** to install a module, please have a look to
:doc:`module installation documentation</modules/installation_setup/installation>`.

Installation workflow
---------------------

Whole installation workflow can be seen in image bellow:

.. uml::

    @startuml

    (*)--> "User executes \n <i>composer require/install</i> \nfor module"
    --> "Module files are downloaded"
    --> "Module files are copied \n to modules directory"
    --> "configuration file is updated  "
    --> (*)

    @enduml

Workflow in details
^^^^^^^^^^^^^^^^^^^

Composer install step
"""""""""""""""""""""

In this step user executes composer command to install module.

Files download step
"""""""""""""""""""

When composer installation command is executed, composer downloads files
to `vendor` directory.

Module files are copied
"""""""""""""""""""""""

This is the step composer triggers
`OXID eShop composer plugin <https://github.com/OXID-eSales/oxideshop_composer_plugin>`__ which executes
module files copying from `vendor` directory to `source/modules` directory so OXID eShop could access all module
files.

Configuration files updated
"""""""""""""""""""""""""""

During this step the data from module `metadata.php` are transferred to configuration files, which are located in
`var/configuration/shops/`.
