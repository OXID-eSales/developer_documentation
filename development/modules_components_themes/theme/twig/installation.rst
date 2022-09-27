Installing the Twig Theme
=========================

Install and activate the Twig theme for the frontend of your OXID eShop.

|prerequisites|

You have installed the Twig engine and the admin Twig theme in your shop.

For more information, see :doc:`Installing the Twig Engine  </development/modules_components_themes/project/twig_template_engine/installation>`.

|procedure|

1. To install OXID eSales `Twig theme <https://github.com/OXID-eSales/twig-theme>`__ for the frontend, perform the following command:

    .. code:: bash

        composer require oxid-esales/twig-theme

#. Under :menuselection:`Extensions --> Themes`, activate the Twig theme.

#. To Clean up the shop compile directory, perform the following command:

   .. code:: bash

      rm -rf source/tmp/*
