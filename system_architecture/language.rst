Multiple Languages
==================



Database structure
------------------

OXID eShop can be configured to handle multiple languages.
Some input fields in OXID eShop can be translated into multiple languages, some not. An example for an input field
which can be translated is the title of an article. In the database the title of an article is stored in the column
`oxtitle` of the table `oxarticles`. If you configure two
languages, `de` and `en`, both the `de` and the `en` contents have to be stored somewhere. This is done by using
another column, the column `oxtitle_1` in the table `oxarticles`.
In general OXID eShop stores translations by adding more columns, tables and views to the database if you configure more languages.

Every language has a numeric id. The data for language id 0 goes into `oxarticles\.oxtitle`, data for language id 1
into `oxarticles\.oxtitle_1`, language 2 into `oxarticles\.oxtitle_2`, language 3 into `oxarticles\.oxtitle_3`.
The above mentioned columns are the default available columns of OXID eShop. This means by default, OXID eShop has enough columns
to handle up to four languages.

If you configure a fifth language, the column  `oxarticles\.oxtitle_5` will be added to the database.

From language id 9 on, a new extension table for the table `oxarticles` is created. This table is named
`oxarticles_set1` in our example and has the column `oxarticles_set1\.oxtitle_8`. The column
`oxarticles_set1.OXID` matches `oxarticles.OXID`.




.. uml::

    @startuml

    object oxarticles {
      oxid
      oxtitle
      oxtitle_1
      oxtitle_2
      oxtitle_3
      oxtitle_4
      oxtitle_5
      oxtitle_6
      oxtitle_7
    }


    object oxarticles_set1 {
      oxid
      oxtitle_8
    }

    @enduml


.. note::

    If there is no information yet set for the article title in language id >=8 ,
    there is no entry in the \*_set\* table. So a view trying to use that non existing data
    contains NULL value fields.

Accessing values of multilanguage fields
----------------------------------------

The retrieval of the correct language for the an articles title `oxtitle` is done with database views.
We have views per subshop and language for each table containing multilingual data.
After adding (and deleting as well) a language, views have to be regenerated.

.. note::

    when creating multiple new languages in a row without explicitly updating the views in
    between, we'll have all views available except the ones for the last added language.

Point is now, that when the shop is switched to a certain language (that is active in frontend) and we load
an article object ``$article``, then when accessing ``$article->oxarticles__oxtitle`` we actually get the data for
the currently active language. More specific: assume we have an EE and use subshop 1.
So when we have language id 9 active (let's name it language de), the article
title originates from the core table `oxarticles_set1.oxtitle_9`, this info ends up in `oxv_oxarticle_1_de.oxtitle`
and the article object is loaded from `oxv_oxarticle_1_de`.

If there's anything amiss with the way the views are created, we get incorrect language data or in the
worst case, shop goes offline.
