Installation
============

To have a working twig engine, you need to pass few steps which are described bellow.

**1. Install OXID eSales twig components:**

First you have to install OXID eSales twig component which includes twig engine and we also recommend to install the
twig theme for the admin area:

.. code:: bash

    composer require oxid-esales/twig-component
    composer require oxid-esales/twig-admin-theme

**2. (Only for PE) Install OXID eSales twig module:**

If you are using Professional Edition, please install and activate Twig module for OXID eShop Professional Edition:

.. code:: bash

    composer require oxid-esales/twig-module-pe
    oe-console oe:module:install-configuration source/modules/oe/twigprofessional
    oe-console oe:module:activate oetwigprofessional

**2. (Only for EE) Install OXID eSales twig module:**

If you are using Enterprise Edition, please install and activate Twig module for OXID eShop Enterprise Edition:

.. code:: bash

    composer require oxid-esales/twig-module-ee
    bin/oe-console oe:module:install-configuration source/modules/oe/twigenterprise
    bin/oe-console oe:module:activate oetwigenterprise

**4. Install OXID eSales twig theme:**


Install the twig theme for the frontend, for example:

.. code:: bash

    composer require oxid-esales/twig-theme

**5. Activate the twig theme through OXID eShop admin panel:**

Open OXID eShop administration panel and go to :menuselection:`Extensions --> Themes`,
select a twig theme and click activation button.

.. Note::

    The twig theme for admin will be registered during the installation. If you are having some issues, that the wrong Admin
    theme is loaded, please check if the `oxid_esales.theme.admin.name` parameter is set correctly:

    .. code:: yaml

        parameters:
          oxid_esales.theme.admin.name: 'admin_twig'
