Configuration Deployment
========================

It is easily possible by just copy and pasting the shop configuration yml file to your new environment
then override your setting without changing original shop configuration file by creating an environment yml file.

shop configuration
------------------

All shop configuration are under shops folder with yml format. Also, their filename indicate the shop number.
Folder structure can be seen below:

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1.yml
             └──2.yml
             └── ...

.. note::

    If var directory has not found in the project directory.
    ``composer update`` must be executed or it must created manually.
    Also, each shop must have their own separate yml file.

environment file
-----------------

All environment files are under environment folder with yml format. they follow the same pattern as
shop configuration yml files.

.. code::

  .
  └── var
      └── configuration
          └── shops
             └──1.yml
             └──2.yml
             └── ...
          └── environment
             └──1.yml
             └──2.yml
             └── ...
.. note::

    Environment files for each shop must be created manually at the first time.

Example
--------

Lets assume you have on shop and you would like to deploy you configuration from you development
environment to production environment. Also, you installed paypal module but
in the production environment ``sOEPayPalUsername`` and ``sOEPayPalPassword`` needs a different credentials.
So follow these steps:

1. Create environment folder under the configuration directory and create 1.yml file inside this folder.
2. You need copy and paste the part of your module you need to change. For our example, we want to change moduleSettings section that contains these credentials.
3. Write your new values  for ``sOEPayPalUsername`` and ``sOEPayPalPassword`` and save your file.

.. note::
    We have the same shop configuration for the production environment but
    we have environment file only in production environment. you only need to copy the part that you want to override
    in the environment file. the whole module structure is not necessary but the content formatting is the same.

environment file:

.. code:: yaml

    modules:
      oepaypal:
        moduleSettings:
          -
            group: oepaypal_api
            name: sOEPayPalUsername
            type: str
            value: 'production'
          -
            group: oepaypal_api
            name: sOEPayPalPassword
            type: password
            value: 'xxxxxxxx'
          -
            group: oepaypal_api
            name: sOEPayPalSignature
            type: str
            value: ''
          -
