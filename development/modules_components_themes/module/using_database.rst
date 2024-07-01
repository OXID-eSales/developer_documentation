Interacting with the database
=============================

Active records and magic getters
--------------------------------

.. note::
    Watch a short video tutorial on YouTube: `Active Records <https://www.youtube.com/watch?v=JSOlVnMcgSs>`_.

The OXID eShop architecture is based on an MVC design pattern.

To implement models, the Active Record pattern is used.

In general, each model class is linked to a database table.

For example, the ``Article`` model is linked to the ``oxarticles`` table, Order to the ``oxorders`` table etc.

All models are stored in the Application/Models directory.

Let's take one of them, for example the ``Article`` model, and try to fetch the product (with the ID ``demoId``) data from database:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class); // creating model's object
    $product->load( 'demoId' ); // loading data
    //getting some information
    echo $product->oxarticles__oxtitle->value;
    echo $product->oxarticles__oxshortdesc->value;

.. todo: #Igor: mention new method? -- beware PHP 8 and trying to get a value on null. maybe we should also mention getFieldData method in this section?

Magic getters are used to get models attributes; they are constructed in this approach:

.. code:: php

    $model->tablename__columnname->value;
    'tablename' is the name of the database table where the model data is stored
    'columnname' is the name of the column of this table containing the data you want to fetch

To set data to a model and store it, database magic setters (with the same approach as magic getters) are used:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->oxarticles__oxtitle = new \OxidEsales\Eshop\Core\Field ( 'productTitle' );
    $product->oxarticles__oxshortdesc = new \OxidEsales\Eshop\Core\Field( 'shortdescription' );
    $product->save();

In this example the new record will be inserted into the table. To update information, we load the model, set the new data and call the save() method:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->load( 'demoId' );
    $product->oxarticles__oxtitle = new \OxidEsales\Eshop\Core\Field ( 'productTitle' );
    $product->oxarticles__oxshortdesc = new \OxidEsales\Eshop\Core\Field( 'shortdescription' );
    $product->save();

There are other ways to do the same - without loading the data - just by simply setting the ID with the setId()-method:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->setId( 'demoId' );
    $product->oxarticles__oxtitle = new \OxidEsales\Eshop\Core\Field( 'productTitle' );
    $product->oxarticles__oxshortdesc = new \OxidEsales\Eshop\Core\Field( 'shortdescription' );
    $product->save();

In this example there is a check to determine if this ID exists and if so, the record in the database will be updated with the new record.


Making a query
--------------

.. note::
    Watch a short video tutorial on YouTube: `SQL Statements with the Query Builder <https://www.youtube.com/watch?v=i1_omW8iXJE>`_.

To execute a query, an instance of ``QueryBuilderFactoryInterface`` is required to create the Query Builder.

Since it is defined as a service, you can just inject it into your class:

   .. code:: php

        public function __constructor(QueryBuilderFactoryInterface $queryBuilderFactory)
        {
            $this->queryBuilderFactory = $queryBuilderFactory;
        }

or access it with `Service Locator` if `Dependency Injection` is not possible:

   .. code:: php

      $queryBuilderFactory = ContainerFacade::get(QueryBuilderFactoryInterface::class);

At this point the database connection is ready and the ``create`` method must be called to create a ``queryBuilder``.

   .. code:: php

      $queryBuilder = $queryBuilderFactory->create();

Now all types of SQL queries can be generated, based on the `Doctrine DBAL Documentation <https://www.doctrine-project.org/projects/doctrine-dbal/en/2.5/reference/query-builder.html#sql-query-builder>`__.

Sample:
   .. code:: php

      $queryBuilder
            ->select('*')
            ->from('oxtplblocks')
            ->where('oxshopid = :shopId')
            ->andWhere('oxblockname = :name')
            ->setParameters([
                'shopId'    => $shopId,
                'name'      => $name,
            ]);

      $blocksData = $queryBuilder->execute();
      $blocksData = $blocksData->fetchAllAssociative();


.. note::

    The application's data access layer should always be accessed through the DBAL.
    The use of direct SQL queries is considered a bad practice and should be avoided.

.. _modules-database-transactions:

Transactions
------------

If one transaction fails, the whole chain of nested transactions is rolled back
completely. In some cases it might not be evident that your transaction is already running within an other transaction.

An example how to catch exceptions inside a database transaction:

.. code:: php

    // Start transaction outside try/catch block
    $database->startTransaction();
    try {
        $database->commitTransaction();
    } catch (\Exception $exception) {
        $database->rollbackTransaction();
        if (!$exception instanceof DatabaseException) {
            throw $exception;
        }
    }


.. _modules-database-master_slave:

MySQL master slave
------------------

Doctrine DBAL handles the master slave replication for the OXID eShop on each request. OXID eShop 6
follows these rules:

* once the request is routed to the master, it stays on the master.
* writes and transactions go to master.

Care must be taken when using the OXID eShop database API as this can cause the execution of more
requests than necessary against the MySQL master server and underutilize the MySQL slave server.


Different API methods for read and write
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is a difference between the methods ``DatabaseInterface::select()`` and ``DatabaseInterface::execute()``
The method ``DatabaseInterface::select()`` can only be used for read methods (SELECT, SHOW) that return a result set.
The method ``DatabaseInterface::execute()`` must be used for write methods (INSERT, UPDATE, DELETE) in OXID eShop 6.
