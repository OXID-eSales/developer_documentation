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

The `WysiwygPro` html editor in OXID eShop 5 Professional Edition and Enterprise Edition was replaced with the module
`WYSIWYG Editor` in OXID eShop 6. You have to read this section and take actions if you either:

* uploaded files (e.g. images) in any input field managed by the `WysiwygPro` editor. This can be the
  long description of an article or any field managed by a 3rd party module.
* or used the `WysiwygPro` directory :file:`out/pictures/wysiwygpro` directly.

In this case you have to run the following steps:

1. Move the files from the old directory to the new directory:

  #. Create the folder :file:`out/pictures/ddmedia` in your OXID eShop 6 and make it writable.

  #. Move all files from the folder :file:`out/pictures/wysiwygpro` of your OXID eShop 5 to the folder
     :file:`out/pictures/ddmedia` in your OXID eShop 6.

2. Index the files inside the directory :file:`out/pictures/ddmedia` in order to use them with the `WYSIWYG Editor`:

  #. The PHP script :download:`index_files_for_mediagallery <../resources/wysiwygpro/index_files_for_mediagallery>`
     read all files inside the directory :file:`out/pictures/ddmedia` and creates an index in the database. Download it.
  #. Copy the script to the folder :file:`out/pictures/ddmedia`.
  #. Make the script executable.
  #. Edit the script and configure your database connection at the top.
  #. Execute the script:

     * Go to a shell
     * Change your directory to :file:`out/pictures/ddmedia`
     * Execute ``./index_files_for_mediagallery``

  #. Delete the script.

3. Update existing contents in the database to use the new directory:

  #. Download the PHP script :download:`migrate_existing_wysiwygpro_contents <../resources/wysiwygpro/migrate_existing_wysiwygpro_contents>`
     The goal of this script is to replace all occurences of the directory :file:`out/pictures/wysiwygpro` with
     :file:`out/pictures/ddmedia` in all possible database tables.
  #. Open this file and configure the database connection to your OXID eShop 4.10 / 5.3 database at the top.
  #. If you have configured additional languages or use own tables storing contents of `WysiwygPro`, you may have to
     configure additional fields and tables inside the script. Please see the instructions inside the script.
  #. Execute the script:

     * Go to a shell
     * Execute ``/path/to/the/script/migrate_existing_wysiwygpro_contents``

  #. Delete the script.
