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

.. code:: bash

  rm -rf source/tmp/*

**4. After twig engine installation**

The twig engine is installed and you should be possible to access administration panel. The next step would be
to install a twig theme for the frontend of your shop, for more information please read
:doc:`Twig theme installation documentation </development/modules_components_themes/theme/twig/installation>`.

**Troubleshooting**

If you are having some issues, that the wrong Admin theme is loaded or you cannot access it, please check
if the `oxid_esales.theme.admin.name` parameter is set correctly in installed component service yaml file
`vendor/oxid-esales/twig-component/services.yaml` or in `var/configuration/configurable_services.yaml`,
if the file exists:

.. code:: yaml

    parameters:
      oxid_esales.theme.admin.name: 'admin_twig'
