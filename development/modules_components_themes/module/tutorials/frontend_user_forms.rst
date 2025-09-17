Extending a frontend user form
==============================

With the power of the OXID Framework, you can add additional form input fields in shop's frontend without the need to add additional logic on how to save the field data. To do so you create your own module and follow these steps:

- Add a new column to the **oxuser** table.
- Add an input field to an existing user form.
- Link the input field to the database field.
- Allow to save data from the new input field.

The finished module adds an additional input field to the billing address user form which is named **Floor Number**.

.. hint::
    In this tutorial, we are using the example module `User Form Extension Example <https://github.com/OXID-eSales/extend-user-demo-module>`__. Please keep in mind that this example extension follows the principle of an easy code base and might lack some advanced coding guidelines, such as the implementation of tests for each piece of code.

Creating the module base
------------------------

First we need to create a new module with files **composer.json** and **metadata.php**. All necessary information can be found in our documentation. Please see :doc:`Module skeleton: metadata, composer and structure </development/modules_components_themes/module/skeleton>`.

Adjusting the user table
------------------------

Database schema changes are always done using migrations. Therefore we create a migration to add a new column to the **oxuser** table. If you don't know how to create a migration, please see :doc:`Database Migration </development/modules_components_themes/module/database_migration>`.

We decided for **oe_extenduserform** as our module ID and so we name the column **OE_EXTENDUSERFORM_FLOOR** since it must be prefixed to be unique. The method **up** from our migration looks like this:

.. code:: php

    public function up(Schema $schema): void
    {
        $platform = $this->connection->getDatabasePlatform();
        $platform->registerDoctrineTypeMapping('enum', 'string');

        $user = $schema->getTable('oxuser');

        if (!$user->hasColumn('OE_EXTENDUSERFORM_FLOOR')) {
            $user->addColumn(
                'OE_EXTENDUSERFORM_FLOOR',
                Types::STRING,
                ['columnDefinition' => 'varchar(255)']
            );
        }
    }


We do it simple here and add the instructions to run the migration on module installation with command:

.. code:: shell
    ./vendor/bin/oe-eshop-db_migrate migrations:migrate oe_extenduserform


However, we may also consider to run the migrations automatically on module activation. To achieve this, we can use the **onActivate** event. If you want to know more about that, please see :doc:`onActivate event </development/modules_components_themes/module/skeleton/metadataphp/amodule/events>`.

If the data can be forgotten after module deactivation, you should add a migration to remove the column again and run it by the **onDeactivate** event. We skip this part in our example.

Extending the template
----------------------

Find a suitable template block in the user form to be extended. In this example we have a look at the billing address user form which can be found in template :file:`form/fieldset/user_billing.html.twig`. We choose the block **form_user_billing_country** to add the new field above the country selection field.

Create a block extension according to the :doc:`Extending existing templates </development/modules_components_themes/module/using_twig_in_module_templates>` manual.

.. code:: twig
    
    {% extends 'form/fieldset/user_billing.html.twig' %}

    {% block form_user_billing_country %}

        {# custom form field goes here #}

        {{ parent() }}

    {% endblock %}


When extending the block is successfully, implement the necessary contents to add a new input field. You can simply copy an input field from the original template :file:`form/fieldset/user_billing.tpl` and adapt it to your needs. The result may look like this:

.. code:: twig

    {% extends 'form/fieldset/user_billing.html.twig' %}

    {% block form_user_billing_country %}

        <div class="row gx-2">
            <div class="col-md-12 mb-3 px-1">
                <div class="form-floating">
                    <input
                        class="form-control"
                        placeholder=" "
                        type="text"
                        maxlength="255"
                        id="invadr[oxuser__oe_extenduserform_floor]"
                        name="invadr[oxuser__oe_extenduserform_floor]"
                        value="{% if invadr.oxuser__oe_extenduserform_floor is defined %}{{ invadr.oxuser__oe_extenduserform_floor }}{% else %}{{ oxcmp_user.oxuser__oe_extenduserform_floor.value }}{% endif %}"
                    >
                    <label for="invadr[oxuser__oe_extenduserform_floor]">Floor Number</label>
                </div>
            </div>
        </div>

        {{ parent() }}

    {% endblock %}


The most important thing here is to adapt the input field to the selected field name **OE_EXTENDUSERFORM_FLOOR** by setting the name to ``name="invadr[oxuser__oe_extenduserform_floor]"`` as well as the ID, value and all other contents accordingly. This tells the OXID Framework to link the input field to our **OE_EXTENDUSERFORM_FLOOR** column of the **oxuser** database table.

Please pay attention that in this example we only add contents for a basic form field and omit any input validation as well as translations for multi-language pages. In a real-world scenario you would add a translation to your module for the label and not just write *Floor Number* into the template direclty. You also should take care about the user input by adding input validation like it's done for existing input fields. Please see the contents of the original template file :file:`form/fieldset/user_billing.tpl` and adapt your custom implementation in accordance to that.

Modifying allowed fields
------------------------

For security reasons, there is an array of allowed fields. Only those table columns which have the corresponding field in the allowlist array can be updated by submitting the form and passing parameters via POST requests.

There are two classes containing allowlisted fields:

* ``OxidEsales\Eshop\Application\Model\User\UserUpdatableFields``
* ``OxidEsales\Eshop\Application\Model\User\UserShippingAddressUpdatableFields``

To add additional fields to the allowlist, extend one of those classes.

In our case, the ``oxuser`` table, we must extend the class ``\OxidEsales\Eshop\Application\Model\User\UserUpdatableFields`` by adding the following entry to the **metadata.php** file:

.. code:: php

    'extend' => [
        \OxidEsales\Eshop\Application\Model\User\UserUpdatableFields::class => \OxidEsales\ExtendUser\Model\UserUpdatableFields::class,
    ],

Then you must create the module class ``\OxidEsales\ExtendUser\Model\UserUpdatableFields`` with the following contents:

.. code:: php

    namespace OxidEsales\ExtendUser\Model;

    class UserUpdatableFields extends UserUpdatableFields_parent
    {
        protected $fieldsToAdd = [
            'OE_EXTENDUSERFORM_FLOOR',
        ];

        /**
        * Adds additional field which could be updated.
        */
        public function getUpdatableFields()
        {
            $updatableFields = parent::getUpdatableFields();

            return array_merge($updatableFields, $this->fieldsToAdd);
        }
}

In this way, the new database column ``OE_EXTENDUSERFORM_FLOOR`` is added to the updatable fields array. Now it is allowed to be submitted and passed by a user form.

Result
------

After module installation and activation, the new form field appears in the user form. You can log in in the shop's frontend, navigate to your account and edit your billing address. There you will see the new input field **Floor Number**. If everything was done right, you should now be able to save information, too.
