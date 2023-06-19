Twig Engine Installation
========================

This tutorial explains how to install twig template engine and twig admin theme on OXID eShop.

**1. Install OXID eSales twig components**

* Installation of the component for OXID eShop Community Edition

    You have to install `OXID eShop twig component <https://github.com/OXID-eSales/twig-component>`__ which
    includes twig engine:

    .. code:: bash

        composer require oxid-esales/twig-component

* Installation of the component for OXID eShop Professional Edition

    If you are using Professional Edition, please install twig component for OXID eShop Professional Edition:

    .. code:: bash

        composer require oxid-esales/twig-component-pe

* Installation of the component for OXID eShop Enterprise Edition

    If you are using Enterprise Edition, please install twig component for OXID eShop Enterprise Edition:

    .. code:: bash

        composer require oxid-esales/twig-component-ee

**2. Install admin twig theme**

To access admin panel please install `the twig theme for the admin area <https://github.com/OXID-eSales/twig-admin-theme>`__:

.. code:: bash

    composer require oxid-esales/twig-admin-theme


**3. Clean up the shop compile directory**

To do so, in the root directory of the shop (``/oxideshop``), execute the console command depending on how you have installed the OXID eShop Edition:

* If you have installed your OXID eShop Professional or Enterprise Edition with the metapackage, use the standard path:

  .. code:: bash

     vendor/bin/oe-console oe:cache:clear

* If you have installed the Community Edition as root package and upgraded to the Professional or Enterprise Edition, use the following path:

  .. code:: bash

     bin/oe-console oe:cache:clear

If you are not sure, try the standard path first.

**4. After twig engine installation**

The twig engine is installed and you should be possible to access administration panel.

In the next step, install a twig theme for the frontend of your shop.

.. todo: Igor: the following doc doesn't exist:
        For more information, see :doc:`Twig theme installation documentation </development/modules_components_themes/theme/twig/installation>`.

.. todo: #Igor/#tbd: Schritt 4. entfernen: #Igor: check: can we remove the step?  APEX theme is delivered with oxid 7, not the twig theme
.. todo: #Igor: can we remove Troubleshooting?: this section looks like only relevant for 6.5.x. twig admin theme is delivered with oxid 7 compilation

**Troubleshooting**

If you are having some issues, that the wrong Admin theme is loaded or you cannot access it, please check
if the `oxid_esales.theme.admin.name` parameter is set correctly in installed component service yaml file
`vendor/oxid-esales/twig-component/services.yaml` or in `var/configuration/configurable_services.yaml`,
if the file exists:

.. code:: yaml

    parameters:
      oxid_esales.theme.admin.name: 'admin_twig'
