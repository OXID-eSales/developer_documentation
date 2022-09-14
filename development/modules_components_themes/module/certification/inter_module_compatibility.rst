Inter-module compatibility
==========================

Vendor acronyms and prefixes
----------------------------

Vendor Prefixes
^^^^^^^^^^^^^^^

.. todo: #VL: VL prüft mit Team und Support: brauchen wir es noch? -- Ziel-Seite fehlt; wie registriert man sein Kürzel?

A prefix and a vendor namespace should be used consistently, and they should
be `registered at OXID eSales <https://oxidforge.org/en/extension-acronyms>`__
to prevent use by others. Use your prefix for your:

#. database tables
#. additional fields
#. config parameters
#. language constants

Namespaces
^^^^^^^^^^

Also, your namespace (with the namespace of your module) should be used inside all of your classes.
An example from the PayPal module:

.. code:: php

    namespace OxidEsales\PayPalModule\Controller;

    class OrderController extends OrderController_parent
    {
        // ...

Extensions for existing methods
-------------------------------

Parent calls
^^^^^^^^^^^^

When writing extensions for methods that do variable assignments or execute other calls, be sure to add a parent call.
This is an example from the oepaypal module class ``OrderController`` which is an extension for the shop's class with the
namespace ``\OxidEsales\Eshop\Application\Controller\OrderController``.

.. code:: php

    /**
     * Returns PayPal user
     *
     * @return \OxidEsales\Eshop\Application\Model\User
     */
    public function getUser()
    {
        $user = parent::getUser();

        $userId = $this->getSession()->getVariable("oepaypal-userId");
        if ($this->isPayPal() && $userId) {
            $payPalUser = oxNew(\OxidEsales\Eshop\Application\Model\User::class);
            if ($payPalUser->load($userId)) {
                $user = $payPalUser;
            }
        }

        return $user;
    }

Method visibility
^^^^^^^^^^^^^^^^^

Do not change the visibility of methods that are extended. Visibilities can be ``public``, ``protected`` or ``private``.
If you want to extend an original method, do not change your new method's visibility from ``protected`` to ``public`` or
from ``private`` to ``protected``.

Use oxNew()
-----------

For creating objects, always use the oxNew() function in order to have the module chain (and all of its methods) available:

.. code:: php

    $Article = oxNew('Article');

