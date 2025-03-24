.. _configIncParamsChanges:

Overview of the config.inc option changes
=========================================

ENV variables
-------------

Following variables will be moved to ENV variables:

* sLogLevel -> **new**: ``OXID_LOG_LEVEL``
* iDebug -> **new**: ``OXID_DEBUG_MODE``
* date_default_timezone_set -> **new**: ``OXID_DEFAULT_TIMEZONE``

Container parameters
--------------------

The variables listed will be transferred to container parameters:

* blSeoLogging -> **new**: ``oxid_esales.seo_mode``
* blSeoMode -> **new**: ``oxid_esales.seo_mode``
* blLogChangesInAdmin -> **new**: ``oxid_esales.log_admin_queries``
* blUseCron -> **new**: ``oxid_esales.cron_enabled``
* iCreditRating -> **new**: ``oxid_esales.shop_credit_rating``
* blDemoShop -> **new**: ``oxid_esales.demo_shop_mode``
* iBasketReservationCleanPerRequest -> **new**: ``oxid_esales.basket_reservation_cleanup_rate``
* aUserComponentNames -> **new**: ``oxid_esales.cacheable_user_components``
* aMultiLangTables -> **new**: ``oxid_esales.multilingual_tables``
* aAllowedUploadTypes -> **new**: ``oxid_esales.allowed_uploaded_types``
* sShopLogo -> **new**: ``oxid_esales.shop_logo``
* iPicCount -> **new**: ``oxid_esales.max_product_picture_count``
* sAltImageDir / sSSLAltImageUrl -> **new**: ``oxid_esales.alternative_image_url``
* aRobots -> **new**: ``oxid_esales.search_engine_list``
* blForceSessionStart -> **new**: ``oxid_esales.force_session_start``
* blSessionUseCookies -> **new**: ``oxid_esales.cookies_session``
* aCookieDomains -> **new**: ``oxid_esales.cookie_domains``
* aCookiePaths -> **new**: ``oxid_esales.cookie_paths``
* aTrustedIPs -> **new**: ``oxid_esales.trusted_ips``
* aRequireSessionWithParams -> **new**: ``oxid_esales.session_init_params``
* blSkipViewUsage -> **new**: ``oxid_esales.skip_database_views_usage``
* blShowUpdateViews -> **new**: ``oxid_esales.show_update_views_button``
* blUseRightsRoles -> **new**: ``oxid_esales.user_rights_roles_mode``
* aMultishopArticleFields -> **new**: ``oxid_esales.multi_shop_article_fields``
* blMallSharedBasket -> **new**: ``oxid_esales.mall_shared_basket``

Removed variables
-----------------

* database connection variables will will be replaced by ``dsn`` (via **ENV**: ``OXID_DB_URL``)

    * dbType
    * dbCharset
    * dbHost
    * dbPort
    * dbName
    * dbUser
    * dbPwd

* sAdminEmail
* offlineWarningInterval
* sAuthOpenIdRandSource
* blDelSetupDir
* deactivateSmartyForCmsContent
* iSmartyPhpHandling
* blDoNotDisableModuleOnError
* aRobotsExcept
* iDebugSlowQueryTime
* aSlaveHosts
* blCheckForUpdates
* blUseTimeCheck
* blUseStock
* blEnterNetPrice
