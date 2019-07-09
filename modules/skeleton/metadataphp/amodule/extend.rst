extend
======

Description:
    On this place shall be defined which shop classes are extended by this module.
Type:
    associative array

Mandatory:
    no

Example
    .. code:: php

        // with namespaces
        'extend'       => [
            \OxidEsales\Eshop\Core\ViewConfig::class                              => \OxidEsales\PayPalModule\Core\ViewConfig::class,
            \OxidEsales\Eshop\Application\Component\BasketComponent::class        => \OxidEsales\PayPalModule\Component\BasketComponent::class,
            \OxidEsales\Eshop\Application\Component\Widget\ArticleDetails::class  => \OxidEsales\PayPalModule\Component\Widget\ArticleDetails::class
        ],

        // without namespaces
        'extend'       => [
            'oxviewconfig' => 'oe/oepaypal/controllers/oepaypaloxviewconfig',
            'oxbasketitem' => 'oe/oepaypal/models/oepaypaloxbasketitem',
            'oxarticle'    => 'oe/oepaypal/models/oepaypaloxarticle'
        ],

.. note::
   If you use non-namespaced classes: Take care you declare the keys (e.g. oxviewconfig) always in lower case!
   Take care you declare the file names case sensitive! It is suggested to use lower case for file names, to avoid difficulties.

.. note::
   For namespaced classes: You should extend only OXID eShop classes within
   :ref:`Unified Namespace <modules-unified_namespaces-20170526>` (``\OxidEsales\Eshop``). If you try to extend
   e.g a class of the namespace ``\OxidEsales\EshopCommunity``, you are not able to activate the module and get a
   warning message in the OXID eShop admin.