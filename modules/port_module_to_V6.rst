.. _minimal_port-20170426:

Port a module to V6 and higher - minimal port
=============================================

The following section describes the minimum changes necessary you need to invest to make an existing module
compatible with OXID eShop 6.0.


UTF8 only
^^^^^^^^^
From now on it is UTF8 only, means
  - Translation files
  - SQL files
  - Code
  - Tests
  - and so on

has all to be UTF8 encoded.

Required PHP version
^^^^^^^^^^^^^^^^^^^^
The code must work with PHP 5.6 and higher. Check `php.net <http://php.net/manual/en/migration56.php>`__ for documentation.

Removed functionality in OXID eShop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Make sure your module does not use any of the functionality that was deprecated in 5.3 and
has been removed in OXID eShop 6.0.
You can find a list of changes in `OXID Forge <https://oxidforge.org/en/oxid-eshop-v6-0-0-beta1-detailed-code-changelog.html>`__.

Mind that from V6 on the OXID eShop is using namespaces and that as good as all classes known from
5.3 and before are now deprecated and only exist as class alias in what we call the BC layer.


As long as the :ref:`BC layer <bclayer-20170426>` is in place, you can use the BC classes equivalent to the actual
classes from VNS (virtual namespace). As soon as the BC layer is dropped in a future release of OXID eShop,
you will have to fully port your module to the new classes.


Make module installable via composer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We recommend that the module is made installable via composer. Modules that will go to the shop compilation **MUST**
be installable via composer. Information what needs to be done (the keyword is composer.json) can be found
:ref:`here <copy_module_via_composer-20170217>`.


.. _stick_to_db_interfaces-20170426:

Stick to database interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Especially have an eye on the changes in database layer. AdoDBLite (OXID eShop 5.x) was exchanged in favour of
Doctrine/DBAL which leads to some slightly different behaviour in some cases. We had to introduce some BC breaks there.

Check 5.3 code for what will be deprecated:

    - `OXID eShop 5.3 ResultSetInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/b-5.3-ce/source/core/interface/ResultSetInterface.php>`__
    - `OXID eShop 5.3 DatabaseInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/b-5.3-ce/source/core/interface/DatabaseInterface.php>`__

New equivalents:

    - `OXID eShop 6.0 ResultSetInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/master/source/Core/Database/Adapter/ResultSetInterface.php>`__
    - `OXID eShop 6.0 DatabaseInterface <https://github.com/OXID-eSales/oxideshop_ce/blob/master/source/Core/Database/Adapter/DatabaseInterface.php>`__

In ADODB lite there was not such a thing as a ResultSetInterface, it was introduced in v5.3.0 to be able to have an upgrade path to v6.0.

**IMPORTANT:**
Return values of e.g. oxDb::getDb()->select() and oxDb::getDb()->selectLimit() have changed,
now an instance of ResultSet (implementing ResultSetInterface) is returned.

.. code::

    Deprecated (5.3) logic, does not work in 6.0 and higher any more:
        $rs = oxDb::getDb()->select($sQuery);
        if ($rs != false && $rs->recordCount() > 0) {
            while (!$rs->EOF) {
                //do something
                $rs->moveNext();
            }
        }

    Example: new (since 6.0) logic
         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         //Fetch the results row by row
         if ($resultSet != false && $resultSet->count() > 0) {
             while (!$resultSet->EOF) {
                 $row = $resultSet->getFields();
                 //do something
                 $resultSet->fetchRow();
             }
         }

    Example: new (since 6.0) logic
         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         //Fetch all at once (beware of big arrays)
         $allResults = $resultSet->fetchAll()
         foreach($allResults as $row) {
            //do something
         };

    VERY IMPORTANT: do not try something like this, you will lose the first result row:
         $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         while ($row = $resultSet->fetchRow()) {
                //do something
         };
    Point is: the ResultSet immediately executes the first call to ResultSet::fetchRow() in its constructor
    and each following call to ResultSet::fetchRow() advances the content of ResultSet::fields to the next row.
    Always access ResultSet::fields before calling ResultSet::fetchRow() again.

