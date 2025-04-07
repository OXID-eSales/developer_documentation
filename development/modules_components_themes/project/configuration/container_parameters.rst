Container parameters
####################

You can set parameters within the service container, allowing you to utilize them directly or incorporate them into service definitions. This approach helps to decouple values that are likely to change frequently, making it easier to manage and update your application.
All parameters can be got from container:

Using ContainerFacade:

.. code:: php

    ContainerFacade::getParameter('some_parameter_value')

Using argument binding:

.. code:: yaml

      SomeService:
        arguments:
          - '%some_parameter_value%'


Parameters can be set under

.. code:: yaml

    parameters:
        oxid_esales.custom_parameter: some-value

.. note::

    The container cache must be rebuild after changing the value of a parameter.

    Use the following command to easily and safely clear the cache:

    .. code::

        ./vendor/bin/oe-console oe:cache:clear

.. centered::
    `***`

oxid_esales.build_directory
    Directory will be used to compile shop files is set from environment parameter ``OXID_BUILD_DIRECTORY``.

oxid_esales.shop_source_directory
    Path to source directory.

oxid_esales.debug_mode
    By default, this parameter will take the value of the environment variable ``OXID_DEBUG_MODE`` to enable or disable debugging.

oxid_esales.smtp_debug_mode
    If you encounter issues when sending emails through an SMTP server, this parameter will assist you in diagnosing and resolving the errors.

.. _oxid_esales.shop_url:

oxid_esales.shop_url
    This parameter specifies the URL of the OXID eShop's front-end that customers will visit. It is essential for setting up the shop's public-facing web address.

oxid_esales.shop_admin_url
    This parameter defines the URL for the administrative interface of the OXID eShop, It is used by administrators to manage products, orders, customers, and other shop settings.

oxid_esales.multilingual_tables
    Here you can define additional multilanguage table lists.

oxid_esales.skip_database_views_usage
    If you can't log in to the admin panel, try setting this parameter to "true" temporarily.

    .. warning::

        This may affect shop functionality and is recommended only for admin access when view tables are broken.

oxid_esales.multi_shop_article_fields
    Define the Article model fields that can be edited individually in subshops.

    .. code:: yaml

        oxid_esales.multi_shop_article_fields: ['OXPRICE', 'OXPRICEA', 'OXPRICEB', 'OXPRICEC', 'OXUPDATEPRICE', 'OXUPDATEPRICEA',
        'OXUPDATEPRICEB', 'OXUPDATEPRICEC', 'OXUPDATEPRICETIME']

    .. warning::

        Specify the Article model fields that can be edited individually in subshops. Add these fields to the ``oxfield2shop``
        table, noting that the field names are case-sensitive.

oxid_esales.show_update_views_button
    Enable the "Update Views" button in the admin settings dashboard.

oxid_esales.alternative_image_url
    Use an external CDN path to construct image URLs for all models containing images, such as Products, Categories, Promotions,
    Vendors, Manufacturers, and others.

    .. code:: yaml

        oxid_esales.alternative_image_url: 'https://www.mycdn-server.com/myshop-data/'

oxid_esales.shop_logo
    Path for shop Image file.

oxid_esales.max_product_picture_count
    Specifies the maximum number of images a model can have.

oxid_esales.basket_reservation_cleanup_rate
    This value determines how many expired basket reservations are cleaned per
    request (to the eShop). Cleaning a reservation essentially means returning the
    reserved stock to the articles.

    .. note::
        Works only if basket reservations feature is enabled in admin.

    .. warning::
        Keeping this number too low may cause article stock to be returned too slowly,
        while too high a value may have a spiking impact on performance.

oxid_esales.cron_enabled
    It informs the shop that price updates are performed by cron (a time-based job
    scheduler).

oxid_esales.user_rights_roles_mode
    Enables Rights and Roles Engine. Possible values:

    * 0 - Disable
    * 1 - Enable in admin
    * 2 - Enable in shop
    * 3 - Enable in admin and shop

oxid_esales.mall_shared_basket
    It enables shared shopping basket across multiple sub-shops.

oxid_esales.seo_mode
    SEO URL feature can be turned off by setting it to false. It is turned on by
    default.

oxid_esales.shop_credit_rating
    Initial value of credit rating.

oxid_esales.force_session_start
    Force session start on first page view and for users whose browsers do not accept cookies, append
    sid parameter to URLs. By default it is turned off.

    .. code:: yaml

        oxid_esales.force_session_start: false

oxid_esales.cookies_session
    Use browser cookies to store session id (no sid parameter in URL)

    .. code:: yaml

        oxid_esales.cookies_session: true

oxid_esales.cookie_domains
    In case you setup different subdomain for SSL/non-SSL pages cookies may not be shared between them.
    This setting allows to define the domain that the cookie is available in format: ``array(_SHOP_ID_ => _DOMAIN_)``

    .. code:: yaml

        oxid_esales.cookie_domains:
            1: mydomainexample.com

oxid_esales.cookie_paths
    The path on the server in which the cookie will be available on: ``array(_SHOP_ID_ => _PATH_)``

    .. code:: yaml

        oxid_esales.cookie_paths:
            1: /var/www/path

    .. note::

        Check `setcookie() <https://php.net/manual/de/function.setcookie.php>`__ documentation for more details.

oxid_esales.trusted_ips
    Defines IP addresses, for which session + cookie ID match and user agent change checks are off.

oxid_esales.session_init_params
    This configuration array specifies additional request parameters, which, if received, forces a new session being started.

    This is the default array with the request parameters and their values, which forces a new session:

    .. code:: php

        [
            'cl' => [
                'register' => true,
                'account'  => true,
            ],
            'fnc' => [
                'tobasket' => true,
                'login_noredirect' => true,
                'tocomparelist'    => true,
            ],
            '_artperpage' => true,
            'ldtype'      => true,
            'listorderby' => true,
        ];

    If you want to extend this array, add to :file:`parameters.yaml`:

    .. code:: yaml

        oxid_esales.session_init_params:
            fnc:
                login_noredirect: true
            new_sid: true

oxid_esales.disallow_force_session_id
    This parameter can be set to ``true`` to safeguard against session ID appearing in the URL parameters in case of unintentional
    misconfiguration in the session management mechanism.


oxid_esales.allowed_uploaded_types
    File type whitelist for file uploads.

oxid_esales.log_admin_queries
    Log all modifications performed in Admin. The log can be found in ``oxadmin.log``,
    in the shop log directory.

oxid_esales.log_not_seo_urls
    Configure whether requests coming via ``stdurl`` and not redirected to SEO URL
    should be logged to the ``seologs`` database table.

    .. note::

        This is only active in production mode, as the eShop in non-production mode
        will always log such URLs.

oxid_esales.search_engine_list
    List of all Search-Engine Robots.

oxid_esales.cacheable_user_components
    To override ``FrontendController::$_aUserComponentNames``, use this array option:
    array keys are component (class) names, and array values define if the component
    is cacheable (`true/false`). For example: ``['user_class' => false]``;

oxid_esales.demo_shop_mode
    Enables shop demo mode.

oxid_esales.utility.hash.service.password_hash.bcrypt.cost, oxid_esales.utility.hash.service.password_hash.argon2.memory_cost, oxid_esales.utility.hash.service.password_hash.argon2.time_cost, oxid_esales.utility.hash.service.password_hash.argon2.threads
    Configurations for the password hashing algorithm (see  `password_hash() <https://php.net/manual/en/function.password-hash.php>`__ documentation)
