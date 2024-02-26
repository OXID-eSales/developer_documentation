Extending a frontend user form
==============================

Add additional form input fields in frontend without need to add additional logic how to save the field
data.

This page describes how to achieve this by using
`extend user module example <https://github.com/OXID-eSales/extend-user-demo-module>`__.

Adjusting the user table
------------------------

For having additional input field in user form, first create a new column in the user table.

Do this by using the :doc:`events </development/modules_components_themes/module/skeleton/metadataphp/amodule/events>` module.

In our example, we use a database table column called ``EXTENDUSER_ADDITIONALCONTACTINFO``.

Extending the template
----------------------

    To find out how to extend :emphasis:`Twig` blocks, see :ref:`development/modules_components_themes/module/using_twig_in_module_templates:Using Twig in module templates`.

Modifying white-listed fields
-----------------------------

For security reasons, there is an array of "white-listed" fields. Only those table columns which have the corresponding
field in the "whitelist" array can be updated by submitting the form and passing parameters via POST requests.

There are two classes containing white-listed fields:

* Table ``oxusers``: ``OxidEsales\EshopCommunity\Application\Model\User\UserUpdatableFields``
* Table ``oxaddress``: ``OxidEsales\EshopCommunity\Application\Model\User\UserShippingAddressUpdatableFields``

So, to add additional field to the whitelist, extend one of those classes.

|example|

In the ``oxuser`` table case -
``OxidEsales\EshopCommunity\Application\Model\User\UserUpdatableFields``, the entry in module metadata file would look like
this:

.. code::

  'extend' => [
      \OxidEsales\Eshop\Application\Model\User\UserUpdatableFields::class => \OxidEsales\ExtendUser\UserUpdatableFields::class
  ],

And the contents of file could look like this:

.. code::

  namespace OxidEsales\ExtendUser;
  /**
   * @see \OxidEsales\Eshop\Application\Model\User\UserUpdatableFields
   */
  class UserUpdatableFields extends UserUpdatableFields_parent
  {
      public function getUpdatableFields()
      {
          $updatableFields = parent::getUpdatableFields();
          return array_merge($updatableFields, ['EXTENDUSER_ADDITIONALCONTACTINFO']);
      }
  }

In this way, the new ``EXTENDUSER_ADDITIONALCONTACTINFO`` field is added to the updatable fields array.

So, after module activation, the  new form field appears in the user form.
