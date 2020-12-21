Modules installation
====================

This document describes **what** is happening under the hood when module is being installed.
To find out **how** to install a module, please have a look to
:doc:`module installation documentation</development/modules_components_themes/module/installation_setup/installation>`.

Installation workflow
---------------------

Whole installation workflow can be seen in image bellow:

.. uml::

    @startuml

    (*)--> "User executes \n <i>composer require/install</i> \nfor module"
    --> "Module files are downloaded"
    --> "Module assets are linked to the shop out directory"
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

Configuration files updated
"""""""""""""""""""""""""""

During this step the data from module `metadata.php` are transferred to configuration files, which are located in
`var/configuration/shops/`.

Module assets are linked to the public directory
""""""""""""""""""""""""""""""""""""""""""""""""

During this step files from `<module-root-directory>/assets` are linked to the shop public directory `source/out/modules/<module-id>`.

