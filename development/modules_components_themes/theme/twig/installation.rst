Twig Theme Installation
=======================

This tutorial explains how to install and activate twig theme on OXID eShop.

**1. Before you install twig theme**

First make sure, that the twig engine and the admin twig theme are installed on your shop. If not, use the following tutorial:
:doc:`Twig Engine Installation </development/modules_components_themes/project/twig_template_engine/installation>`

**2. Install OXID eSales twig theme**

    .. code:: bash

        composer require oxid-esales/twig-theme

**3. Activate the twig theme through OXID eShop admin panel**

Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`, select a twig theme
and click activation button.

**4. Clean up the shop compile directory**

To do so, in the root directory of the shop (``/oxideshop``), execute the console command depending on how you have installed the OXID eShop Edition:

* If you have installed your OXID eShop Professional or Enterprise Edition with the metapackage, use the standard path:

  .. code:: bash

     vendor/bin/oe-console oe:cache:clear

* If you have installed the Community Edition as root package and upgraded to the Professional or Enterprise Edition, use the following path:

  .. code:: bash

     bin/oe-console oe:cache:clear

If you are not sure, try the standard path first.

