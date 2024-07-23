Container parameters
====================

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
        oxid_custom_parameter: some-value

oxid_build_directory
^^^^^^^^^^^^^^^^^^^^

Directory will be used to compile shop files is set from environment parameter `OXID_BUILD_DIRECTORY`.

oxid_shop_source_directory
^^^^^^^^^^^^^^^^^^^^^^^^^^

Path to source directory.

oxid_debug_mode
^^^^^^^^^^^^^^^

By default, this parameter will take the value of the environment variable `OXID_DEBUG_MODE` to enable or disable debugging.

oxid_smtp_debug_mode
^^^^^^^^^^^^^^^^^^^^

If you encounter issues when sending emails through an SMTP server, this parameter will assist you in diagnosing and resolving the errors.

oxid_shop_url
^^^^^^^^^^^^^

This parameter specifies the URL of the OXID eShop's front-end that customers will visit. It is essential for setting up the shop's public-facing web address.

oxid_shop_admin_url
^^^^^^^^^^^^^^^^^^^

This parameter defines the URL for the administrative interface of the OXID eShop, It is used by administrators to manage products, orders, customers, and other shop settings.

oxid_skip_database_views_usage
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you can't log in to the admin panel, try setting the `oxid_skip_database_views_usage` parameter to "true" temporarily.

.. warning::

    This may affect shop functionality and is recommended only for admin access when view tables are broken.

oxid_multi_shop_article_fields
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Define the Article model fields that can be edited individually in subshops.

.. code:: yaml

    oxid_multi_shop_article_fields: ['OXPRICE', 'OXPRICEA', 'OXPRICEB', 'OXPRICEC', 'OXUPDATEPRICE', 'OXUPDATEPRICEA', 'OXUPDATEPRICEB', 'OXUPDATEPRICEC', 'OXUPDATEPRICETIME']

.. warning::

    Specify the Article model fields that can be edited individually in subshops. Add these fields to the `oxfield2shop` table, noting that the field names are case-sensitive.

oxid_show_update_views_button
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Enable the `Update Views` button in the admin settings dashboard.

oxid_alternative_image_url
^^^^^^^^^^^^^^^^^^^^^^^^^^

Use an external CDN path to construct image URLs for all models containing images, such as Products, Categories, Promotions, Vendors, Manufacturers, and others.

.. code:: yaml

    oxid_alternative_image_url: 'https://www.mycdn-server.com/myshop-data/'

oxid_shop_logo
^^^^^^^^^^^^^^

Path for shop Image file.

oxid_max_product_picture_count
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Specifies the maximum number of images a model can have.

Session and cookies
-------------------

oxid_force_session_start
^^^^^^^^^^^^^^^^^^^^^^^^

Force session start on first page view and for users whose browsers do not accept cookies, append
sid parameter to URLs. By default it is turned off.

.. code:: yaml

    oxid_force_session_start: false

oxid_cookies_session
^^^^^^^^^^^^^^^^^^^^

Use browser cookies to store session id (no sid parameter in URL)

.. code:: yaml

    oxid_cookies_session: true

oxid_cookie_domains
^^^^^^^^^^^^^^^^^^^

In case you setup different subdomain for SSL/non-SSL pages cookies may not be shared between them.
This setting allows to define the domain that the cookie is available in format: `array(_SHOP_ID_ => _DOMAIN_)`

.. code:: yaml

    oxid_cookie_domains:
        1: mydomainexample.com

oxid_cookie_paths
^^^^^^^^^^^^^^^^^

The path on the server in which the cookie will be available on: `array(_SHOP_ID_ => _PATH_)`

.. code:: yaml

    oxid_cookie_paths:
        1: /var/www/path

.. note::

    Check `setcookie() <https://php.net/manual/de/function.setcookie.php>`__ documentation for more details.

oxid_trusted_ips
^^^^^^^^^^^^^^^^

Defines IP addresses, for which session + cookie ID match and user agent change checks are off.

oxid_session_init_params
^^^^^^^^^^^^^^^^^^^^^^^^

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

    oxid_session_init_params:
        fnc:
            login_noredirect: true
        new_sid: true

oxid_disallow_force_session_id
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This parameter can be set to `true` to safeguard against session ID appearing in the URL parameters in case of unintentional
misconfiguration in the session management mechanism.
