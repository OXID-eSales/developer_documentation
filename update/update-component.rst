Update Component
================

The OXID Update Component provides tools for modernizing modules and updating your shop to version 8.0.

Installation
------------

Install the component using Composer:

.. code:: bash

    composer require oxid-esales/oxideshop-update-component:^v3.0.0

Available Commands
------------------

Module Modernization
~~~~~~~~~~~~~~~~~~~~

``oe:update:refactor-module``
    Applies general code refactoring to a module

``oe:update:upgrade-module``
    Upgrades module code to be compatible with OXID eShop 8

Shop Update
~~~~~~~~~~~

``oe:update:migrate-config-file``
    Migrates config.inc.php to .env and parameters.yaml files

``oe:update:migrate-config-database``
    Migrates configuration values from the database to parameters.yaml files

``oe:update:migrate-template-filters``
    Migrates Twig filter usage in template files (e.g. date_format() to date())

``oe:update:migrate-product-images``
    Migrates product images data from oxarticles to the new tables

``oe:update:drop-legacy-oxarticles-image-columns``
    Drops legacy image columns (OXPIC1-12, OXTHUMB, OXICON) from oxarticles table

Theme Configuration
~~~~~~~~~~~~~~~~~~~~

``oe:update:migrate-theme-metadata``
    Migrates a theme's theme.php to metadata.yaml and config.yaml

``oe:update:migrate-theme-configuration``
    Migrates theme settings and the active theme state from the oxconfig table to the theme YAML configuration

``oe:update:migrate-theme-templates``
    Rewrites getViewThemeParam() template calls to the typed getThemeSettings() theme setting service

``oe:update:remove-theme-configuration``
    Removes theme configuration data from the oxconfig table

Migrating a Theme Step by Step
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A theme is fully migrated to the YAML-based configuration by running the following
steps in order, from the shop root, once per theme. Each step is idempotent and can be
repeated safely. Replace ``<themeId>`` with the theme directory name (e.g. ``apex``).

1. Convert the theme's ``theme.php`` to YAML files:

   .. code:: bash

       bin/oe-console oe:update:migrate-theme-metadata source/Application/views/<themeId>

   This writes ``metadata.yaml`` (id, title, version, author and, for child themes, the
   parent theme) and ``config.yaml`` (each setting with its type, value, group and
   position) next to the theme's ``theme.php``. Repeat for every installed theme,
   including child themes.

2. Move the theme settings and the active theme state out of the database:

   .. code:: bash

       bin/oe-console oe:update:migrate-theme-configuration

   Every ``theme:<themeId>`` entry in the ``oxconfig`` table — including custom
   parameters — is decoded and written into the theme's ``config.yaml`` for each shop. The active theme (``sCustomTheme`` if set, otherwise
   ``sTheme``) is stored as the ``activated`` flag. This command processes all subshops.

3. Update the theme's templates to read settings through the theme setting service:

   .. code:: bash

       bin/oe-console oe:update:migrate-theme-templates source/Application/views/<themeId>

   ``oViewConf.getViewThemeParam('X')`` calls are rewritten to
   ``oViewConf.getThemeSettings().getString('X')`` (or the matching typed getter based on
   the setting's type). Any code that still reads a theme setting through
   ``Config::getConfigParam()`` must be changed to ``ThemeSettingServiceInterface`` as
   well.

4. Verify the migration: open the theme settings page in the admin area and browse the
   storefront, and confirm the theme renders with the expected settings now sourced from
   the YAML configuration.

5. After the migration is verified, remove the now-redundant theme data from the
   database:

   .. code:: bash

       bin/oe-console oe:update:remove-theme-configuration

   Run this only after step 4 succeeds; it permanently deletes the theme configuration
   (all ``theme:<themeId>`` entries plus ``sTheme``/``sCustomTheme``) from ``oxconfig``.

6. Finally, delete the now-redundant legacy ``theme.php`` from the theme directory:

   .. code:: bash

       rm source/Application/views/<themeId>/theme.php

   Its data was moved to ``metadata.yaml`` and ``config.yaml`` in step 1. Do this only
   after the migration is verified, once per theme directory including child themes.

For detailed usage instructions, see:

* :doc:`Module Modernization <module-modernization>`
* :doc:`Update to 8.0 <update-to-8-0>`
* :doc:`Theme Configuration Migration <theme-configuration-migration>`

