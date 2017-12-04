Libraries
=========

We dropped or exchanged several libraries in the OXID eShop. If you used one of those libraries directly
(not via OXID eShop API or GUI, which is not recommended by OXID eSales),
you have to find a workaround or include the library via your projects root :file:`composer.json` file.

ADODb Lite
^^^^^^^^^^

:ref:`See further information about the therefore made changes. <update-eshop_53_to_6-database-session_storage>`

JpGraph
^^^^^^^

`JpGraph <http://jpgraph.net/>`__ is a graph drawing library. In OXID eShop 4.10 / 5.3 the JpGraph library with
the version 2.5 was included in the directory :file:`core/jpgraph>`.
If you somehow used the functionality of the JpGraph library, we recommend to require it via composer.
There is a `public available package <https://packagist.org/packages/jpgraph/jpgraph>`__
which points to the `JpGraph github repository <https://github.com/ztec/JpGraph/releases>`__.

facebook
^^^^^^^^

As stated in :ref:`this section <update_eshop53_to_6_contribution_modules_facebook>`, the facebook functionality was moved into a module.

smarty
^^^^^^

We exchanged the smarty library from our code base with a `composer required package <https://packagist.org/packages/smarty/smarty>`__.
In the version 4.10 / 5.3 of the OXID eShop was used the smarty version 2.6.25. In the OXID eShop version 6.0 the smarty version 2.6.30 is used.
It should not add much effort to update your code. But if something stops working, we recommend to look through the `smarty documentation <https://www.smarty.net/>`__.

PHPMailer
^^^^^^^^^

We exchanged the PHPMailer library from our code base with a `composer required package <https://packagist.org/packages/phpmailer/phpmailer>`__.
Cause we sticked to the version of this library, there will be nothing to do left for you.

WysiwygPro and the out/pictures/wysiwygpro directory
----------------------------------------------------

This section will follow soon.