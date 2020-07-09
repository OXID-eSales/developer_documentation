Troubleshooting
===============

.. _module-does-not-install-using-composer :

Module does not install using composer
--------------------------------------
When you are using composer install or update module then you notice module is not :doc:`installed </development/modules_components_themes/module/installation_setup/installation>`, there are two types of situation that you may encounter this issue:

- Shop configuration file is removed from `var/configuration/shops/` directory or `/var` directory is removed.

- you have already a module in your `source/modules` directory but you do not see your module configuration inside shop configuration yaml file in `var/configuration/shops/`.

Solution
^^^^^^^^

.. uml::

   @startuml

   start

   if (Module is visible in admin area?) then (no)

      if (Is var/configuration/shops/1.yaml file exists?) then (yes)

          if (is module configuration exists in var/configuration/shops/1.yaml?) then (yes)

          else (no)
             :run console install module configuration;
          endif

      else (no)

        :run composer update;

        :var/configuration/shops/1.yaml file will be created;

        :run console install module configuration command;

      endif

   else (yes)

   endif

   :module is installed;

    stop

   @enduml

.. Note::

    Please check :doc:`modules configuration and setup document </development/modules_components_themes/project/module_configuration/modules_configuration>`
    for getting more information regarding shop configuration files ( `var/configuration/shops/1.yaml` ) and how to generate them.

.. Note::

    How to run install module configuration command?

     .. code:: bash

        vendor/bin/oe-console oe:module:install-configuration <module sourcecode path>
