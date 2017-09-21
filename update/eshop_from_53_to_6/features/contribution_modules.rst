Extracted features
==================

Introduction to extracted features
----------------------------------

Some features in the core of OXID eShop 4.10 / 5.3 were extracted into OXID eShop 6 compatible modules.
If you used or extended one of those features in OXId eShop 4.10 / 5.3, you should read this document carefully.
The mentioned OXID eShop modules are available on `Github <https://github.com/OXIDprojects>`__. If you want to
contribute to the development of one of those modules, this is possible via a pull request.

In the following sections the affected features and the steps for migrating existing data are described.
If you extended one of those features in OXID eShop 4.10 / 5.3, you have to extend the corresponding contribution module in OXID eShop 6.
If you did not use or extend one of those features in OXID eShop 4.10 / 5.3, there is nothing to to.

Tags
----

The feature to tag products was was extracted to the
module  `Tags <https://github.com/OXIDprojects/tags-module>`__.

Migration
^^^^^^^^^

Possible places for data migrations:

* In OXID eShop 4.10 / 5.3, the database table ``oxartextends`` had the columns ``OXTAGS_*``. In order to migrate your
  existing tags, simply rename these columns in OXID eShop 6 to to ``OETAGS_*``
* related functionality like the search might also be affected as it relies on the tags feature in OXID eShop 4.10 / 5.3
* the tag categories (``http://myoxideshop.com/tags/*``) are not available any more in OXID eShop 6
* regeneration of seo links (table ``oxseo``) might be necessary
* the config variable ``sTagSeparator`` in OXID eShop 4.10 / 5.3 is called ``oetagsSeparator`` in the contribution module
* the config variable ``blShowTags`` (Display tags in eShop) is called in OXID eShop 4.10 / 5.3 and
  located in :menuselection:`Core Settings --> Settings --> Shop Frontend` in the OXID eShop admin. In the contribution
  module this setting is called ``oetagsShowTags`` and located in the modules setting tab.
* the config variable ``aSearchCols`` (fields to be considered in the Search) needs to be updated as it contains
  ``oxtags`` in OXID eShop 4.10 / 5.3.
* Tags related css classes were removed/renamed in the module.
* the Tags javascript widget was removed/renamed in the module.


.. important::

  The performance of the Tags module might suffer as the module does not use the FULLTEXT feature of the database engine MyISAM any more.


.. important::

    EE needs the EE_addon tags module in addition to work with varnish.
    (see `installation instructions <https://github.com/OXIDprojects/tags-module/blob/master/README.rst>`__)


Lexware export / (XML export of orders)
---------------------------------------

The export of orders into XML documents (Lexware export) in OXID eShop 4.10 / 5.3 was extracted to the
module  `Lexware Export <https://github.com/OXIDprojects/lexware-export-module>`__.

Migration
^^^^^^^^^

There is a config option for VAT settings for the XML export. In OXID eShop 4.10 / 5.3, this option was called ``aLexwareVAT``
and located in the OXID eShop admin in :menuselection:`Core Settings --> Settings --> Other settings`.
In OXID eShop 6, this option is called ``aOELexwareExportVAT`` and you will find this setting in the settings tab of the Lexware export module.
Be sure to migrate your settings from this config option.

If you extended or modified this functionality or translations in OXID eShop 4.10 / 5.3, you have to port your changes.

Extended Order administration (Order Summary And Pick Lists)
------------------------------------------------------------

The extended order administration feature of OXID eShop 4.10 / 5.3 was extracted to the module
`Extended Order Administration <https://github.com/OXIDprojects/extended-order-administration-module>`__.

If you extended or modified this functionality or translations in OXID eShop 4.10 / 5.3, you have to port your changes.


Statistics
----------

The statistics feature of OXID eShop 4.10 / 5.3 (e.g statistics about conversion rate, number of visitors) was extracted to the module
`Statistics <https://github.com/OXIDprojects/statistics-module>`__.

Migration
^^^^^^^^^

In OXID eShop 4.10 / 5.3, the statistics were stored in the tables ``oxlogs`` and ``oxstatistics``. In OXID eShop 6, they are stored in the
tables ``oestatisticslog`` and ``oestatistics``. In order to migrate your existing entries, simple copy and rename the tables ``oxlogs`` and ``oxstatistics``.

If you extended or modified this functionality, translations or database tables in OXID eShop 4.10 / 5.3, you have to port your changes.

.. _update_eshop53_to_6_contribution_modules_facebook:

Facebook
--------

The Facebook feature of OXID eShop 4.10 / 5.3 was extracted to the module `Facebook Social Plugins <https://github.com/OXIDprojects/facebook-social-plugins-module>`__.
If you extended or modified this functionality or translations in OXID eShop 4.10 / 5.3, you have to port your changes.

.. important::

    The Facebook functionality in OXID eShop 4.10 / 5.3 used an old version of the Facebook API and therefor partly did not
    work. Our recommendation is to use a third party module for facebook integration.

Captcha
-------

The captcha feature of OXID eShop 4.10 / 5.3 was extracted to the module `Captcha <https://github.com/OXIDprojects/captcha-module>`__.
If you extended or modified the captcha functionality, the database table ``oxcaptcha`` or translations in OXID eShop 4.10 / 5.3, you have to port your changes.

.. important::

    Our recommendation is to use a third party module for captcha functionality as there are more advanced approaches.



Guestbook
---------

The guestbook feature of OXID eShop 4.10 / 5.3 was replaced by the module `Guestbook module <https://github.com/OXIDprojects/guestbook-module>`__.

.. important::

    Currently it's not possible to use this feature in the Enterprise Edition, the module is for Community and Professional Edition only at the moment.

Migration
^^^^^^^^^

* In OXID eShop 5.3, the guestbook entries were stored in the table ``oxgbentries``. In OXID eShop 6, they are stored in the
  table ``oeguestbookentry``. In order to migrate your existing guestbook entries, simple copy and rename the table ``oxgbentries``.
* There are config options for the maximum guestbook entries a user can write per day and if you want to moderate the guestbook.
  In OXID eShop 4.10 / 5.3. these config options were called ``iMaxGBEntriesPerDay`` and ``blGBModerate`` (database table ``oxconfig``).
  In the OXID eShop they were located in :menuselection:`Core Settings --> Settings --> Other settings`.
  In OXID eShop 6, you will find these settings in the settings tab of the guestbook module. They are called
  ``oeGuestBookMaxGuestBookEntriesPerDay`` and ``oeGuestBookModerate``. Be sure to migrate your settings from these
  config options.
* seo links have to be regenerated

If you extended or modified the guestbook functionality, translations or seo settings in OXID eShop 4.10 / 5.3, you have to port your changes.


InvoicePDF left overs
^^^^^^^^^^^^^^^^^^^^^

In the version 4.10 / 5.3 of the OXID eShop PDF invoice generation was included.
In OXID eShop 6 it is removed from the OXID eShop code and added as an
`own repository <https://github.com/OXIDprojects/pdf-invoice-module>`__.

