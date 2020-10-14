Module skeleton: metadata, composer and structure
=================================================

In order to create a working OXID eShop module, you have to create a certain file structure inside your module
and use certain metadata files.

.. toctree::
    :titlesonly:
    :glob:
    :maxdepth: 2

    metadataphp/index
    composerjson/index
    *

.. note::

    The file :file:`composer.json` is only necessary if you want to use composer to install a module, add dependencies
    or autoload PHP files.

.. note::

    We deprecated supporting metadata version 1, 1.1 and 1.2.
    Therefore, it is recommended to use version 2 or later.