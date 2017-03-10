Module development
==================

.. toctree::
   :hidden:
   :glob:

   *

.. NOTE::

   The status of this document is in progress. More information will be added later.

Steps for creating a module
---------------------------

- Initiate the repository
- :ref:`Create composer.json file<copy_module_via_composer-20170217>`
- Create metadata file (Information is available in `blog post <https://oxidforge.org/en/extension-metadata-file.html>`__
  and in :ref:`documentation metadata page<metadata-20170307>`)
- :ref:`Override existing OXID eShop functionality<override_eshop_functionality-20170227>`
- :ref:`Create module structure<modules_structure-20170217>`
- :ref:`Add dependencies and autoload via composer<add_dependencies_and_autoload_via_composer-20170217>`
- :ref:`Test module<test_module-20170217>`

More information how to write a module for older OXID eShop versions could be found
`in this tutorial. <https://www.sitepoint.com/build-infinite-scroll-list-oxid-eshop-basics/>`__


Demo Logger module could be used as a simple example
`from GitHub repository. <https://github.com/OXID-eSales/logger-demo-module>`__

PayPal module could be used as an advanced example
`from GitHub repository. <https://github.com/OXID-eSales/PayPal>`__
