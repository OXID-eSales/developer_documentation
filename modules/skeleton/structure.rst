.. _modules_structure-20170217:

File and folder structure
=========================

Module structure in OXID eShop
------------------------------

All modules exist in the OXID eShop modules directory.

To separate modules it is:
  - **Recommended** to group them by unique **vendor**.
  - **Required** to give them unique id.
  - **Required** to store module files in a directory with a name equal to **module_id**.

So the final structure of a module should be:

.. code::

  .
  └── source
      └── modules
          └── <vendor>
              └── <module_id>
                  ├── composer.json
                  ├── Controller
                  ├── metadata.php
                  ├── Model
                  ├── README.md
                  ├── ...
                  └── tests

Module structure in module repository
-------------------------------------

In the repository it is recommended to keep module files without vendor or module directory.
This allows to clone and use module directly in OXID eShop modules directory.
Possible structure of the module in the repository:

.. code::

  .
  ├── composer.json
  ├── Controller
  ├── metadata.php
  ├── Model
  ├── README.md
  ├── ...
  └── tests


Module transformation
---------------------

:ref:`OXID Composer Plugin<copy_module_via_composer-20170217>` could be used in order to to create vendor and module_id directories

.. _modules_structure_language_files_20170316:

Language files
--------------

Language files are not specified inside the metadata.php but searched by naming conventions inside the module directory.

Example language file:

.. code::

  <?php

    $sLangName = 'English';

    $aLang = array(
        'charset'                     => 'UTF-8',

        'VENDORMYMODULEIDLANGUAGEKEY' => 'my translation of VENDORMYMODULEIDLANGUAGEKEY',
    );

UTF-8 is the only possible charset for language files as the OXID eShop runs by default with UTF-8 itself and
does not convert charsets. If you use any other charset for your language files, you have to use html codes for
special characters.


Frontend
^^^^^^^^

Translation files can be placed in the folders

* ``Application/translations``
* ``application/translations``
* ``translations``

inside your module directory.
If you have a folder ``Application`` or ``application`` inside your module, translation files are searched
inside this directory. Otherwise, they are searched inside the folder ``translations``.
Inside these directory, you have to create a directory for the specific language, e.g. ``de`` or ``en``.
Inside the language specific, directory, the filename has to be _lang.php.

Example:

.. code::

  .
  └── source
      └── modules
          └── <vendor>
              └── <module_id>
                  └── translations
                      └── de
                          └── myvendormymodule_de_lang.php
                      └── en
                          └── myvendormymodule_en_lang.php


.. _modules_structure_language_files_admin:

Admin
^^^^^
Translation files can be placed in

* ``Application/views/admin/``

Example:

.. code::

  .
  └── source
      └── modules
          └── <vendor>
              └── <module_id>
                  └── Application
                      └── views
                          └── admin
                              └── de
                                  └── module_options.php
                                  └── myvendormymodule_admin_de_lang.php
                              └── en
                                  └── module_options.php
                                  └── myvendormymodule_admin_en_lang.php

.. note::
    In order to use translation files in your module, you have to specify at least one class inside the section ``extend``
    in your metadata.php.


Custom JavaScript / CSS / Images
--------------------------------

Create out/src/js/, out/src/img/ and out/src/css/ directories so it fit Shop structure and would be easier to debug
for other people. You can use something like this to include your scripts in to templates:

.. code:: php

  [{oxscript include=$oViewConf->getModuleUrl("{moduleID}", "out/src/js/{js_fle_name}.js")}]
