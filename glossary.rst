Glossary
========

Introduction
------------

In this glossary, we collect terms typical for the OXID world. We collect them in alphabetical order and always try to describe them as easy and abstract as possible.


.. _glossary-edition:

Edition
^^^^^^^

An *edition* is child of the OXID eShop family.

Editions are differentiated mainly by their feature sets.

Currently there are the editions Community, Professional, Enterprise, and B2B.

.. _glossary-installation:

Installation
^^^^^^^^^^^^

The term *installation* is used for modules as well as for OXID eShop itself.

Installation covers only files operation.

For more information about module installation, see :doc:`Module installation and activation </system_architecture/module_installation_activation>`.

Module configuration
^^^^^^^^^^^^^^^^^^^^

The term module *configuration* is used to describe module configuration only in configuration files scope.

For more information about module configuration, see :doc:`Module installation and activation </system_architecture/module_installation_activation>`.

Setup
^^^^^

The term *setup* is used for modules as well as for OXID eShop itself.

After the setup of the eShop, the eShop is launched and can be used.

After setup/activation of a module, the module will be used by the eShop.

The :ref:`Installation<glossary-installation>` has to be done first before the setup can be done.

For more information about module setup, see :doc:`Module installation and activation </system_architecture/module_installation_activation>`.

Meta Package
^^^^^^^^^^^^

A *meta package* defines the kind and the exact version of components of a `OXID Compilation`_.

See the `composer.json <https://github.com/OXID-eSales/oxideshop_metapackage_ce/blob/b-7.0/composer.json>`__
file of the OXID eShop Community Edition meta package for an example.

.. _glossary-oxid_compilation:

OXID Compilation
^^^^^^^^^^^^^^^^

The OXID eShop *compilation* consists of a certain edition of OXID eShop, which is bundled with modules and themes.

For examples, the OXID eSHOP 7.0 contains, among others, the following eShop edition, modules and themes:

* `OXID eShop CE 7.0.1 <https://github.com/OXID-eSales/oxideshop_ce/blob/v7.0.1/CHANGELOG.md>`_
* `Apex theme 1.0.0 <https://github.com/OXID-eSales/apex-theme/blob/v1.0.0/CHANGELOG.md>`_
* `OXID eShop composer plugin 7.1.0 <https://github.com/OXID-eSales/oxideshop_composer_plugin/blob/v7.1.0/CHANGELOG.md>`_
* `Makaira 2.1.0 <https://github.com/MakairaIO/oxid-connect-essential/blob/2.1.0/CHANGELOG.md>`_

Professional Edition and Enterprise Edition compilations additionally contain the Visual CMS module for easy management of CMS content via drag and drop functionality.

The components of an OXID Compilation are defined in a `Meta Package`_.

To ensure the best stability and interoperability, in a compilation the versions of all components are pinned to a specific
patch release.

The components and their version are specified in the user documentation in the respective release note (see https://docs.oxid-esales.com/eshop/en/latest/releases/index.html).

Vendor Prefix
^^^^^^^^^^^^^
For module developers it is necessary to use unique names for namespaces or classes in their OXID eShop extensions.

For more information, see :ref:`development/modules_components_themes/module/certification/inter_module_compatibility:Vendor Prefixes`.

OXID eShop component
^^^^^^^^^^^^^^^^^^^^

A component installed via composer which has the type `oxideshop-component`.

For more information, see :doc:`OXID eShop Component </development/modules_components_themes/component>`.
