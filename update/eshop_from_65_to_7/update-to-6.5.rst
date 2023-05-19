Updating to OXID eShop 6.5
==========================

If you have OXID eShop 6.4 or lower, before updating to version 7.0, update to OXID eShop 6.5 first.

To do so, check the following:

* Do I need to do one or more incremental updates?
  |br|
  Incremental update means: You do not make an update directly to OXID eShop version 7 but in a previous step you make an update to a version between your initial version and OXID eShop version 7.
  |br|
  Only in a following update you do the update from the intermediate version to OXID eShop version 7.
* During the update or incremental update, do I have a version of :emphasis:`Composer` that supports both my respective source and target versions?
* When updating or incrementally updating, do I have a version of :emphasis:`PHP` that supports both my respective source and target versions?

|procedure|

Check step by step which incremental update you need to do to finally get to OXID eShop version 7.

In doing so, before each update step, make sure that you have versions of Composer and PHP that are supported by both the source and target versions.

1. If you have OXID eShop version 5.x or lower, follow the instructions at `docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html <https://docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/index.html>`_.
   |br|
   Alternatively: install the latest version of OXID eShop and port only the important data.

   .. note::

      **Porting the modules**

      Your modules do not work under OXID eShop version 6 anymore.

      To learn how to port your modules to OXID eShop version 6, see https://docs.oxid-esales.com/developer/en/6.0/modules/tutorials/porting_tool.html.

   .. note::

      **Azure theme obsolete**

      The Azure theme is still supported in OXID eShop version 6, but is no longer maintained.

#. If you have OXID eShop version :emphasis:`6.0.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.0.
   #. Do an initial update from version 6.0.x to version 6.1.x.
      |br|
      For more information, visit https://docs.oxid-esales.com/eshop/de/6.1/installation/update-installation/update-installation.html

#. If you have OXID eShop version :emphasis:`6.1.x`, do the following:

   a. Make sure you have Composer version 1.
   #. Make sure you have PHP version 7.1.
   #. Update from version 6.1.x to version 6.2.4.
      |br|
      For more information, please visit https://docs.oxid-esales.com/eshop/de/6.2/installation/update/von-6.1.x-auf-6.2.0-aktualisieren.html

#. If you have OXID eShop version :emphasis:`6.2.0`, :emphasis:`6.2.1` or :emphasis:`6.2.2`, do the following:

   a. Make a patch update to OXID eShop version :emphasis:`6.2.4`.
   #. Optional: Make an update to from PHP version 7.1 to version 7.4.
      |br|
      Alternatively: Make the update to PHP version 7.4 on the following OXID eShop updates.
   #. Make an update from Composer version 1 to Composer version 2.

#. If you have OXID eShop version :emphasis:`6.2.3` or :emphasis:`6.2.4`, do the following:

   a. Make sure you have Composer version 2.0 to 2.2.x.

      .. attention::

         Composer version 2.3.x is not supported.

         For example, if you have Composer version 2.3.x, install Composer version 2.2.x as follows:

         .. code:: bash

            composer selfupdate 2.2.12

   #. Make sure you have PHP version 7.4.
   #. Update from version 6.2.5 to version 6.5.

      .. code:: bash

         composer require --no-update oxid-esales/oxideshop-metapackage-ce:v6.5.2

         composer update --no-plugins --no-scripts --no-dev

#. If you have OXID eShop version 6.2.5 or higher, update to version 6.5:

   a. Make sure you have Composer version 2.4.
   #. Make sure you have PHP version 8.0.
   #. Update to version 6.5:

      .. code:: bash

         composer require --no-update oxid-esales/oxideshop-metapackage-ce:v6.5.2

         composer update --no-plugins --no-scripts --no-dev
