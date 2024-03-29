.. _module-controllers-20170427:

controllers
===========

Description
    At this place, you can define which controllers should be able to be called directly, e.g. from templates.
    You can define a routing of ``controller keys`` to module classes.

Type
    Associative array

Mandatory
    No

Example
    .. code:: php

           'controllers'  => [
               'myvendor_mytestmodule_mymodulecontroller' => MyVendor\mytestmodule\MyModuleController::class,
               'myvendor_mytestmodule_myothermodulecontroller' => MyVendor\mytestmodule\MyOtherModuleController::class,
           ],

    The key of this array
    * is a identifier (``controller key``) which should be unique over all OXID eShop modules. Use vendor id and module id for prefixing.
    * Take care you declare the keys always in lower case!

       The value is the assigned class which should also be unique.

       Now you can route requests to the module controller e.g. in a template:

    .. code:: php

        <form action="{{ oViewConf.getSelfActionLink() }}" name="MyModuleControllerAction" method="post" role="form">
            <div>
                {{ oViewConf.getHiddenSid()|raw() }}
                <input type="hidden" name="cl" value="myvendor_mytestmodule_mymodulecontroller">
                <input type="hidden" name="fnc" value="displayMessage">
                <input type="text" size="10" maxlength="200" name="mymodule_message" value="{{ the_module_message }}">
                <button type="submit" id="MyModuleControllerActionButton" class="submitButton">{{ translate({ ident: "SUBMIT" }) }}</button>
            </div>
        </form>

    If the controller key is not found within the shop or modules, it is assumed that the controller key is a class with this name.
    If there is no class with this name present, the OXID eShop will redirect to the shop front page.

.. important::

    If you want to have an endpoint in your module that can be accessed directly, You must use controllers to do it.

    For example, in `GraphQL module <https://github.com/OXID-eSales/graphql-base-module>`_, we have `GraphQL` endpoint
    which has been created in `src/Component/Widget`, and also has been defined in the controller section in
    metadata.php as following:

    .. code::

        'controllers' => [
            // Widget Controller
            'graphql' => OxidEsales\GraphQL\Base\Component\Widget\GraphQL::class,
        ]

    Now we can access it via the following URL:

    .. code::

        http://<shopurl>/widget.php?cl=graphql



Defining a template file in the render method
---------------------------------------------

Make sure you shop behaves in the same way for both smarty and twig templates.

Rendering Smarty templates
^^^^^^^^^^^^^^^^^^^^^^^^^^

To render a smarty template via a frontend controller, in :file:`metadata.php` define the template file in the templates section.

|example|

.. code::

    .
    .
    'templates' => array(
        'template-name.tpl' => '.../template-name.tpl'
    ),
    .
    .

The render method in your controller returns the template.



Rendering Twig templates
^^^^^^^^^^^^^^^^^^^^^^^^

To render Twig templates, with the render method only return **the template name without extension**.


|example|

.. code::

     class MyController extends \OxidEsales\Eshop\Application\Controller\FrontendController
     {
         public function render()
         {
             .
             .

             return 'template-name';
         }
     .
     .

.. important::

    Twig templates are not defined in in the templates section of the :file:`metadata.php` file.

    For more information about registering and accessing Twig templates, see :ref:`development/modules_components_themes/module/using_twig_in_module_templates:Registering a new module's  template`.

