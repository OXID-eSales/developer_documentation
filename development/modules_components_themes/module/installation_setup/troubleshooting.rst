Troubleshooting
===============

.. _module-does-not-install-using-composer :

Module does not install using composer
--------------------------------------
When you are using composer to install or update a module and you notice, that the module is not properly :doc:`installed </development/modules_components_themes/module/installation_setup/installation>`,
there are two types of situations un which you may encounter this issue:

- Shop configuration file is removed from `var/configuration/shops/` directory or `/var` directory is removed.

Solution
^^^^^^^^

.. uml::

   @startuml

   start

   if (Module is visible in admin area?) then (no)

      if (Is var/configuration/shops/1/ directory exists?) then (yes)

          if (is module configuration exists in var/configuration/shops/1/modules/<module-id>.yaml?) then (yes)

          else (no)
             :run console install module;
          endif

      else (no)

        :run composer update;

        :var/configuration/shops/1/modules/<module-id>.yaml file will be created;

      endif

   else (yes)

   endif

   :module is installed;

    stop

   @enduml

.. Note::

    Please check :doc:`modules configuration and setup document </development/modules_components_themes/project/module_configuration/modules_configuration>`
    for getting more information regarding shop configuration files ( `var/configuration/shops/` ) and how to generate them.

.. Note::

    How to run install module command?

     .. code:: bash

        vendor/bin/oe-console oe:module:install <module sourcecode path>
