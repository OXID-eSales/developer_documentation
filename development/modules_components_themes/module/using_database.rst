Interacting with the database
=============================

Active records and magic getters
--------------------------------

.. note::
    Watch a short video tutorial on YouTube: `Active Records <https://www.youtube.com/watch?v=JSOlVnMcgSs>`_.

The OXID eShop architecture is based on an MVC design pattern. To implement models, the Active Record pattern is used. In general, each model class is linked to a database table. For example, the ``Article`` model is linked to the ``oxarticles`` table, Order to the ``oxorders`` table etc. All models are stored in the Application/Models directory.

Let's take one of them, for example the ``Article`` model, and try to fetch the product with the ID ``demoId`` from the database:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class); // creating model's object
    $product->load('demoId'); // loading data
    //getting some information
    echo $product->getFieldData('oxtitle');
    echo $product->getFieldData('oxshortdesc');

After loading the model by its ID, you can retrieve its data using the method ``getFieldData`` which can be called on all model objects. As an argument you simply pass the corresponding fieldname from the model's database table.

To set data to a model and store it, you use method ``setFieldData`` followed by method ``save``.

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->setFieldData('oxtitle', 'Example Title');
    $product->setFieldData('oxshortdesc', 'This is an example short description.');
    $product->save();

In this example the new record will be inserted into the table. To update information, we load the model, set the new data and call the save() method:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->load('demoId');
    $product->setFieldData('oxtitle', 'Example Title');
    $product->setFieldData('oxshortdesc', 'This is an example short description.');
    $product->save();

There are other ways to do the same - without loading the data - just by simply setting the ID with the setId()-method:

.. code:: php

    $product = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
    $product->setId('demoId');
    $product->setFieldData('oxtitle', 'Example Title');
    $product->setFieldData('oxshortdesc', 'This is an example short description.');
    $product->save();

In this example there is a check to determine if this ID exists and if so, the record in the database will be updated with the new record.


Making a query
--------------

.. note::
    Watch a short video tutorial on YouTube: `SQL Statements with the Query Builder <https://www.youtube.com/watch?v=i1_omW8iXJE>`_.

To execute a query, an instance of ``QueryBuilderFactoryInterface`` is required to create the Query Builder. Since it is defined as a service, you can just inject it into your class if you are inside another service:

   .. code:: php

        public function __constructor(QueryBuilderFactoryInterface $queryBuilderFactory)
        {
            $this->queryBuilderFactory = $queryBuilderFactory;
        }

or access it with `Service Locator` if `Dependency Injection` is not possible (traditional classes, no service class):

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

If one transaction fails, the whole chain of nested transactions is rolled back completely. In some cases it might not be evident that your transaction is already running within another transaction.

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
