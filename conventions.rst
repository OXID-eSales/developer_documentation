Conventions for writing developer documentation
===============================================

Sections
--------

- Each page MUST have one page title as the only first level heading, separated by ``===``.
  Otherwise last one would be as document name in Sphinx menu.
- `Subsequent headers <http://docutils.sourceforge.net/docs/user/rst/quickref.html#section-structure>`__ should be marked with ``---``, ``^^^``, ``"""``, ``~~~`` etc.

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

Images
------

To be done...

Diagrams
--------

To be done...
