Files
=====

This section describes the steps to update the file structure from a OXID eShop version 4.10 / 5.3 to version 6. As there are
many changes in the file structure, the approach for the update is:

1. setup an OXID eShop 6 in parallel to your existing OXID eShop 4.10 / 5.3
2. copy the files described in the following sections from the OXID eShop 4.10 / 5.3 to the OXID eShop 6

Please always pay attention to upper and lower case letters in file and directory names.

Own Scripts And / Or Configuration
----------------------------------

* use UTF-8 encoding for all your scripts
* if you made changes to :file:`.htaccess` files in OXID eShop 4.10 / 5.3, port them to the equivalent :file:`.htaccess` files in OXID eShop 6.
  Pay attention to the fact that the :file:`.htaccess` files in OXID eShop 6 are compatible with Apache 2.2 and 2.4 where
  OXID eShop 4.10 / 5.3 :file:`.htaccess` file were only compatible with Apache 2.2.
* port your changes from :file:`config.inc.php` of OXID eShop 4.10 / 5.3 to the :file:`config.inc.php` file of OXID eShop 6.

Languages
---------
If you added a new language (additionally to the languages ``de`` and ``en``) in OXID eShop 4.10 / 5.3, you have to
port this language to OXID eShop 6 because many language constants changed. In order to port the language, you have to either:

* replace the language files by downloading an OXID eShop 6 compatible language pack. E.g. from a 3rd party vendor or via `translate.oxidforge.org <http://translate.oxidforge.org>`__.
* or copy and update the language files manually.

Language related files reside in the following directories
(also see `OXIDprojects/languages <https://github.com/OXIDprojects/languages>`__ for a language pack example):

  * :file:`application/translations` in OXID eShop 4.10 / 5.3 respectively :file:`Application/translations` in OXID eShop 6
  * :file:`application/views/admin` in OXID eShop 4.10 / 5.3 respectively `Application/views/admin` in OXID eShop 6
  * :file:`application/views/yourThemeName` in OXID eShop 4.10 / 5.3 respectively :file:`Application/views/yourThemeName` in OXID eShop 6
  * :file:`out/yourThemeName` in OXID eShop 4.10 / 5.3 and also :file:`out/yourThemeName` in in OXID eShop 6
  * :file:`setup` in OXID eShop 4.10 / 5.3 respectively :file:`Setup`  in OXID eShop 6


Smarty Plugins
--------------

If you created own Smarty plugins in OXID eShop 4.10 / 5.3 and installed them by copying them to the
folder :file:`core/smarty/plugins`, move them to the folder :file:`Core/Smarty/Plugins` in OXID eShop 6.

Folder out
----------

Copy the files from the folders:

* :file:`out/downloads`
* :file:`out/media`
* :file:`out/pictures` (except :file:`out/pictures/wysiwygpro` and :file:`out/pictures/generated`)

to the equivalent folders in OXID eShop 6. For updating the images used in WYSIWYG Pro,
:ref:`see this section <update-eshop53_to_6-wysiwygpro>`


Folders bin / export / log / export
-----------------------------------

Copy the files from these directories. Do not copy the standard :file:`.htaccess` files. If you made changes
to :file:`.htaccess` files in OXID eShop 4.10 / 5.3, port them to the equivalent :file:`.htaccess` files in OXID eShop 6.

Modules
-------

* if you made changes to the file :file:`modules/composer.json` in OXID eShop 4.10 / 5.3, port those changes into the
  root :file:`composer.json` file in OXID eShop 6 or into a modules :file:`composer.json` file
* if you made changes to the file :file:`modules/functions.php`  in OXID eShop 4.10 / 5.3, port those changes into the
  equivalent file :file:`modules/functions.php` file in OXID eShop 6

For updating a module itself, have a look at the :doc:`Guideline for porting modules to OXID eShop version 6.0 <../../modules/index>`
