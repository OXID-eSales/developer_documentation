Inter-module compatibility
==========================

Vendor acronyms and prefixes
----------------------------

Vendor Prefixes
^^^^^^^^^^^^^^^

.. todo: #VL: VL prüft mit Team und Support: brauchen wir es noch? -- Ziel-Seite fehlt; wie registriert man sein Kürzel?
         #HR: makes still sense to have it but linked page needs to be updated -- how/who updted?

Use a prefix and a vendor namespace consistently.

Use your prefix for your:

* database tables
* additional fields
* config parameters
* language constants

Recommendation: To prevent use by others, reserve your prefix under `forum.oxid-esales.com/t/modulkurzel-fur-namespaces-extension-acronyms-for-namespaces/98381 <https://forum.oxid-esales.com/t/modulkurzel-fur-namespaces-extension-acronyms-for-namespaces/98381>`_.

Namespaces
^^^^^^^^^^

Also, make sure to use your namespace (with the namespace of your module) inside all of your classes.

An example from the Module Template module:

.. code:: php

    namespace OxidEsales\ModuleTemplate\Controller;

    class GreetingController extends FrontendController
    {
        // ...

Extensions for existing methods
-------------------------------

Parent calls
^^^^^^^^^^^^

When writing extensions for methods that do variable assignments or execute other calls, be sure to add a parent call.

This is an example from the Demo logger module class ``Basket`` which is an extension for the shop's basket class with the
namespace ``\\OxidEsales\Eshop\Application\Model\Basket``.

.. code:: php

    /**
     * Method overrides eShop method and adds logging functionality.
     *
     * @param string      $productID
     * @param int         $amount
     * @param null|array  $sel
     * @param null|array  $persParam
     * @param bool|false  $shouldOverride
     * @param bool|false  $isBundle
     * @param null|string $oldBasketItemId
     *
     * @see \OxidEsales\Eshop\Application\Model\Basket::addToBasket()
     *
     * @return BasketItem|null
     */
    public function addToBasket(
        $productID,
        $amount,
        $sel = null,
        $persParam = null,
        $shouldOverride = false,
        $isBundle = false,
        $oldBasketItemId = null
    ) {
        $basketItemLogger = new BasketItemLogger(Registry::getConfig()->getLogsDir());
        $basketItemLogger->logItemToBasket($productID);

        return parent::addToBasket($productID, $amount, $sel, $persParam, $shouldOverride, $isBundle, $oldBasketItemId);
    }

Method visibility
^^^^^^^^^^^^^^^^^

Do not change the visibility of methods that are extended.

Visibilities can be ``public``, ``protected`` or ``private``.

If you want to extend an original method, do not change your new method's visibility from ``protected`` to ``public`` or
from ``private`` to ``protected``.

Use oxNew()
-----------

For creating objects, always use the oxNew() function in order to have the module chain (and all of its methods) available:

.. code:: php

    $article = oxNew(OxidEsales\Eshop\Application\Model\Article::class);

