.. _metadataphpversion-settings-20190911:

settings
========

.. note::
    Watch a short video tutorial on YouTube: `Module Settings <https://www.youtube.com/watch?v=2gLrhrEZ83M>`_.

Description
    In this section all module configuration options are registered. In the eShop admin, users can configure
    modules according these settings.
    The settings can be translated and you can access the values in your php code.

Type
    Array of associative arrays. Array keys:

    * Each module setting belongs to a group (key ``group``). This key is mandatory to display the setting in the default module settings tab. If you want to hide it instead, see :ref:`hiding settings <metadataphpversion-settings-hiding-settings-20190926>` for more information.
    * The mandatory key ``name`` is used for getting and storing the setting.
      It is best practice to prefix it with your :doc:`module id <id>` to avoid name
      collisions with other modules.
    * The key ``type`` is mandatory. Possible values are ``str``, ``bool``, ``num`` (integer or float), ``arr`` (array),
      ``aarr`` (associative array), ``select`` (multiple options, translation possible), ``password``.
      If type is ``select``, you have to define the possible values by another key ``constraints``.
    * The key ``value`` sets a default value and is also mandatory. The keys ``type`` and ``value`` have to fit, see
      example below.
    * The optional parameter ``position`` sets the order of module settings shown in the eShop admin.

Mandatory
    No

Usage
    In PHP classes you can query your module settings with the :doc:`settings bridge </development/modules_components_themes/module/module_settings>`.

    In templates you have to use the ``Config`` class:
    
    .. code:: twig

        {% set oConfig = oViewConf.getConfig() %}
        {{ oConfig.getConfigParam('nameOfSetting') }}

    Add **translations of your module's settings** in each copy of the corresponding :file:`module_options.php` file
    (see details in :ref:`File and Folder structure <modules_structure_language_files_admin>`).

Example

    .. code:: php

        'settings' => [
            /** Main */

            // If type equals select, the key constraints has to specify possible values.
            [
                'group'       => 'oemoduletemplate_main',
                'name'        => 'oemoduletemplate_GreetingMode',
                'type'        => 'select',
                'constraints' => 'generic|personal',
                'value'       => 'generic'
            ],
            [
                'group' => 'oemoduletemplate_main',
                'name'  => 'oemoduletemplate_BrandName',
                'type'  => 'str',
                'value' => 'Testshop'
            ],
            [
                'group' => 'oemoduletemplate_main',
                'name'  => 'oemoduletemplate_LoggerEnabled',
                'type'  => 'bool',
                'value' => false
            ],
            [
                'group' => 'oemoduletemplate_main',
                'name'  => 'oemoduletemplate_Timeout',
                'type'  => 'num',
                'value' => 30
                //'value' => 30.5
            ],
            [
                'group' => 'oemoduletemplate_main',
                'name'  => 'oemoduletemplate_Categories',
                'type'  => 'arr',
                'value' => ['Sales', 'Manufacturers']
            ],
            [
                'group' => 'oemoduletemplate_main',
                'name'  => 'oemoduletemplate_Channels',
                'type'  => 'aarr',
                'value' => ['1' => 'de', '2' => 'en']
            ],
            [
                'group'    => 'oemoduletemplate_main',
                'name'     => 'oemoduletemplate_Password',
                'type'     => 'password',
                'value'    => 'changeMe',
                'position' => 3
            ]
        ]

.. _metadataphpversion-settings-hiding-settings-20190926:

Hiding settings
---------------

It is possible to hide module settings so they wouldn't be displayed in module settings tab.
This might be useful when you have custom settings page, but still want that the module would 
use all necessary OXID eShop functionality like storing settings data in
project configuration files. More information about this feature please read
:ref:`modules configuration documentation <configuring_module_via_configuration_files-20190829>`).

You can hide module setting by simply not adding ``group`` when describing setting in :file:`metadata.php` file.

Example

    .. code:: php

        'settings' => [
            [
                'name'  => 'oemoduletemplate_BrandName',
                'type'  => 'str',
                'value' => 'Testshop'
            ],
