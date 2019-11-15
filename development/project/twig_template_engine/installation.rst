Twig Installation
=================

Follow these steps to include twig template engine in OXID eShop:

**1. Install OXID eSales twig components**

First you have to install `OXID eShop twig component <https://github.com/OXID-eSales/twig-component>`__ which includes twig engine:

.. code:: bash

    composer require oxid-esales/twig-component


* (Only for PE) Install OXID eSales twig component for PE

    If you are using Professional Edition, please install Twig component for OXID eShop Professional Edition:

    .. code:: bash

        composer require oxid-esales/twig-component-pe


* (Only for EE) Install OXID eSales twig component for EE

    If you are using Enterprise Edition, please install Twig component for OXID eShop Enterprise Edition:

    .. code:: bash

        composer require oxid-esales/twig-component-ee


**2. Install admin twig theme**

We also recommend to install `the twig theme for the admin area <https://github.com/OXID-eSales/twig-admin-theme>`__:

.. code:: bash

    composer require oxid-esales/twig-admin-theme

.. Note::

    The twig theme for admin will be registered during the installation. If you are having some issues, that the wrong Admin
    theme is loaded, please check if the `oxid_esales.theme.admin.name` parameter is set correctly:

    .. code:: yaml

        parameters:
          oxid_esales.theme.admin.name: 'admin_twig'

**3. Install and activate OXID eSales twig theme**

* Install `the twig theme <https://github.com/OXID-eSales/twig-theme>`__ for the frontend, for example:

    .. code:: bash

        composer require oxid-esales/twig-theme

* Activate the twig theme through OXID eShop admin panel:

    Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`,
    select a twig theme and click activation button.
