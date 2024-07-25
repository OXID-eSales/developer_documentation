Use Multilanguage & Multishop Feature in Custom Tables
======================================================

The OXID eShop Enterprise Edition can handle multiple shops and languages. If you want to make use of both features within a custom database table, you need to pay attention for correct structure and registration.

Registration
------------

Create a custom table ``oxexample``. To register this table as a multilanguage table you need to add it to the array ``aMultiLangTables`` in the file ``config.inc.php``:

.. code:: php

    $this->aMultiLangTables = ['oxexample'];

The same goes for the multi shop feature but with the array ``aMultiShopTables``:

.. code:: php

    $this->aMultiShopTables = ['oxexample'];

.. note::

    If one of the configuration parameters do not exist, simply add it to your ``config.inc.php`` file.


Structure
---------

The custom table ``oxexample`` needs the field ``OXSHOPID``. This field describes the origin of the corresponding database record. It is not the reference to a specific shop. The relationships to the different shops are described by another table - usually reffered to as s mapping table - which must be created, too. The naming schema of these mapping tables always consists of the original table name plus ``2shop``. So in our case it's ``oxexample2shop``. The ``oxexample2shop`` table consists of two fields: One is again the ``OXSHOPID``. The other is named ``OXMAPOBJECTID``.

Lastly we add a new field to the ``oxexample`` table which is called ``OXMAPID``. This field is the relationship to the mapping table ``oxexample2shop``.

In short
^^^^^^^^

- ``oxexample.OXSHOPID`` is the record's origin shop.
- ``oxexample.MAPID`` is the reference to ``oxexample2shop.OXMAPOBJECTID``.
- ``oxexample2shop.OXSHOPID`` is the actual Shop ID the record is linked to.


Database Views
--------------

After you created the structure and registered the table you need to regenerate the views:

.. code:: bash
    ./vendor/bin/oe-eshop-db_views_generate

The OXID Framework then creates all the necessary database views for languages, shops and the combination of both (e.g. ``oxv_oxexample_1_en``). Now you can create your corresponding model, fill the table with data and use your dedicated getters or method ``getFieldData`` to always retrieve the correct value regarding language and shop of the current active user.


.. important::

    Please prefix your custom tables and fields with your own abbreviation.
