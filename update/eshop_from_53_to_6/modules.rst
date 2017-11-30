.. _port_to_v6-20170427:

Modules
=======

For updating existing modules from OXID eShop 4.10/5.3 to OXID eShop 6, either

* get an OXID eShop 6 compatible version of your modules or
* update the modules by yourself. Please have a look at the following sections on how to update by yourself.

Overview about the steps to port a module to the OXID eShop version 6.0
-----------------------------------------------------------------------

In the table below you can find an overview what steps you can, and at least have to do, to port your module to the OXID eShop version 6.0.
Every line of the table represents a step or an adaption. As you see, there are two columns named "Minimal" and "Full".
Your absolute to-dos for now are marked as "Minimal" with a "✔". They tell you, that you have to do them in order to end up with a module which works with the OXID eShop version 6.0.
All to-dos are marked as "Full". This tells you, that you are not done after the "Minimal" porting of your module. There are more steps to make to be fully aligned with the version 6.0.
We strongly recommend you to do the "Full" steps now, or as soon as possible. We do so, cause

* you will fit better in OXIDs long term stable investment strategy and
* with the next (major) versions there will be more changes, which will add up to a bigger amount of open to-dos.

+----------------------------------------------------------------------------------------+-----------+--------+
|  Topic                                                                                 |  Minimal  |  Full  |
+========================================================================================+===========+========+
| :ref:`Assure test coverage for your code <port_to_v6-coverage-20170427>`               |  ✔        | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Convert all files to UTF-8 <port_to_v6-utf8-20170427>`                           |  ✔        | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Adjust PHP version <port_to_v6-php_version-20170427>`                            |  ✔        | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Adjust removed functionality <port_to_v6-removed-20170427>`                      |  ✔        | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Adjust your database code to the new DB Layer <stick_to_db_interfaces-20170426>` |  ✔        | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Adjust the code style of your modules code <port_to_v6-code_style-20170427>`     |           | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Exchange BC Layer classes <port_to_v6-bc_layer-20170427>`                        |           | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Remove deprecated code <remove_deprecated_code-20171012>`                        |           | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Installable via composer* <port_to_v6-composer-20170427>`                        |           | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+
| :ref:`Introduce a namespace in your module <port_to_v6-namespace-20170427>`            |           | ✔      |
+----------------------------------------------------------------------------------------+-----------+--------+

(*) If you are maintaining a module which is part of the :ref:`OXID eShop Compilation <glossary-oxid_compilation>` the installation has to work via composer!



.. _port_to_v6-minimal_steps-20170427:

Minimal steps
-------------

This section describes the minimum changes, which are necessary to make an existing module compatible with OXID eShop version 6.0.


.. _port_to_v6-coverage-20170427:

Cover your code with tests
^^^^^^^^^^^^^^^^^^^^^^^^^^

Make sure that you have all important logic covered by tests - Unit, Integration and Acceptance. Let them run once after every step in this guide.

.. _port_to_v6-utf8-20170427:

UTF-8 only
^^^^^^^^^^
Starting with the 6.0 the OXID eShop is UTF-8 only. This means all your modules
  - Translation files,
  - SQL files,
  - Code files,
  - Test files,
  - and all other files

have to be UTF-8 encoded.


.. _port_to_v6-php_version-20170427:

Required PHP version
^^^^^^^^^^^^^^^^^^^^

The code must work with PHP 5.6 and higher. Check the official `PHP migration documentation on php.net <http://php.net/manual/en/migration56.php>`__ what you have to do.


.. _port_to_v6-removed-20170427:

Removed functionality in OXID eShop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Make sure your module does not use any of the functionality that was deprecated in 5.3 and has been removed in OXID eShop 6.0.
You can find a list of changes in `OXID Forge <https://oxidforge.org/en/oxid-eshop-v6-0-0-beta1-detailed-code-changelog.html>`__.


.. _stick_to_db_interfaces-20170426:

Stick to database interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Especially have an eye on the changes in database layer. ADOdb Lite (OXID eShop 5.x) was exchanged in favour of
Doctrine/DBAL which leads to some slightly different behaviour in some cases. We had to introduce some backwards compatibility breaks there.

Check 5.3 code for what will be deprecated:

    - `OXID eShop 5.3 ResultSetInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/b-5.3-ce/source/core/interface/ResultSetInterface.php>`__
    - `OXID eShop 5.3 DatabaseInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/b-5.3-ce/source/core/interface/DatabaseInterface.php>`__

New equivalents:

    - `OXID eShop 6.0 ResultSetInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/master/source/Core/Database/Adapter/ResultSetInterface.php>`__
    - `OXID eShop 6.0 DatabaseInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/master/source/Core/Database/Adapter/DatabaseInterface.php>`__

In ADOdb Lite there was not such a thing as a ResultSetInterface, it was introduced in v5.3.0 to be able to have an upgrade path to the version 6.0.

**IMPORTANT:**
Return values of e.g. oxDb::getDb()->select() and oxDb::getDb()->selectLimit() have changed,
now an instance of ResultSet (implementing ResultSetInterface) is returned.

Deprecated (5.3) logic, does not work in 6.0 and higher any more:

.. code::

        $rs = oxDb::getDb()->select($sQuery);
        if ($rs != false && $rs->recordCount() > 0) {
            while (!$rs->EOF) {
                //do something
                $rs->moveNext();
            }
        }

Example: new logic (since 6.0)

.. code::

         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         //Fetch the results row by row
         if ($resultSet != false && $resultSet->count() > 0) {
             while (!$resultSet->EOF) {
                 $row = $resultSet->getFields();
                 //do something
                 $resultSet->fetchRow();
             }
         }

Another example: new logic (since 6.0)

.. code::

         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         //Fetch all at once (beware of big arrays)
         $allResults = $resultSet->fetchAll()
         foreach($allResults as $row) {
            //do something
         };

IMPORTANT NOTE: do not try something like this, you will lose the first result row:

.. code::

         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         while ($row = $resultSet->fetchRow()) {
                //do something
         };

What will happen: the ResultSet immediately executes the first call to ResultSet::fetchRow() in its constructor
and each following call to ResultSet::fetchRow() advances the content of ResultSet::fields to the next row.
Always access ResultSet::fields before calling ResultSet::fetchRow() again.



.. _port_to_v6-full_steps-20170427:

Full steps
----------

On top of the :ref:`minimal steps <port_to_v6-minimal_steps-20170427>` we recommend you to take the following steps to completely move your module to the version 6.0 of the OXID eShop.


.. _port_to_v6-code_style-20170427:

Code style
^^^^^^^^^^

From OXID eShop version 6.0 on `PSR-0 and PSR-4 standards <https://oxidforge.org/en/coding-standards.html>`__ will be
used in OXID eShop core code. Our `Codesniffer <https://github.com/OXID-eSales/coding_standards>`__ can help you achieving this goal.


.. _port_to_v6-bc_layer-20170427:

Backwards compatibility layer and Unified Namespace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Mind that from version 6.0 on the OXID eShop is using namespaces. Therefore nearly all classes known from
5.3 (e.g. ``oxArticle``) and previous versions are deprecated now. They exist only as aliases in which we call the Backwards Compatibility Layer (from now on abbreviated with :ref:`BC Layer <bclayer-20170426>`).

As long as the :ref:`BC Layer <bclayer-20170426>` is in place, you can use the backwards compatibility classes (e.g. ``oxArticle``) equivalent to the actual
classes from the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` (e.g. ``\OxidEsales\Eshop\Application\Model\Article``).
The :ref:`Unified Namespace <modules-unified_namespaces-20170526>` is an abstraction for classes which exist in several Editions of the OXID eShop.
As soon as the :ref:`BC Layer <bclayer-20170426>` is dropped in a future release of OXID eShop,
you will have to fully port your module to the new Unified Namespaced classes (see :ref:`Unified Namespace <modules-unified_namespaces-20170526>`).

Replace all OXID eShop backwards compatibility classes (e.g. ``oxArticle``) in your module by the equivalent fully qualified :ref:`Unified Namespace <modules-unified_namespaces-20170526>` classes.

* check usages in oxNew and new
    .. code::

       // Old style (using BC Layer)
       $article = oxNew('oxarticle');
       $field = new oxField();

       // New style:
       $article = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
       $field   = new \OxidEsales\Eshop\Core\Field();

* Use the :ref:`Unified Namespace <modules-unified_namespaces-20170526>` class names for calls to Registry::set() and Registry::get().
    .. code::

       // Old style:
       oxRegistry::get('oxSeoEncoderVendor');

       // New style:
       \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Application\Model\SeoEncoderVendor::class);



.. _remove_deprecated_code-20171012:

Remove deprecated code
^^^^^^^^^^^^^^^^^^^^^^

Besides the usage of :ref:`backwards compatibility classes <port_to_v6-bc_layer-20170427>`
there might exist more usages of deprecated code in your modules. Choose your favourite IDE (integrated development environment)
and do a code analysis on deprecations. Additionally you can have a look to a list of all deprecations in the
`source code documentation <http://docu.oxid-esales.com/CE/sourcecodedocumentation>`.


.. _port_to_v6-composer-20170427:

Make module installable via composer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We recommend that the module is made installable via composer. Modules that will go to the (:ref:`OXID eShop Compilation <glossary-oxid_compilation>`) **MUST**
be installable via composer. Information what needs to be done (the keyword is composer.json) can be found
:ref:`here <copy_module_via_composer-20170217>`. Verify that composer correctly installs it.

.. important::

    if you made changes to the file :file:`modules/composer.json` in OXID eShop 4.10 / 5.3, port those changes into the
    root :file:`composer.json` file in OXID eShop 6 or into a modules :file:`composer.json` file

.. _port_to_v6-namespace-20170427:

Move the module under a module namespace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Introduce the module namespace in the module's composer.json file's autoload section.

    .. code::

        "autoload": {
            "psr-4": {
                "MyVendor\\MyModuleNamespace\\": "../../../source/modules/myvendor/mymoduleid"
            }
        }

    **NOTE:** we recommend to point the namespace to the module's installation path in the shop's module directory. See
    for example `OXID eShop Extension PayPal <https://github.com/OXID-eSales/paypal>`__.

    .. code::

        "autoload": {
            "psr-4": {
                "OxidEsales\\PayPalModule\\": "../../../source/modules/oe/oepaypal"
            }
        }

    Use the following pattern for your module namespace: ``<vendor of the module>`\<module ID>`` (e.g. ``OxidEsales\PayPalModule``)

    You can find more about the :ref:`Vendor Id <glossary-vendor_id>` in the Glossary.

* Move all the module classes under namespace.

    .. code::

        //before:
        class oePayPalIPNHandler extends oePayPalController
        {
            //...
        }

        $handler = oxNew('oepaypalipnhandler');


    .. code::

        //after:
        namespace OxidEsales\PayPalModule\Controller;
        class IPNHandler extends \OxidEsales\PayPalModule\Controller\FrontendController
        {
             //...
        }

        $handler = oxNew(\OxidEsales\PayPalModule\Controller\IPNHandler::class);

    While this step you should exchange all occurrences of the files name. Especially in the metadata.php the 'extends' section should not be forgotten!
    Remove the entry from the 'files' section, after you moved the class into the namespace. It is not longer needed, cause the namespaces get autoloaded via composer.

* Update metadata.php to version 2.0, see :ref:`here <metadata_version2-20170427>`.
  In case the module uses it's own controllers that do not simply chain extend shop controllers,
  you need to register a controller key in the metadata.php 'controller' section like
  described :ref:`here <controllers-20170307>`.

  .. code::

        'controllers' => array(
            ...
            'oepaypalipnhandler' => \OxidEsales\PayPalModule\Controller\IPNHandler::class,
            ...
        ),

  Your Controller Keys have to be lowercase and have to follow this pattern: ``<vendor of the module><module ID><controller name>`` (e.g. ``oepaypalipnhandler``)
