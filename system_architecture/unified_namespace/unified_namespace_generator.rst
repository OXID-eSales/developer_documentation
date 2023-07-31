.. _unified_namespace_generator_01:

Unified Namespace Generator
===========================

The component `unified-namespace-generator <https://github.com/OXID-eSales/oxideshop-unified-namespace-generator>`__
generates the classes of the namespace ``OxidEsales\Eshop`` which are called
:doc:`unified namespace classes </system_architecture/unified_namespace/index>`.This is done on the fly, e.g. when you install
or update the OXID eShop.

.. _system_architecture_unified_namespace_generator_when_unified_namespace_generated:

When do the unified namespace classes get generated?
----------------------------------------------------

The unified namespace generator implements a composer plugin and a standalone script.
It generates the unified namespace classes on the fly, e.g. when you install or update the OXID eShop:

The generation of unified namespace classes is triggered by running

* :command:`composer create-project` with the OXID eShop metapackage
* :command:`composer install`
* :command:`composer update`. If you want to be sure, to get no errors because of an old version of the
  unified-namespace-generator, first run :command:`composer update --no-plugins --no-scripts` and afterwards
  :command:`composer update`. If you directly execute first :command:`composer update`, you may encounter errors.
  In this case, run again :command:`composer update` and the errors should go away.
* :command:`composer require`.  If you want to be sure, to get no errors because of an old version of the
  unified-namespace-generator, first run :command:`composer require --no-update` and afterwards :command:`composer update`.
* :command:`reset-shop`
* by manually executing :command:`vendor/bin/oe-eshop-unified_namespace_generator`


.. _oxid_eshop_core_unified_namespace_generator-mode_of_operation:

Mode Of Operation
-----------------

Given the example you run the following command:

.. code::

   composer create-project --no-dev oxid-esales/oxideshop-project my_oxid_eshop_project dev-b-6.0-ce

.. todo: #Igor: What is the correct expression? update to oxid 7: "dev-b-7.0-ce"?

By triggering the generation with other commands the steps 1 and 2 can be different.

#. Download and install all libraries to the folder `vendor`
#. oxideshop-unified-namespace-generator is executed by the composer event POST_INSTALL
#. Collect the files :file:`Core/Autoload/UnifiedNamespaceClassMap.php` from each installed edition. Collect the
   file Core/Autoload/BackwardsCompatibilityClassMap.php from OXID eShop Community Edition
#. Generate the unified namespace classes and write them to the folder
   :file:`vendor/oxid-esales/oxideshop-unified-namespace-generator/generated`. There should be one unified namespace class
   for every class in the OXID eShop edition.


Searching for errors
--------------------

If you get either errors

* by calling on of the commands of :ref:`this section <system_architecture_unified_namespace_generator_when_unified_namespace_generated>` or
* you get a message that a unified namespace class could not be found like

.. code::

   Class OxidEsales\Eshop\Core\ConfigFile not found in bootstrap.php on line 18

Then, you should read the following steps in order to find the reason for the error:

1. Have a look at the directory :file:`vendor/oxid-esales/oxideshop-unified-namespace-generator/generated`
2. Are the unified namespace classes inside this directory, have the correct namespace and :ref:`extend the correct edition class <system_architecture-namespaces-inheritance_chain>`?
3. Be sure, the directory has write permissions
4. Execute the command :command:`vendor/bin/oe-eshop-unified_namespace_generator` manually and look for errors
5. Be sure, the requirements as stated in :ref:`Mode Of Operation <oxid_eshop_core_unified_namespace_generator-mode_of_operation>`
   are fulfilled
