Interacting with database
=========================

Oxid uses active record to work with database.

How to use?
-----------

The OXID eShop architecture is based on MVC patterns. To implement models, active record pattern is used. So in general, each model class is linked with a database
table. For example, the oxArticle model is linked with the oxarticles table, oxorder with the oxorders table etc.
All models are stored in the directory application/models (from OXID eShop v.5.0 and 4.7 on).
Let?s take one of them, for example the oxArticle model, and try to fetch the product (with the ID ?demoId?) data from database:

.. code:: php

    $product = oxNew( 'oxarticle' ); // creating model's object
    $product->load( 'demoId' ); // loading data
    //getting some informations
    echo $product->oxarticles__oxtitle->value;
    echo $product->oxarticles__oxshortdesc->value;

Magic getters are used to get models attributes; they are constructed in this approach:

.. code:: php

    $model->tablename__columnname->value;
    'tablename' is the name of the database table where the model data is stored
    'columnname' is the name of the column of this table containing the data you want to fetch

To set data to a model and store it, database magic setters (with the same approach as magic getters) are used:

.. code:: php

    $product = oxNew( 'oxarticle' );
    $product->oxarticles__oxtitle = new oxField ( 'productTitle' );
    $product->oxarticles__oxshortdesc = new oxField( 'shortdescription' );
    $product->save();

In this example the new record will be inserted into the table. To update an information, we have to load the model, set the new data and call the save()-method:

.. code:: php

    $product = oxNew( 'oxarticle' );
    $product->load( 'demoId' );
    $product->oxarticles__oxtitle = new oxField ( 'productTitle' );
    $product->oxarticles__oxshortdesc = new oxField( 'shortdescription' );
    $product->save();

There are other ways to do the same - without loading the data - just simply setting the ID with the setId()-method:

.. code:: php

    $product = oxNew( 'oxarticle' );
    $product->setId( 'demoId' );
    $product->oxarticles__oxtitle = new oxField ( 'productTitle' );
    $product->oxarticles__oxshortdesc = new oxField( 'shortdescription' );
    $product->save();

In this example, it will be checked if this ID exists and if so, the record in the database will be updated with the new record.