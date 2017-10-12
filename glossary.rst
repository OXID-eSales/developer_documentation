Glossary
========

Introduction
------------

In this glossary we collect terms typical for the OXID world. We collect them in alphabetical order and always try to describe them as easy and abstract as possible.


.. _glossary-edition:

Edition
^^^^^^^

An edition is child of the OXID eShop family. Editions are differentiated mainly by their feature sets.
Currently there are the editions Community, Professional, Enterprise and B2B.


.. _glossary-meta_package:

Meta Package
^^^^^^^^^^^^

A *meta package* defines the kind and the exact version of components of a `OXID Compilation`_
See the `composer.json <https://github.com/OXID-eSales/oxideshop_metapackage_ce/blob/b-6.0/composer.json>`__
file of the OXID eShop Community Edition meta package for an example.

.. _glossary-oxid_compilation:

OXID Compilation
^^^^^^^^^^^^^^^^

The OXID eShop compilation consists of a certain edition of OXID eShop, which is bundled with the following modules/themes:

* `Flow theme <https://github.com/OXID-eSales/flow_theme/>`__
* `Paymorrow Module <https://github.com/OXID-eSales/paymorrow-module>`__
* `PayPal Module <https://github.com/OXID-eSales/paypal>`__
* `PayOne Module <https://github.com/payone-gmbh/oxid-6>`__
* `Summernote WYSIWYG Editor <https://github.com/OXID-eSales/ddoe-wysiwyg-editor-module>`__

The components of a OXID Compilation are defined in a `Meta Package`_
To ensure the best stability and interoperability, in a compilation, the versions of all components are pinned to a specific
patch release.

.. _glossary-vendor_id:

Vendor ID
^^^^^^^^^

For module developers it is necessary to use unique names for namespaces or classes in their OXID eShop extensions.
One way to achieve this is using an unique ID for your company, which you can register by making a pull request to
`here <https://github.com/OXIDprojects/OXIDforge-pages/blob/master/extension_acronyms.md>`__.
This is ID called a *Vendor ID*. More information regarding the *Vendor ID* can be found on https://oxidforge.org/en/extension-acronyms
