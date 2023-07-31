Twig Engine Installation
========================

This tutorial explains how to install Twig template engine and OXID eShop Twig themes.

1. Install OXID eSales Twig components (PE/EE only)
---------------------------------------------------

Run one of the following commands to install the corresponding version of Twig Component:

    .. code:: bash

        # For OXID eShop Professional Edition (PE)
        composer require oxid-esales/twig-component-pe

        # For OXID eShop Enterprise Edition (EE)
        composer require oxid-esales/twig-component-ee

2. Install Twig admin theme
---------------------------

To access admin panel please install `the Twig theme for the admin area <https://github.com/OXID-eSales/twig-admin-theme>`__:

.. code:: bash

    composer require oxid-esales/twig-admin-theme

3. Install Twig frontend theme
------------------------------

To access shop's frontend, please install `OXID's default Twig theme for the frontend area <https://github.com/OXID-eSales/apex-theme>`__:

.. code:: bash

    composer require oxid-esales/apex-theme


4. Clean up the shop compile directory
--------------------------------------

Run one of the following console commands in the shop's root:

.. code:: bash

        # "Standard path" when installed via OXID eShop PE/EE metapackage
        vendor/bin/oe-console oe:cache:clear

        # When upgraded to the PE/EE after installing the OXID eShop Community Edition Core Component
        bin/oe-console oe:cache:clear

If not sure, try the standard path first.

5. After Twig engine installation
---------------------------------

- **Activate frontend theme:**

+ via admin:

After the Twig engine is installed, you should be able to access administration panel and activate installed Twig frontend theme (e.g. APEX) for your shop.

+ via console command:

  .. code:: bash

     vendor/bin/oe-console oe:theme:activate apex

.. note::

        See `OXID Developer Tools component <https://github.com/OXID-eSales/developer-tools>`__ if the above command's not available.

- **Configure optional Twig engine parameters:**

OXID Twig Component can be customized by overriding the default values from the Symfony container configuration:

  .. code:: yaml

        parameters:
        # Admin theme ID
          oxid_esales.theme.admin.name: 'admin_twig'
        # Template engine file extension - value is bound to the current template engine
          oxid_esales.templating.engine_template_extension: 'html.twig'
        # Delegate HTML-escaping to the template engine - is "true" for Twig
          oxid_esales.templating.engine_autoescapes_html: true
        # Template caching control
          oxid_esales.templating.disable_twig_template_caching: false

For example, you can **disable template caching** (during development) by defining:

  .. code:: yaml

    # Values in var/configuration/configurable_services.yaml file
    parameters:
      oxid_esales.templating.disable_twig_template_caching: true

.. todo: Igor: the following doc doesn't exist:
        For more information, see :doc:`Twig theme installation documentation </development/modules_components_themes/theme/twig/installation>`.
