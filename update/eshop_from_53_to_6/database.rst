Database
========

.. _update-eshop_53_to_6-database-api:


Tables and fields
-----------------

Before starting with the changes described in the following sections, you should make sure that your OXID eShop 4.10 / 5.3
is running on utf-8 database tables. `See here for migration
instructions <http://www.oxid-esales.com/de/support-services/dokumentation-und-hilfe/oxid-eshop/installation/oxid-eshop-aktualisieren/auf-utf-8-umstellen.html>`__.
You should also take care that your own tables use UTF-8. There are also exceptions from utf-8 in the OXID eShop
database tables (e.g. the column ``OXID`` which is latin1 in most tables). If you refer to those columns from your
own tables, you also have to use latin1.

We provide update SQL scripts for each OXID eShop edition. We divided them into two files:

* one file with queries, where you can not lose data while the execution and
* one file with queries, where you will lose data while the execution.

So we expect, that you read the second file especially carefully!

You will recognize the second file on its postfix '_cleanup'.

**OXID eShop Community Edition:**

* :download:`migrate_ce_5_3_to_6_0.sql <resources/ce/migrate_ce_5_3_to_6_0.sql>`
* :download:`migrate_ce_5_3_to_6_0_cleanup.sql <resources/ce/migrate_ce_5_3_to_6_0_cleanup.sql>`

**OXID eShop Professional Edition:**


* :download:`migrate_pe_5_3_to_6_0.sql <resources/pe/migrate_pe_5_3_to_6_0.sql>`
* :download:`migrate_pe_5_3_to_6_0_cleanup.sql <resources/pe/migrate_pe_5_3_to_6_0_cleanup.sql>`

**OXID eShop Enterprise Edition**

* :download:`migrate_ee_5_3_to_6_0.sql <resources/ee/migrate_ee_5_3_to_6_0.sql>`
* :download:`migrate_ee_5_3_to_6_0_cleanup.sql <resources/ee/migrate_ee_5_3_to_6_0_cleanup.sql>`


InnoDb: Change of database engine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The database engine in OXID eShop 4.10 / 5.3 is mostly MyISAM. In OXID eShop 6, the database engine
is InnoDB for all database tables.

* Migrating the database with the scripts (see the previous section)
  from MyISAM to InnoDb may need some time, additional disk space and RAM. Be sure to plan a maintenance window
  in your production shop, provide enough disk space and RAM on your MySQL server.
* If you implemented your own queries to OXID eShop database tables, be sure to sort the results explicitely
  (e.g. using the MySQL ``ORDER BY``). Otherwise the
  order of the results may change with the migration from MyISAM to InnoDB.



Database API
------------

Read these changes carefully if you implemented own database queries. Otherwise you can skip this section.

New interfaces
^^^^^^^^^^^^^^

OXID eShop 4.10 / 5.3 introduced new interfaces: the ``\OxidEsales\Eshop\Core\Database\Adapter\DatabaseInterface``
and the ``\OxidEsales\Eshop\Core\Database\Adapter\ResultSetInterface``.
Be aware that there are already deprecated methods in the interfaces in OXID eShop 4.10 / 5.3 which were removed
in OXID eShop 6. Hints for replacing those methods in your code will be shown in the following sections.

DatabaseInterface
^^^^^^^^^^^^^^^^^

* the function parameter ``$executeOnSlave`` for some functions is deprecated in OXID eShop 5.3.
  You could additionally call ``DatabaseInterface::forceMasterConnection()`` before or encapsulate your logic in a
  transaction. Both mechanisms will force SQL queries to be read from the master server from this point on. This was done due to the
  changed MySQL master slave handling in OXID eShop 6.
  See the section :ref:`Master slave <update-eshop_53_to_6-database-master_slave>` for details.
* the constant ``DatabaseInterface::FETCH_MODE_DEFAULT`` shouldn't be used any more.  Doctrine uses ``FETCH_MODE_BOTH`` by default.
* The database transaction isolation level is set on session scope, not globally any more.
  Have a look at the comments of the method ``DatabaseInterface::setTransactionIsolationLevel()``.




ResultSetInterface
^^^^^^^^^^^^^^^^^^

* there is no way any more to move the pointer inside the resultSet any more in OXID eShop 6.
  The related methods will be removed completely. Do not use them, there is no elegant replacement.

  * ``ResultSetInterface::move()``
  * ``ResultSetInterface::moveNext()``
  * ``ResultSetInterface::moveFirst()``
  * ``ResultSetInterface::moveLast()``
  * ``ResultSetInterface::_seek()``
  * ``ResultSetInterface::EOF()``

    Deprecated (5.3) logic, does not work in 6.0 and higher any more:

    .. code:: php

        $rs = oxDb::getDb()->select($sQuery);
        if ($rs != false && $rs->recordCount() > 0) {
            while (!$rs->EOF) {
                //do something
                $rs->moveNext();
            }
        }

    Example: new (since 6.0) logic

    .. code:: php

        $resultSet = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->select($query);
         //Fetch the results row by row
         if ($resultSet != false && $resultSet->count() > 0) {
             while (!$resultSet->EOF) {
                 $row = $resultSet->getFields();
                 //do something
                 $resultSet->fetchRow();
             }
         }

* the following methods can be replaced with ``ResultSetInterface::fetchAll()`` in OXID eShop 6 to retrieve all rows or
  ResultSetInterface::fetchRow() to retrieve a single row:

  * ``ResultSetInterface::getAll()``
  * ``ResultSetInterface::getArray()``
  * ``ResultSetInterface::getRows()``

* The methods, which are related to the ``ADODB lite ResultSet *fields*`` property meta data were completely removed in OXID eShop 6.

  * ``ResultSetInterface::fetchField()`` Do not use any more.
  * ``ResultSetInterface::fields($field)`` Do not use any more.

* ``ResultSetInterface::recordCount()`` will be removed completely. Do not retrieve the affected row in the ``RecordSet``, but in the ``DatabaseInterface``.


* The methods ``DatabaseInterface::select()`` and ``DatabaseInterface::selectLimit()`` now return
  an object of the type ``ResultSetInterface``.

More examples how to use the database, :doc:`can be found here. <../../modules/using_database>`


.. _update-eshop_53_to_6-database-read_and_write:

Difference between read and write methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In OXID eShop 4.10 / 5.3 you can use the methods ``execute`` and ``select`` synonymously.
In OXID eShop 6, the method ``DatabaseInterface::select()`` can only be used for read alike
methods (``SELECT``, ``SHOW``) that return a kind of result set.
The method ``DatabaseInterface::execute()`` must be used for write alike methods (``INSERT``, ``UPDATE``, ``DELETE``)
in OXID eShop 6. See the section :ref:`Master slave <update-eshop_53_to_6-database-master_slave>` for details.

Transactions
^^^^^^^^^^^^

If you use transactions in your database queries, please read this section. The transaction handling has changed
substantially in OXID eShop 6:

* nested transactions are possible now. If one transaction fails, the whole chain of nested transactions is rolled back
  completely. In some cases it might not be evident that your transaction is already running within an other transaction.
* as all OXID eShop tables now support InnoDb, transactions are possible on all OXID eShop tables.

For details have a look on the :ref:`transactions documentation <modules-database-transactions>`



.. _update-eshop_53_to_6-database-adodb:

ADOdb Lite
----------


The library for the database abstraction layer (DBAL) changed from `ADOdb Lite <https://sourceforge.net/projects/adodblite/>`__
in OXID eShop 4.10 / 5.3 to `Doctrine DBAL <http://www.doctrine-project.org/projects/dbal.html>`__ in OXID eShop 6.

As using the library `ADOdb Lite` directly was not recommended at any time, you should not have to take care for this change.


.. _update-eshop_53_to_6-database-log_mysql:

Log MySQL queries
^^^^^^^^^^^^^^^^^

The possibility to log MySQL queries was removed.
There is no explicit recommendation on how to replace this feature in your OXID eShop.


.. _update-eshop_53_to_6-database-session_storage:

Session storage
---------------

The possibility to save sessions to the eShop application database was removed.
A blog post about the impact and alternatives in OXID eShop 6 and can be found on
`oxidforge <https://oxidforge.org/en/session-handling-with-oxid-eshop-6-0.html>`__.



.. _update-eshop_53_to_6-database-master_slave:

Master slave
------------

The implementation and usage of MySQL master slave replication changed in OXID eShop 6.
This results in the following changes:

* the parameter ``executeOnSlave`` was deprecated in OXID eShop 4.10 / 5.3. Have a look at the section
  :ref:`Database API <update-eshop_53_to_6-database-api>` on how to avoid ``executeOnSlave``.
* the configuration parameter ``iMasterSlaveBalance`` was used in OXID eShop 4.10 / 5.3 to balance the amount of read
  accesses between master and slave(s). Due to differences in now letting Doctrine DBAL handle Master/Slave connections
  the balance feature cannot be supported anymore.
* as the ratio between master and slave utilisation can vary between an OXID eShop 4.10 / 5.3 and an OXID eShop 6,
  you have to review your master slave concept with OXID eShop 6.
* for database queries in modules please have a look at the
  :ref:`database documentation <modules-database-master_slave>`.