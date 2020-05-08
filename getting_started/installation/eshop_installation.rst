Install OXID eShop compilation
==============================

There are two ways to install the shop which are graphical and command-line tools. In graphical tools, shop can be installed via wizard setup process in browser, and with command-line tools a provided command can be run to install the shop quickly.

More information can be found in the `User documentation <https://docs.oxid-esales.com/eshop/en/6.2/installation/index.html>`__.

On this page, additional developer specific information is provided.

.. _eshop_installation_deploy_source_code:

Providing shop files
--------------------

    Composer will automatically download the source files of the specified version and edition of OXID eShop.

    In a second step it will install fixed versions of the project dependencies as defined in the meta package of the installed
    edition of OXID eShop.

    After Composer installed all dependencies, it executes several tasks. One of them is to generate the classes of the
    :doc:`unified namespace <../../system_architecture/unified_namespace/index>` `\\OxidEsales\\Eshop`.


    **Watch out for error messages during the installation procress.**

    See our :doc:`troubleshooting <./troubleshooting>` section for solutions.

    If by any reason you are not able to use Composer to install OXID eShop or one of its modules on a specific application
    server, please skip this step and read :doc:`these instructions<eshop_installation_without_composer>` to learn how to
    deploy the source code using an alternative way.

.. note::

        If you install the compilation **without** the `--no-dev` option, the following development tools will be installed together with OXID eShop:

        * OXID eShop `Testing Library <https://github.com/OXID-eSales/testing_library>`__
        * `IDE code completion support <https://github.com/OXID-eSales/oxid-eshop-ide-helper>`__ for OXID eShop
        * `Azure Theme <https://github.com/OXID-eSales/azure_theme>`__ for selenium tests

Known issue on MacOS
--------------------

    If you get the following error in the migrations while installing the OXID eShop on a MAMP
    [PDOException]
    SQLSTATE[HY000] [2002] No such file or directory

    Look at `this blog entry <https://andreys.info/blog/2007-11-07/configuring-terminal-to-work-with-mamp-mysql-on-leopard>`__ and do the following steps:

    .. code:: bash

        sudo mkdir /var/mysql
        sudo ln -s /Applications/MAMP/tmp/mysql/mysql.sock /var/mysql/mysql.sock
        sudo chown _mysql /var/mysql/mysql.sock
        sudo chmod 777 /var/mysql/mysql.sock

Always use Composers' --no-plugins switch
-----------------------------------------

    It is a best practice to run all Composer commands, which update components with the --no-plugins option and
    to run update action in a separate command.
    Like this it is ensured, that the latest versions of the plugins are used.

    Examples:

    .. code:: bash

        # Update all components including Composer plugins to their latest version
        composer update --no-plugins

        # execute plugins in their latest version
        composer update

    .. code:: bash

        # Install new component and update dependencies including Composer plugins to the required version
        composer require --no-plugins monolog/monolog
        composer install # execute the plugins in their required version


Temporarily add Composer dependencies
-------------------------------------

    In general you should extended the functionality of OXID eShop by writing modules, which provide there own dependency
    management. See :ref:`module section <modules-20170527>` for details.
    Nevertheless, for a quick hack or a proof of concept, additional dependencies could be added via the composer.json file
    in the *project root directory*.

    For example, if there is a need to add runtime library like monolog run:

    .. code:: bash

       composer require --no-plugins monolog/monolog
       composer install

    If there is a need to add a development dependency like the OXID eShop testing library:

    .. code:: bash

       composer require --dev --no-plugins oxid-esales/testing-library:dev-master
       composer update


Resolving Composer dependency conflicts
---------------------------------------

The meta package defines, which exact versions of the components will be installed by Composer.
These versions have been tested by OXID eSales to ensure, that OXID eShop works as expected and to avoid security issues.
There might be situations, where a 3rd party dependency conflicts with the version defined in the meta package.
You may resolve this version conflict by adding an alias in the project composer.json file in the *project root directory* like this:

.. code:: bash

    {
        "require": {
            "doctrine/cache":"v1.6.0 as v1.6.1"
        }
    }

This lowers doctrine cache version to v1.6.0 even while the meta package requires v1.6.1.

See `the documentation <https://getcomposer.org/doc/articles/aliases.md#require-inline-alias>`__
or `this issue in GitHub <https://github.com/composer/composer/issues/3387>`__ for details

Building your own compilation
-----------------------------

A meta package defines the kind and versions of components of a compilation.
You may want build your own compilation for two reasons:

**To re-define the components of a compilation:**

* Create a new meta package by using the existing one as a template
* Re-define the components and their versions

  * Require different versions of existing components
  * Remove predefined components
  * Require new components

**To add new components to the compilation:**

* Create a new meta package
* Require new components
* Require the existing meta package in the newly created meta package

Make this new meta package available through
`Packagist <https://getcomposer.org/doc/05-repositories.md#packages>`__,
`GitHub <https://getcomposer.org/doc/05-repositories.md#vcs>`__,
`file system <https://getcomposer.org/doc/05-repositories.md#path>`__
or `any other supported way <https://getcomposer.org/doc/05-repositories.md#git-alternatives>`__.

Edit the composer.json file in the *project root directory* and require the new meta package instead of default one.
