How to extend frontend user form?
=================================

There is a possibility to add additional form input fields in frontend without adding additional logic how to save the field
data. This page will describe how to achieve this by using
`extend user module example <https://github.com/OXID-eSales/extend-user-demo-module>`__.

Preparation
-----------

For having additional input field in user form first of all there will be a need to create new column in user table.
This can be achieved by using module :doc:`events </development/modules_components_themes/module/skeleton/metadataphp/amodule/events>` which would create a column.
In this page an example of database table column called ``EXTENDUSER_ADDITIONALCONTACTINFO`` will be used.

Template
--------

.. important::

    Following information is for smarty templates only, how to extend blocks with twig
    please check :doc:`module twig templates documentation </development/modules_components_themes/module/twig_templates>`


The block which will have to be extend is located in template file *form/fieldset/user_billing.tpl*.
To extend it there will be a need to create a template file and describe it in *metadata.php* file:

.. code:: php

  'blocks' => array(
      array('template' => 'form/fieldset/user_billing.tpl', 'block'=>'form_user_billing_country', 'file'=>'/views/user.tpl'),
  ),

*/views/user.tpl* contents could look like this:

.. code:: smarty

  [{$smarty.block.parent}]

  <div class="form-group">
      <label class="control-label col-lg-3">Additional contact info</label>
      <div class="col-lg-9">
          <input class="form-control" type="text" maxlength="128"
                 name="invadr[oxuser__extenduser_additionalcontactinfo]"
                 value="[{$oxcmp_user->oxuser__extenduser_additionalcontactinfo->value}]"
                 required=""
          >
      </div>
  </div>

Most important thing here is input field with name attribute ``name="invadr[oxuser__extenduser_additionalcontactinfo]"``
which says for OXID eShop to try write into table ``oxuser`` column ``EXTENDUSER_ADDITIONALCONTACTINFO`` provided value.

Modify white listed fields
--------------------------

For security reasons there is an array of "white listed" fields. Only those table columns which has equivalent
field in "white list" array can be updated by submitting form and passing parameters via POST request.

There are two classes which contains white listed fields:

* For table ``oxusers`` - ``OxidEsales\EshopCommunity\Application\Model\User\UserUpdatableFields``.
* For table ``oxaddress`` - ``OxidEsales\EshopCommunity\Application\Model\User\UserShippingAddressUpdatableFields``.

So to add additional field to the white list it's needed to extend one of those classes. In ``oxuser`` table case -
``OxidEsales\EshopCommunity\Application\Model\User\UserUpdatableFields``. Entry in module metadata file would look like
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

In this way into updatable fields array would be added new field - ``EXTENDUSER_ADDITIONALCONTACTINFO``.

So after module activation new form functioning field will appear in the user form.
