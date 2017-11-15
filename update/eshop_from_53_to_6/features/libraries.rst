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
`WYSIWYG Editor` in OXID eShop 6. You have to read this section and take actions if you either

* uploaded own files (e.g. images) in any input field managed by the `WysiwygPro` editor. This can be the
  long description of an article or any field managed by a 3rd party module.
* or used the `WysiwygPro` directory :file:`out/pictures/wysiwygpro` directly

In this case you have to migrate your files on the filesystem and in the database from `WysiwygPro` to the new `WysiwygPro` editor.
There are two main steps required for the migration:

1. Move the files from the old directory to the new directory and take care your files can be used by the `WYSIWYG Editor` by following these steps:

  #. Activate the module `WYSIWYG Editor + Mediathek` in your OXID eShop 6.
     (:menuselection:`Extensions --> Modules --> WYSIWYG Editor + Mediathek --> Activate`).
  #. Go to a random text field managed by the `WYSIWYG Editor`, e.g. the description text of an article.
     Click the button of the `WYSIWYG Editor` to insert a picture.

     .. image:: https://user-images.githubusercontent.com/12152978/33273789-9fb0ea74-d38e-11e7-83bc-6055b045219b.png
        :alt: Link to insert a picture in the WYSIWYG editor


  #. The media gallery will be opened.

     .. image:: https://user-images.githubusercontent.com/12152978/33273797-a403966c-d38e-11e7-9819-3c21e4d0e142.png
        :alt: The media gallery without usable files

  #. Go to the tab :menuselection:`Upload` and upload all files which were in the folder
     :file:`out/pictures/wysiwygpro` of your OXID eShop 4.10 / 5.3. This copies all files to the directory
     :file:`out/pictures/ddmedia` preserving their original file names. In addition the `WYSIWYG Editor` registers
     the files which makes them usable from any input field managed by the `WYSIWYG Editor`.

     .. image:: https://user-images.githubusercontent.com/12152978/33273799-a60d13e8-d38e-11e7-9345-8d077794c20a.png
        :alt: The media gallery after files were uploaded

2. Update existing contents in the database to use the new directory:

    #. Download the PHP script :download:`migrate_wysiwygpro_files.php <../resources/wysiwygpro/migrate_wysiwygpro_files.php>`
       The rough goal of this script is to replace all occurences of the directory :file:`out/pictures/wysiwygpro` with
       :file:`out/pictures/ddmedia` in all possible database tables.
    #. Open this file and configure the database connection to your OXID eShop 4.10 / 5.3 database.
    #. If you have configured additional languages or use own tables storing contents of `WysiwygPro`, you may have to
       configure additional fields and tables inside the script. Please see the instructions inside the script.
    #. Run the PHP script