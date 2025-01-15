Update to 8.0
=============

This document provides the steps to update your shop from version 7.x to the new version 8.0.

.. note::
    To avoid any issues during the update process, please back up your shop files and data.

.. note::
    To execute commands via the command line, open a shell in the shop root directory and run the commands from there.

Update Twig templates
---------------------

To update your Twig templates to meet the latest shop requirements, you need to install the `oxideshop-update-component` using Composer.

.. code:: bash

    composer require oxid-esales/oxideshop-update-component:^v3.0.0

After installing the component, you can run the command with the parameter `target-templates-path` , which specifies the path to the templates that need to be updated. Note that the default OXID templates are already updated.

.. code:: bash

    php bin/oe-console oe:oxideshop-update-component:migrate-template-filter {target-templates-path}

