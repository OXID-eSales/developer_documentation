Theme Settings
==============

Theme settings are the configurable values a theme exposes — for example image sizes,
feature toggles, or social media links. They are declared in a theme's ``config.yaml``,
which is separate from the theme's ``metadata.yaml`` (its ``id``, ``title``, ``version``,
``author``, and, for a child theme, its parent — see :doc:`child_theme`). Settings are
read through ``ThemeSettingServiceInterface``.

.. note::
    Migrating an existing theme from ``getViewThemeParam()``/database-stored settings?
    See :doc:`/update/theme-configuration-migration`, which also lists the settings OXID
    renamed in its own standard theme.

Declaring settings
-------------------

Settings are declared under ``themeSettings`` in the theme's ``config.yaml``:

.. code:: yaml

    themeSettings:
        showManufacturer:
            type: bool
            value: true
            group: display
            position: 10
        thumbnailSize:
            type: num
            value: 300
            group: display
        defaultListDisplayType:
            type: select
            value: grid
            group: display
            constraints:
                - grid
                - list

* ``type`` determines how the value is stored and which typed getter reads it (see
  `Reading settings`_ below): ``str``, ``bool``, ``num``, ``arr`` (list), ``aarr``
  (associative array), or ``select`` (a ``str`` restricted to ``constraints``).
* ``value`` is the setting's default value.
* ``group`` groups related settings together on the theme settings page in the admin
  area. Only settings with a ``group`` appear on that page — a setting without a group
  can still be read in code but is not editable in the admin area.
* ``position`` orders settings within their group (optional).
* ``constraints`` lists the allowed values for a ``select`` setting.

Reading settings
------------------

In PHP, read a setting through ``ThemeSettingServiceInterface``:

.. code:: php

    $themeSettingService->getBoolean('showManufacturer');

In templates, use the matching typed getter on ``getThemeSettings()``:

.. code:: twig

    {{ oViewConf.getThemeSettings().getString('defaultListDisplayType') }}

The typed getter is chosen from the setting's ``type``: ``bool`` → ``getBoolean()``,
``num`` → ``getInteger()`` (or ``getFloat()`` for decimal values), ``arr``/``aarr`` →
``getCollection()``, everything else (including ``select``) → ``getString()``.

Reading an undeclared setting throws ``ThemeSettingNotFoundException``.

Editing settings in the admin area
-------------------------------------

Theme settings are edited on the theme's settings page in the admin area, grouped by
their ``group``. Saved values are stored per shop in the theme's YAML configuration
(``var/configuration/shops/<shopId>/themes/<themeId>.yaml``). Both the active theme
and its settings are per shop: in a multishop (Enterprise) setup each subshop can run
a different theme with its own settings.

Environment overrides
------------------------

A setting's value can be overridden per environment:

Location: ``var/configuration.<OXID_ENV>/shops/<shop-id>/themes/<theme-id>.yaml``

.. code:: yaml

    themeSettings:
        thumbnailSize:
            value: 400

Only ``value`` may be set here — the setting must already be declared (with its ``type``,
``group``, etc.) in the theme's ``config.yaml``. An override for a setting that is not
declared is ignored (a warning is logged). A declared setting overridden this way cannot
be changed through the admin area; attempting to save it shows an error instead.
