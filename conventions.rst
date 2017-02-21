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

To be done...

Use Ref or Doc for links
------------------------

Use `Ref` or `Doc` to create a link to the page of current developer documentation project.

Using Doc
^^^^^^^^^

Use `Doc` when need to link to another file in same catalog.

**Example**:

- Code:
   .. code::

      :doc:`Modules <modules/index>`


- Rendered result:
   :doc:`Modules <modules/index>`

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

E.g. for highlighting a PHP class name in a running text.

.. code::

  Use the function ``Regististry::set()`` here.

results in

Use the function ``Regististry::set()`` here.


Images
------

To be done...

Diagrams
--------

To be done...
