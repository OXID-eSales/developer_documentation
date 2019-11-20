Conventions for writing developer documentation
===============================================

Sections
--------

- Each page MUST have one page title as the only first level heading, separated by ``===``.
  Otherwise last one would be as document name in Sphinx menu.
- `Subsequent headers <http://docutils.sourceforge.net/docs/user/rst/quickref.html#section-structure>`__ should be marked with ``---``, ``^^^``, ``"""``, ``~~~`` etc.

**Good examples**:

.. code::

   Title
   =====

   First level
   -----------

   Second level
   ^^^^^^^^^^^^

   First level
   -----------

   Second level
   ^^^^^^^^^^^^

   Third level
   """""""""""

   Forth level
   ~~~~~~~~~~~

**Bad examples**:

-  Inconsistent headers:

.. code::

   First level
   -----------

   Second level
   """"""""""""

   Third level
   ^^^^^^^^^^^

-  Two titles in a page:

.. code::

   Title
   =====

   First level
   -----------

   Title
   =====

   First level
   -----------


External links
--------------

External links can be used as described in example.

**Example**:

- Code:
   .. code::

      `OXID eSales website <https://www.oxid-esales.com/>`__


- Rendered result:
   `OXID eSales website <https://www.oxid-esales.com/>`__

Use Ref or Doc for links
------------------------

Use `Ref` or `Doc` to create a link to the page of current developer documentation project.

Using Doc
^^^^^^^^^

Use `Doc` when need to link to another file in same catalog.

**Example**:

- Code:
   .. code::

      :doc:`Modules <development/modules_components_themes/module/index>`


- Rendered result:
   :doc:`Modules <development/modules_components_themes/module/index>`

.. _conventions_for_using_ref-20160419:

Using Ref
^^^^^^^^^

Use Ref when need to link to specific file part.
References in Sphinx are global, so use unique section name per document and time to form reference.
Ref anchor schema: ``section_name_with_underscores-YYYYMMDD``

**Good examples**:

- Code for Anchor inside page:
   .. code::

      .. _conventions_for_using_ref-20160419:

      Using Ref
      ---------

- Code for link which can be in same or other page:
   .. code::

      :ref:`Using Ref <conventions_for_using_ref-20160419>`

- Rendered link result
   :ref:`Using Ref <conventions_for_using_ref-20160419>`


**Bad examples**:

Prefixed with directory name:

.. code::

   .. _common_agreements-general-conventions_for_development_wiki_rst_document-20160120:

Not suffixed with date:

.. code::

   .. _conventions_for_development_wiki_rst_document:

Tables
------

.. code::

  +-------------------+--------------------+
  | Column 1 Heading  | Column 2 Heading   |
  +===================+====================+
  | Column 1 Cell 1   | Column 2 Cell1     |
  +-------------------+--------------------+
  | Column 1 Cell 2   | Column 2 Cell 2    |
  +-------------------+--------------------+

results in

+-------------------+--------------------+
| Column 1 Heading  | Column 2 Heading   |
+===================+====================+
| Column 1 Cell 1   | Column 2 Cell1     |
+-------------------+--------------------+
| Column 1 Cell 2   | Column 2 Cell 2    |
+-------------------+--------------------+

Code
----

See `http://docutils.sourceforge.net/docs/ref/rst/directives.html#code <http://docutils.sourceforge.net/docs/ref/rst/directives.html#code>`__.
Be sure to indent the code with spaces.

Example:

.. code::

  .. code:: php

    namespace \OxidEsales\Eshop\Community;

    class Example {}

results in

.. code:: php

  namespace \OxidEsales\Eshop\Community;

  class Example {}


Highlight Text
--------------

Inline markup for menu navigation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code::

    :menuselection:`Artikel verwalten -->  Artikel`

results in: :menuselection:`Artikel verwalten -->  Artikel`

Inline markup for file names
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code::

    :file:`/usr/lib/python2.{x}/site-packages`

results in: :file:`/usr/lib/python2.{x}/site-packages`


Inline markup for controls
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code::

    :guilabel:`Cancel`

results in: :guilabel:`Cancel`

Inline markup for code
^^^^^^^^^^^^^^^^^^^^^^

.. code::

    ``exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']``

results in: ``exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']``

Inline markup for commands
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code::

    :command:`cd ..\\GitHub\\Dokumentation-und-Hilfe`

results in: :command:`cd ..\\GitHub\\Dokumentation-und-Hilfe`


Inline markup for downloads
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code::

    :download:`/downloads/varnish/6.0.0/default.vcl`

.. _conventions_images:

Images
------

-  Do not commit big files or images. Use a link to an external source inside repository. This will help to keep repository small.

.. raw:: html

   <p>
      <img width="100" src="https://www.google.co.uk/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"/>
   </p>

.. code:: html

   .. raw:: html

      <p>
         <img width="100" src="https://www.google.co.uk/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"/>
      </p>

UML diagrams
------------

Please do not commit big files or images.

Use UML source written with `Plant UML <http://plantuml.com/>`__ or a similar tool instead of an UML image.

.. note::

   PHPStorm has `Plant UML plugin <https://plugins.jetbrains.com/plugin/7017>`__ which generates UML on the fly.
   Look for "PlantUML tab" at the right upper corner near "Remote Host" to see generated result.

**Example**:

**- Rendered result**:

.. uml::

   @startuml
   :functions.php oxNew('oxArticle');
   :oxUtilsObject::oxNew('oxArticle');
   if (Find real class name in cache) then
      ->found;
      :Get class name from static cache;
   else
      ->not found;
      :oxUtilsObject::getClassName();
      :oxEditionCodeHandler::getClassName();
      if (shop edition check) then
         ->Enterprise;
         :OxidEsales\Enterprise\ClassMap;
      else
         ->Professional;
         :OxidEsales\Professional\ClassMap;
      endif
      :oxModuleChainsGenerator::createClassChain('\Enterprise\Article', 'oxArticle');
      :$extensionsList = oxModuleVariablesLocator::getModuleVariable('aModules');
      :oxModuleChainsGenerator:filterInactiveExtensions($extensionsList);
      :$classExtensionsList = $extensionsList['oxArticle'];
      :oxModuleChainsGenerator:createClassExtensions($classExtensionsList, '\Enterprise\Article');

   endif
   :Create class with new \Enterprise\Article;
   @enduml

**- Code**:

.. code::

   .. uml::

      @startuml
      :functions.php oxNew('oxArticle');
      :oxUtilsObject::oxNew('oxArticle');
      if (Find real class name in cache) then
         ->found;
         :Get class name from static cache;
      else
         ->not found;
         :oxUtilsObject::getClassName();
         :oxEditionCodeHandler::getClassName();
         if (shop edition check) then
            ->Enterprise;
            :OxidEsales\Enterprise\ClassMap;
         else
            ->Professional;
            :OxidEsales\Professional\ClassMap;
         endif
         :oxModuleChainsGenerator::createClassChain('\Enterprise\Article', 'oxArticle');
         :$extensionsList = oxModuleVariablesLocator::getModuleVariable('aModules');
         :oxModuleChainsGenerator:filterInactiveExtensions($extensionsList);
         :$classExtensionsList = $extensionsList['oxArticle'];
         :oxModuleChainsGenerator:createClassExtensions($classExtensionsList, '\Enterprise\Article');

      endif
      :Create class with new \Enterprise\Article;
      @enduml