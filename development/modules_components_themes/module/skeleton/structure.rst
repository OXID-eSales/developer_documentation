.. _modules_structure-20170217:

File and folder structure
=========================

To separate modules it is:
  - **Required** to give them a unique id.

Module structure in module repository
-------------------------------------

Possible structure of the module in the repository:

.. code::

  .
   └── <module_directory>
      ├── composer.json
      ├── Controller
      ├── metadata.php
      ├── Model
      ├── assets
      ├── README.md
      ├── ...
      └── tests

.. _modules_structure_language_files:

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

.. _modules_structure_language_files_frontend:

Frontend
^^^^^^^^

Translation files can be placed in the folders

* ``Application/translations``
* ``translations``

inside your module directory.
If you have a folder ``Application`` (first letter is capital) inside your module, translation files are searched
inside this directory. Otherwise, they are searched inside the folder ``translations``.
Inside these directory, you have to create a directory for the specific language, e.g. ``de`` or ``en``.
Inside the language specific, directory, the filename has to be _lang.php.

Example:

.. code::

  .
   └── <module_directory>
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
* ``views/admin/``

Example:

.. code::

  .
  └── <module_directory>
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

Create an ``assets`` directory in your module root directory and put all your JS, CSS and images in this ``assets`` directory.
all of your files in assets folder will be symlink to ``out/modules/<module-id>/``

Example:

.. code::

  .
  └── <module_directory>
      └── assets
          └── css
              └── example.css
          └── js
              └── example.js
          └── img
              └── example.jpg


You can use something like this to include your scripts in to templates:

.. code:: php

  [{oxscript include=$oViewConf->getModuleUrl("{moduleID}", "js/{js_fle_name}.js")}]
