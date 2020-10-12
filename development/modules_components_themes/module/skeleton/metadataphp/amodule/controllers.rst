controllers
===========

Description
    At this place, you can define, which controllers should be able to be called directly, e.g. from templates.
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

           <form action="[{$oViewConf->getSelfActionLink()}]" name="MyModuleControllerAction" method="post" role="form">
                <div>
                    [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="cl" value="myvendor_mytestmodule_mymodulecontroller">
                    <input type="hidden" name="fnc" value="displayMessage">
                    <input type="text" size="10" maxlength="200" name="mymodule_message" value="[{$the_module_message}]">
                    <button type="submit" id="MyModuleControllerActionButton" class="submitButton">[{oxmultilang ident="SUBMIT"}]</button>
                </div>
           </form>

    If the controller key is not found within the shop or modules, it is assumed that the controller key is a class with this name.
    If there is no class with this name present, the OXID eShop will redirect to the shop front page.



Define template file in the render method
-----------------------------------------

To render a smarty template via a frontend controller, we need to define the template file
in metadata.php in the templates section. For example:

.. code::

    .
    .
    'templates' => array(
        'template-name.tpl' => '.../template-name.tpl'
    ),
    .
    .

and the render method in our controller should return it, but we also support twig engine,
therefore you should only return **the template name without extension** in the render method,
then the shop will behave in the same way for both smarty and twig templates. For example:

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

    For twig templates we do not need to define them in metadata.php in the templates section.
    To know how to register and access twig templates, please follow :ref:`this page <register-module-templates>`.