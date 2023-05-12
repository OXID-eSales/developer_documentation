Twig Theme Installation
=======================

This tutorial explains how to install and activate twig theme on OXID eShop.

.. todo: #Igor:  please mention that in oxid 7.0 twig engine comes with the compilation. So this section is only relevant when not using compilation: Note: Muss nich manuell: Twig automatisch mit 7: manual steps now apply for Smarty installation: shall we document smarty installation in detail?

**1. Before you install twig theme**

First make sure, that the twig engine and the admin twig theme are installed on your shop. If not, use the following tutorial:
:doc:`Twig Engine Installation </development/modules_components_themes/project/twig_template_engine/installation>`

**2. Install OXID eSales twig theme**
.. todo:  #Igor: as above: APEX is the official theme now Install `the twig theme <https://github.com/OXID-eSales/twig-theme>`__ for the frontend, for example:


    .. code:: bash

        composer require oxid-esales/twig-theme

**3. Activate the twig theme through OXID eShop admin panel**

Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`, select a twig theme
and click activation button.

**4. Clean up the shop compile directory**

   .. code:: bash

      rm -rf source/tmp/*

  .. todo:  #tbd: use console oe:cache:clear instead: as above: standard dep. on installation

