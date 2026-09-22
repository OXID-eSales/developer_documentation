Theme Configuration Migration
=============================

Up to OXID eShop 7.x, theme settings, the active theme state (``sTheme``/``sCustomTheme``)
and a theme's metadata (``theme.php``) were stored in the database (``oxconfig``) and PHP
files. From 8.0, this data lives in per-shop YAML configuration files
(``var/configuration/shops/<shop-id>/themes/<theme-id>.yaml``) and is read through the
``ThemeSettingServiceInterface``.

This document describes how to migrate an existing shop, including custom theme
parameters and themes that extend another theme, to the new YAML-based configuration.

All commands are data-driven: they migrate whatever theme data exists, not a fixed set
of known parameters. Run every command from the shop root. In a multishop (Enterprise)
setup the configuration commands process all subshops.

Prerequisites
-------------

Ensure you have installed the :doc:`OXID Update Component <update-component>`.

Step 1: Migrate ``theme.php`` to YAML
-------------------------------------

Converts a theme's ``theme.php`` (``$aTheme``) into a ``metadata.yaml`` (id, title,
version, author, parent theme, etc.) and a ``config.yaml`` (the theme's default settings),
and installs the theme's per-shop YAML configuration
(``var/configuration/shops/<shop-id>/themes/<theme-id>.yaml``) with its ``source`` set to
the theme directory, for every shop. Run it once per theme directory, including child
themes.

.. code:: bash

    bin/oe-console oe:update:migrate-theme-metadata source/Application/views/<theme-id>

Step 2: Migrate theme settings and the active theme state
---------------------------------------------------------

Reads all theme settings from ``oxconfig`` (every ``oxmodule = 'theme:<theme-id>'`` entry,
so custom parameters are included), decodes their type and value, and writes
them into each theme's YAML configuration. The active theme (``sCustomTheme``, falling
back to ``sTheme``) is activated, i.e. stored as the DI parameter
``oxid_esales.theme.active`` in ``var/configuration/shops/<shop-id>/parameters.yaml``.

.. code:: bash

    bin/oe-console oe:update:migrate-theme-configuration

The settings are merged into the per-shop YAML configuration created in step 1: values
already present are updated with the database value, and parameters that only exist in
the database are added. A theme that has no YAML configuration yet (step 1 was not run
for it) is skipped, and the command prints a warning listing those themes. Run step 1
for them first, then repeat this command.

OXID's standard theme settings are renamed to their new names in every migration
step, for example ``sLogoFile`` becomes ``logoFile``. Custom settings keep their names.
See `Renamed theme settings`_ for the full list.

Step 3: Migrate templates to the theme setting service
------------------------------------------------------

Rewrites ``oViewConf.getViewThemeParam('X')`` calls in a theme's ``.twig`` templates to
the typed theme setting service, e.g. ``oViewConf.getThemeSettings().getString('X')``.
The getter is chosen from the setting's type in ``config.yaml``: ``getBoolean`` for
``bool``, ``getInteger`` for ``num`` (or ``getFloat`` for decimal values),
``getCollection`` for ``arr``/``aarr`` and ``getString`` for everything else.

.. code:: bash

    bin/oe-console oe:update:migrate-theme-templates source/Application/views/<theme-id>

If a template references a setting that is not declared in the theme's ``config.yaml``,
the command asks what to do with it:

* **Add it to config.yaml**: declare the setting by choosing its type, then its value
  and group (and, for a ``select``, the allowed values). The rewritten call then uses
  the matching getter.
* **Replace as-is**: rewrite the call unchanged.

An undeclared setting has no value in the YAML configuration, so a ``getThemeSettings()``
call for it throws ``ThemeSettingNotFoundException`` at runtime until the setting is
declared. When the command runs non-interactively (for example with ``--no-interaction``
or in CI), it cannot prompt: it prints a warning listing the undeclared settings and
leaves them as-is.

Step 4: Verify
--------------

Open the theme settings page in the admin area and the storefront, and confirm the theme
renders with the expected settings. The theme settings are now read from the YAML
configuration.

Step 5: Remove the theme configuration from the database
--------------------------------------------------------

Once the migration is verified, remove the now-redundant theme data from ``oxconfig``
(all ``theme:<theme-id>`` entries plus ``sTheme``/``sCustomTheme``). The command asks for
confirmation before deleting; use ``--force`` to skip the prompt in automated setups.

.. code:: bash

    bin/oe-console oe:update:remove-theme-configuration

.. warning::
    This permanently deletes the theme configuration from the database. Make sure the
    migration has been verified first.

Step 6: Delete the legacy ``theme.php`` file
--------------------------------------------

Once the migration is verified, delete the now-redundant ``theme.php`` from the theme
directory; its data lives in ``metadata.yaml`` and ``config.yaml`` from step 1. Do this
once per theme directory, including child themes.

.. code:: bash

    rm source/Application/views/<theme-id>/theme.php

.. warning::
    This permanently deletes ``theme.php``. Make sure the migration has been verified
    first.

Renamed theme settings
----------------------

OXID's standard theme settings were renamed to remove Hungarian notation and outdated
terms. The migration commands apply these renames automatically to the theme
configuration, the theme's ``config.yaml`` and its templates. Settings that are not in
this list, including custom settings you added, keep their names.

.. csv-table::
    :header: "Old name", "New name"

    "aNrofCatArticles", "numberOfCategoryProducts"
    "aNrofCatArticlesInGrid", "numberOfCategoryProductsInGrid"
    "blShowBirthdayFields", "showBirthdayFields"
    "blShowListDisplayType", "showListDisplayType"
    "blShowWeightInList", "showWeightInList"
    "iNewBasketItemMessage", "newBasketItemMessage"
    "sDefaultListDisplayType", "defaultListDisplayType"
    "bl_showManufacturer", "showManufacturer"
    "sShowBargainArticles", "showBargainProducts"
    "sShowNewestArticles", "showNewestProducts"
    "sShowTopArticles", "showTopProducts"
    "sProductListNavigation", "showProductListNavigation"
    "sShowPopBreadcrump", "showPopupBreadcrumb"
    "bl_showCompareList", "showCompareList"
    "bl_showGiftWrapping", "showGiftWrapping"
    "bl_showVouchers", "showVouchers"
    "bl_showWishlist", "showWishlist"
    "blEmailsShowProductPictures", "emailsShowProductPictures"
    "blFooterShowHelp", "footerShowHelp"
    "blFooterShowLinks", "footerShowLinks"
    "blFooterShowNewsletter", "footerShowNewsletter"
    "blFooterShowNewsletterForm", "footerShowNewsletterForm"
    "sBlogUrl", "blogUrl"
    "sFacebookUrl", "facebookUrl"
    "sInstagramUrl", "instagramUrl"
    "sTwitterUrl", "twitterUrl"
    "sYouTubeUrl", "youTubeUrl"
    "sPaymentIcons", "showPaymentIcons"
    "sTrustBadges", "showTrustBadges"
    "sDetailImageSize", "detailImageSize"
    "blSliderShowImageCaption", "sliderShowImageCaption"
    "sCatIconsize", "categoryIconSize"
    "sCatPromotionsize", "categoryPromotionSize"
    "sCatThumbnailsize", "categoryThumbnailSize"
    "sIconsize", "iconSize"
    "sManufacturerIconsize", "manufacturerIconSize"
    "sManufacturerPicturesize", "manufacturerPictureSize"
    "sManufacturerThumbnailsize", "manufacturerThumbnailSize"
    "sManufacturerPromotionsize", "manufacturerPromotionSize"
    "sThumbnailsize", "thumbnailSize"
    "sZoomImageSize", "zoomImageSize"
    "sEmailLogo", "emailLogo"
    "sLogoFile", "logoFile"
    "sLogoHeight", "logoHeight"
    "sLogoWidth", "logoWidth"
    "sFavicon16File", "favicon16File"
    "sFavicon32File", "favicon32File"
    "aAppleTouchIcon", "appleTouchIcon"
    "sFaviconFile", "faviconFile"
    "sFaviconSvg", "faviconSvg"
    "aOGImage", "openGraphImage"
    "sSiteManifestFile", "siteManifestFile"
    "sThemeColor", "themeColor"
    "blGAAnonymizeIPs", "googleAnalyticsAnonymizeIps"
    "blUseGAEcommerceTracking", "useGoogleAnalyticsEcommerceTracking"
    "blUseGAPageTracker", "useGoogleAnalyticsPageTracker"
    "sGATrackingId", "googleAnalyticsTrackingId"
    "sGoogleMapsAddr", "googleMapsAddress"
    "sBasketNoticeListButtonFunction", "basketNoticeListButtonFunction"

Custom parameters and child themes
----------------------------------

* Custom theme parameters are migrated automatically in step 2 as long as they were
  stored under ``oxmodule = 'theme:<theme-id>'`` in ``oxconfig``.
* Read custom parameters in code through ``ThemeSettingServiceInterface`` (or
  ``ViewConfig::getThemeSettings()`` in templates) instead of ``Config::getConfigParam()``
  / ``getViewThemeParam()``.
* A theme that extends another theme keeps its ``parentTheme``/``parentVersions`` in
  ``metadata.yaml`` after step 1.
