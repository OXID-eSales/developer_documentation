Miscelaneous changes
====================

The following changes could, but don't have to be relevant for the update of your OXID eShop. Read them carefully and
decide if you have to take actions.

Exception handling
------------------

The exception handler was refactored in a way to catch more exceptions than before. Therefor you should have a look
at the file :file:`log/EXCEPTION_LOG.txt` after you completed the whole update to OXID eShop 6. Goal should be to
have no exceptions in this file.

If you configured exception handling by overwriting the method ``oxShopControl::_setDefaultExceptionHandler()``, you
can do this from now on by calling the PHP method ``set_exception_handler()`` in the file :file:`modules/functions.php`.

The format of the file :file:`log/EXCEPTION_LOG.txt` changed a little bit, e.g. a data is included now:

.. code::

    [10 Oct 16:44:44.625024 2017] [exception] [type Exception] [code 0] [file /var/www/oxideshop/source/Application/Controller/StartController.php] [line 128] [message Argument not valid]
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #0 /var/www/oxideshop/source/Core/ShopControl.php(466): OxidEsales\EshopCommunity\Application\Controller\StartController->render()
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #1 /var/www/oxideshop/source/Core/ShopControl.php(357): OxidEsales\EshopCommunity\Core\ShopControl->_render(Object(OxidEsales\Eshop\Application\Controller\StartController))
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #2 /var/www/oxideshop/source/Core/ShopControl.php(289): OxidEsales\EshopCommunity\Core\ShopControl->formOutput(Object(OxidEsales\Eshop\Application\Controller\StartController))
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #3 /var/www/oxideshop/source/Core/ShopControl.php(150): OxidEsales\EshopCommunity\Core\ShopControl->_process('OxidEsales\\Esho...', NULL, NULL, NULL)
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #4 /var/www/oxideshop/source/Core/Oxid.php(42): OxidEsales\EshopCommunity\Core\ShopControl->start()
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #5 /var/www/oxideshop/source/index.php(31): OxidEsales\EshopCommunity\Core\Oxid::run()
    [10 Oct 16:44:44.625024 2017] [exception] [stacktrace] #6 {main}


Generic import and erp
----------------------

If you rely on one of the following old classes, e.g. in a module, you should take care to use the equivalent classes
as described. In OXID eShop 4.10 / 5.3, the code of the Generic Import was duplicated in the OXID eShop and the OXID ERP Interface.
With OXID eShop 6, we cleaned up this thing: the code of the Generic Import is now only in the OXID eShop.

Changed
^^^^^^^

The files from :file:`core/objects` are now in the directory :file:`Core/GenericImport/ImportObject`. For some of them
the inheritance chain changed (we describe here only the changes on class level):

- the main ``base`` class changed from ``oxERPType`` to ``ImportObject``, which is now abstract
- ``oxERPType_Accessoire`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Accessories2Article``
- ``oxERPType_Artextends`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\ArticleExtends``
- ``oxERPType_Article`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Article``
- ``oxERPType_Article2Action`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Article2Action``
- ``oxERPType_Article2Attribute`` is no longer available
- ``oxERPType_Article2Category`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Article2Category``
- ``oxERPType_Attribute`` is no longer available
- ``oxERPType_Category`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Category``
- ``oxERPType_Content`` is no longer available
- ``oxERPType_Country`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Country``
- ``oxERPType_Crossselling`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\CrossSelling``
- ``oxERPType_Order`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Order``
- ``oxERPType_OrderArticle`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\OrderArticle``
- ``oxERPType_ScalePrice`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\ScalePrice``
- ``oxERPType_User`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\User``
- ``oxERPType_Vendor`` is now ``\OxidEsales\Eshop\Core\GenericImport\ImportObject\Vendor``

Removed
^^^^^^^

In former OXID eShop versions the files oxerpbase.php, oxerpcsv.php and oxerpgenimport.php were there for handling the ERP
requests. In the version 6.0 all this functionality is bundled in the class \OxidEsales\Eshop\Core\GenericImport\GenericImport.
This class lives in the directory SHOP_ROOT\source\Core\GenericImport.


DynPages
--------

The DynPages are not available for OXID eShop 6 anymore. If you extended it, search for a different
solution.

.. _update_eshop_from_53_to_6_misc: