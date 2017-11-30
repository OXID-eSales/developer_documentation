Update from pre-release versions to OXID eShop 6.0.0
====================================================

Prepare update of OXID eShop Compilation to v6.0.0
--------------------------------------------------

Before updating OXID eShop compilation it is necessary to perform preparative steps for the following modules,
which are included in the compilation.


Visual CMS (only Professional and Enterprise Edition)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This module will be updated from version 2.0.0 to version 3.0.0 by the compilation update

1. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> Visual CMS`: click "deactivate"
2. In the file system of your HTTP server: backup the folder :file:`<project_root>source/modules/ddoe/visualcms` (optional)
3. In the file system of your HTTP server: remove the folder :file:`<project_root>"source/modules/ddoe/visualcms`
4. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> Installed Modules`. You will see the message '*Invalid modules detected*'. '*Do you want to delete all registered module information and saved configurations?*' Click '*Yes*'

VisualCMS Widgets Migration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you have created own shortcode classes by extending the class *ddvisualeditor_shortcode*, change your shortcode class parent from *ddvisualeditor_shortcode* to *\\OxidEsales\\VisualCmsModule\\Application\\Model\\VisualEditorShortcode*

.. code ::

    class your_shortcode extends \OxidEsales\VisualCmsModule\Application\Model\VisualEditorShortcode
    {
    }


*Note:* Do not add your shortcode classes themselves to any namespace.

WYSIWYG Editor + Mediathek
^^^^^^^^^^^^^^^^^^^^^^^^^^
This module will be updated from version 1.0.0 to version 2.0.0 by the compilation update

1. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> WYSIWYG Editor + Mediathek`: click "deactivate"
2. In the file system of your HTTP server: backup the folder :file:`<project_root>source/modules/ddoe/wysiwyg` (optional)
3. In the file system of your HTTP server: remove the folder :file:`<project_root>source/modules/ddoe/wysiwyg`
4. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> Installed Modules`. You will see the message '*Invalid modules detected*'. '*Do you want to delete all registered module information and saved configurations?*' Click '*Yes*'


Update of OXID eShop Compilation to v6.0.0
------------------------------------------

**1. Change the metapackage version**

On your HTTP server, please edit :file:`<project_root>composer.json` and update the metapackage version to ``^v6.0.0``

.. code ::

  "require": {
    "oxid-esales/oxideshop-metapackage-ce": "^v6.0.0"
  },


*Note:*  If you are using a different edition of OXID eShop the require string may differ.


**2. Update requirements and plug-ins**


In the CLI of your HTTP server run :command:`composer update` without executing scripts or plugins:

.. code ::

    cd <project_root>
    composer update --no-plugins --no-scripts


**3. Execute script tasks and composer plug-in tasks**


In the CLI of your HTTP server run by running :command:`composer update` without parameters:

.. code ::

    cd <project_root>
    composer update


**4. Execute the OXID eShop migrations**

In the CLI of your HTTP server run:

.. code ::

    cd <project_root>
    vendor/bin/oe-eshop-db_migrate migrations:migrate


**5. Re-activate specific modules**

1. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> Visual CMS`: click "activate"
2. Go to OXID eShop :menuselection:`Admin --> Extensions --> Modules --> WYSIWYG Editor + Mediathek`: click "activate"
