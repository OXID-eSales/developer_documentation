metadata.php
============

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.

Each OXID eShop module has its metadata defined via the :file:`metadata.php` file, located in the module's root directory.

Structure
---------

On the top level of the PHP file metadata.php, there have to be exactly two variables:
``$sMetadataVersion (String)`` and ``$aModule (Array)``. No other variables or code are allowed.

.. code:: php

    <?php

    $sMetadataVersion = '2.1';

    $aModule = [
        'id' => ...
        ...
    ]

The string ``$sMetadataVersion`` defines the Metadata version. Since OXID eShop 6.1, the current version is 2.1.

The array ``$aModule`` is for basic information as well as different extension configuration. It can contain multiple sub keys:

    .. toctree::
       :maxdepth: 1

       amodule/id

       amodule/title

       amodule/description

       amodule/lang

       amodule/thumbnail

       amodule/version

       amodule/author

       amodule/url

       amodule/email

       amodule/extend

       amodule/controllers

       amodule/settings

       amodule/events


Example of metadata.php
-----------------------

Here is an example of a module metadata file:

.. code:: php

    <?php

    /**
    * Metadata version
    */
    $sMetadataVersion = '2.1';

    /**
    * Module information
    */
    $aModule = [
        'id'          => 'oe_examples_module',
        'title'       => 'OXID eSales Examples Module',
        'description' => 'Module with examples for the most common use cases',
        'thumbnail'   => 'pictures/logo.png',
        'version'     => '1.0.0',
        'author'      => 'OXID eSales AG',
        'url'         => 'http://www.oxid-esales.com',
        'email'       => 'info@oxid-esales.com',
        'extend'      => [
            \OxidEsales\Eshop\Application\Controller\StartController::class => \OxidEsales\ExamplesModule\Extension\Controller\StartController::class,
            \OxidEsales\Eshop\Application\Model\User::class => \OxidEsales\ExamplesModule\Extension\Model\User::class,
        ],
        'events' => [
            'onActivate' => '\OxidEsales\ExamplesModule\Core\ModuleEvents::onActivate',
            'onDeactivate' => '\OxidEsales\ExamplesModule\Core\ModuleEvents::onDeactivate'
        ],
        'settings' => [
            [
                'group'       => 'oeexamplesmodule_main',
                'name'        => 'oeexamplesmodule_GreetingMode',
                'type'        => 'select',
                'constraints' => 'generic|personal',
                'value'       => 'generic'
            ],
            [
                'group' => 'oeexamplesmodule_main',
                'name'  => 'oeexamplesmodule_BrandName',
                'type'  => 'str',
                'value' => 'Testshop'
            ],
        ],
    ];


.. toctree::
    :titlesonly:
    :glob:
    :maxdepth: 1

    amodule/index
