Twig Theme Installation
=======================

This tutorial explains how to install and activate twig theme on OXID eShop.

.. note:: Twig engine and Apex theme come with the :ref:`OXID eShop compilation <glossary-oxid_compilation>`.

**1. Before you install Apex theme**

First make sure, that the twig engine and the admin twig theme are installed on your shop. If not, use the following tutorial:
:doc:`Twig Engine Installation </development/modules_components_themes/project/twig_template_engine/installation>`

**2. Install OXID eSales Apex theme**

Install `the twig theme <https://github.com/OXID-eSales/apex-theme>`__ for the frontend, for example:

    .. code:: bash

        composer require oxid-esales/apex-theme

**3. Activate the apex theme through OXID eShop admin panel**

Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`, select the Apex theme
and click activation button.

**4. Clean up the shop compile directory**

   .. code:: bash

      ./vendor/bin/oe-console oe:cache:clear
