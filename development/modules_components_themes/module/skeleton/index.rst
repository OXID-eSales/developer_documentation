Module skeleton: metadata, composer and structure
=================================================

.. note::
    Watch a short video tutorial on YouTube: `Module Installation & Configuration <https://www.youtube.com/watch?v=WGeHtJCHmyA>`_.

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

    Support of metadata version 1, 1.1 and 1.2 was dropped. Please use version 2 or later.