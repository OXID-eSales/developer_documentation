Update OXID eShop from a 6.x version to a 6.y version
=====================================================

1. For updating your project from any 6.0 version to another 6.x version, please edit the metapackage version
   requirement in your root :file:`composer.json` file to the desired version, e.g. ``^v6.0.0-rc.2``
2. Execute :command:`composer update` first without executing scripts or plugins

.. code ::

    composer update --no-plugins --no-scripts

3. Execute composer update and execute installation tasks

.. code ::

    composer update

Change dependencies
-------------------

This is an example if you want to include the libary `monolog/monolog` into your project. The steps are similar
for changing existing requirements.

#. :command:`cd` to the directory where your root :file:`composer.json` is located

#. Either edit the :file:`composer.json` directly or use the command

.. code ::

   composer require --no-update monolog/monolog

3. Run composer update two times:

.. code ::

   composer update --no-plugins --no-scripts
   composer update