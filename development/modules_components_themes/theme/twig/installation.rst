Twig Theme Installation
=======================

This tutorial explains how to install and activate twig theme on OXID eShop.

**1. Before you install twig theme**

First make sure, that the twig engine and the admin twig theme are installed on your shop. If not, use the following tutorial:
:doc:`Twig Engine Installation </development/modules_components_themes/project/twig_template_engine/installation>`

**2. Install OXID eSales twig theme**

Install `the twig theme <https://github.com/OXID-eSales/twig-theme>`__ for the frontend, for example:

    .. code:: bash

        composer require oxid-esales/twig-theme

**3. Activate the twig theme through OXID eShop admin panel**

Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`, select a twig theme
and click activation button.

**4. Clean up the shop compile directory**

   .. code:: bash

      rm -rf source/tmp/*
