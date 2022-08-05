Understanding the OXID eShop template hierarchy and override system
===================================================================

OXID eShop includes a well-defined structure for overriding default templates with custom themes.

The system allows you to quickly alter the visual appearance of OXID eShop without affecting the internal business logic and codebase.

Understand the basic concepts and ideas around the template hierarchy and override system.

Hierarchical Structure
----------------------

All OXID eShop themes use a hierarchical directory structure for their resources. This structure is based on theme, language, and shop.

This directory structure has four levels, as follows:

1. out
#. theme
#. shop, folders named by shop ID
#. language, folders named by shop abbreviation

Level 0 (out)
^^^^^^^^^^^^^

* /out/de/
* /out/en/
* /out/img/
* /out/src/
* /out/tpl/
* /out/pictures/

Level 1 (theme)
^^^^^^^^^^^^^^^

* /out/basic/de/
* /out/basic/en/
* /out/basic/img/
* /out/basic/src/
* /out/basic/tpl/
* /out/basic/pictures/

Level 2 (shop)
^^^^^^^^^^^^^^

* /out/basic/1/de/
* /out/basic/1/en/
* /out/basic/1/img/
* /out/basic/1/src/
* /out/basic/1/tpl/
* /out/basic/1/pictures/

Level 3 (language)
^^^^^^^^^^^^^^^^^^

* /out/basic/1/de/img
* /out/basic/1/de/tpl
* /out/basic/1/de/src
* /out/basic/1/de/pictures
* /out/basic/1/en/img
* /out/basic/1/en/tpl
* /out/basic/1/en/src
* /out/basic/1/en/pictures

Default Structure
^^^^^^^^^^^^^^^^^

The OXID eShop ``/out`` folder directory structure shows how different resources can be placed on different levels, depending on shop owner needs.

* /out/basic/de/ (1)
* /out/basic/en/ (1)
* /out/basic/img/ (1)
* /out/basic/src/ (1)
* /out/basic/tpl/ (1)
* /out/pictures/ (0)

Resource Location
-----------------

The OXID eShop API provides class functions for resource location. ``oxConfig::getDir`` and ``oxConfig::getUrl`` are the two main resource locator methods, handling resource location from the deepest level.

Resource locator methods come in two types, file- or directory-based and mixed:

* Templates – file-based
* Product pictures – file-based
* Language files – mixed
* Images – mixed
* Styles (CSS, JavaScript, sprites) – directory-based

File-based resources can be spread over different hierarchy levels, while directory-based resources have to be copied with all content.

Note that when using directory-based resources, some extra care is always needed, because directory resources are located from the deepest level.

For example, creating an empty ``src`` directory at a deeper level of the directory tree can produce bad CSS URLs, because the directory resource locator will find the deeper existing ``src`` directory, which may not contain all the required resources.

Template Override System
------------------------

OXID eShop implements a template override system to make design customization and maintenance easier. This feature is implemented via the ``sCustomTheme`` option in the ``config.inc.php`` file. This option should be filled with a theme name of your choice.

When a custom theme is specified in ``config.inc.php``, the template override system comes into effect, running two iterations of the resource locators:

1. Custom theme (levels 3…0)
2. Basic theme (levels 3…0)

Figure :ref:`Template_override` illustrates the process:

.. _Template_override:

.. figure:: /media/Template_override.png
   :scale: 100 %
   :alt: Template override

   Fig.: Template override

To explain further, assume that the name of your custom theme is ``custom``. To activate this theme, make a new directory with the same name (``custom``) and structure it as per the ``basic`` theme. Modify the template (``.tpl``) files and copy them to this location.

The shop will now check if there is a modified template file in your ``custom`` theme folder and use it if present.

If it`s not present, it will use the file from the ``basic`` folder.

This works for included files as well.

For directory-based resources (CSS and JavaScript files), just copy the complete tree to the ``custom`` theme folder.

Templates
^^^^^^^^^

The OXID eShop framework searches for specific template files (file-based) and renders them as needed.

For internal Smarty includes ``[{include file=”_header.tpl”}]``, OXID eShop uses a specific callback function, which acts as a generic file-based template getter.

.. code:: bash

   Functions: getTemplatePath(), getTemplateDir(), getTemplateUrl(), getTemplateBase()

Pictures
^^^^^^^^

Product pictures are loaded with article objects (file-based).

.. code:: bash

   Functions: getPictureDir(), getPicturePath(), getPictureUrl(), getIconUrl()


Translations
^^^^^^^^^^^^

The main language file (``lang.php``) is loaded using a file-based resource locator, but at a later stage, the directory containing ``lang.php`` is scanned for other ``*_lang.php`` files (like ``cust_lang.php``).

This makes translation file loading behave like a directory-based resource location.

.. code:: bash

   Functions: getLanguagePath(), getStdLanguagePath(), getLanguageDir()

The order of the files to override ``lang.php`` depends on the OS's file system. There is no special logic in the shop.

Images
^^^^^^

Image files are usually loaded using the combination “directory-based path getter + file name”, but there is a possibility to use file-based getters for images, too.

.. code:: bash

   Functions: getImageUrl(), getImagePath()


Styles, scripts, …
^^^^^^^^^^^^^^^^^^

CSS files are loaded using the combination “directory-based path getter + file name”. There is no way to override resources used inside the CSS file (eg: background images) because their loading is relative to the source CSS file location.

``src/gui`` (“look & feel”) resources located in sub-folders must also be treated as directory-based resources.

.. code:: bash

   Functions: getResourcePath(), getResourceUrl(), getResourceDir()