Installing the Twig Engine
==========================

Install the Twig template engine and the Twig admin theme in your OXID eShop.

|procedure|

1. Install the OXID eSales Twig components.

   To do so, install the `OXID eShop Twig component <https://github.com/OXID-eSales/twig-component>`__ which includes the Twig engine.

   * If you have the OXID eShop Community Edition, perform the following command:

      .. code:: bash

         composer require oxid-esales/twig-component

   * If you have the OXID eShop OXID eShop Professional Edition, perform the following commands:

      .. code:: bash

         composer require oxid-esales/twig-component
         composer require oxid-esales/twig-component-pe

   * If you have the OXID eShop Enterprise Edition, perform the following commands:

     .. code:: bash

        composer require oxid-esales/twig-component
        composer require oxid-esales/twig-component-pe
        composer require oxid-esales/twig-component-ee

#. Install the `admin Twig theme for the administration panel <https://github.com/OXID-eSales/twig-admin-theme>`__.

   To do so, perform the following command:

   .. code:: bash

      composer require oxid-esales/twig-admin-theme


#. Clean up the shop compile directory.

   .. code:: bash

      rm -rf source/tmp/*

   The Twig engine is installed.

#. Check if you can access the administration panel.

   If the wrong Admin theme is loaded or you cannot access it, in the component service yaml file :file:`vendor/oxid-esales/twig-component/services.yaml` or in :file:`var/configuration/configurable_services.yaml`, ensure that the :code:`oxid_esales.theme.admin.name` parameter is set as follows:

   .. todo: #Vasyl: what do we mean with "if the file exists:"? The configurable_services.yaml file or the other one? If one of the files doesn't exist, what am I supposed to do?

   .. code:: yaml

       parameters:
         oxid_esales.theme.admin.name: 'admin_twig'

.. todo: insert picture to illustrate the Twig admin theme

In the next step, install a Twig theme for the frontend of your shop.

For more information, see :doc:`Twig theme installation documentation </development/modules_components_themes/theme/twig/installation>`.
