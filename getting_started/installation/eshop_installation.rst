Install OXID eShop compilation
==============================

Please, install the OXID eShop compilation performing the following steps:

* `Step 1: Deploy source code and install project dependencies`_
* `Step 2: Configure the HTTP server`_
* `Step 3: Adapt file and directory permissions`_
* `Step 4: Run the graphical setup`_

.. _eshop_installation_deploy_source_code:

Step 1: Deploy source code and install project dependencies
--------------------------------------------------------------

    The recommended way to obtain the source code of OXID eShop and to install the project dependencies is to use Composer.
    You will find details how to install and use Composer `here <https://getcomposer.org/doc/00-intro.md>`__. Please make sure
    to have a sufficient understanding of how Composer works before proceeding.

    If by any reason you are not able to use Composer to install OXID eShop or one of its modules on a specific application
    server, please skip this step and read :doc:`these instructions<eshop_installation_without_composer>` to learn how to
    deploy the source code using an alternative way.

    Depending on the edition of OXID eShop you want to install, run one the following commands in the command line interface
    of your operating system.

    If you install OXID eShop for module development, remember we recommend using oxVM for development, but if by any reason
    you need the OXID eSales development tools to be installed, remove  the `--no-dev` option in the commands below.

    .. note::
        For OXID eShop Professional Edition or OXID eShop Enterprise Edition, you need to enter the credentials you should
        have received when purchasing the product.

    * For Community Edition:

    .. code:: bash

        composer create-project --no-dev oxid-esales/oxideshop-project your_project_name dev-b-6.1-ce

    * For Professional Edition:

    .. code:: bash

        composer create-project --no-dev oxid-esales/oxideshop-project your_project_name dev-b-6.1-pe

    * For Enterprise Edition:

    .. code:: bash

        composer create-project --no-dev oxid-esales/oxideshop-project your_project_name dev-b-6.1-ee

    When the Composer has finished successfully, a new directory will have been created in your working directory.
    It is called *your_project_name* in this example and it is referred to as *project root directory*.

    The *project root directory* contains all files, which are needed to continue with the installation of OXID eShop.

    **Watch out for error messages during the installation progress.**

    See our :doc:`troubleshooting <./troubleshooting>` section for solutions.

.. note::

        If you install the compilation **without** the `--no-dev` option, the following development tools will be installed together with OXID eShop:

        * OXID eShop `Testing Library <https://github.com/OXID-eSales/testing_library>`__
        * `IDE code completion support <https://github.com/OXID-eSales/oxid-eshop-ide-helper>`__ for OXID eShop
        * OXID `Coding Standards <https://github.com/OXID-eSales/coding_standards>`__
        * `Azure Theme <https://github.com/OXID-eSales/azure_theme>`__ for selenium tests

Technical details
^^^^^^^^^^^^^^^^^

    Composer will automatically download the source files of the specified version and edition of OXID eShop.

    In a second step it will install fixed versions of the project dependencies as defined in the meta package of the installed
    edition of OXID eShop.

    After Composer installed all dependencies, it executes several tasks. One of them is to generate the classes of the
    :doc:`unified namespace <../../system_architecture/namespaces>` `\\OxidEsales\\Eshop`.


Step 2: Configure the HTTP server
------------------------------------

    Move the *project root directory* to a directory accessible by your HTTP server.
    Configure the servers public document root to point to the `source` directory of the *project root directory*

Step 3: Adapt file and directory permissions
----------------------------------------------------

   The following directories and its subdirectories must always be writable by the HTTP server during the run time:

      * ./var/
      * ./source/export/
      * ./source/log/
      * ./source/out/pictures/
      * ./source/out/media/
      * ./source/tmp/

   For the next step, the graphical setup, the following files and directories must be writable for the HTTP server:

      * ./source/Setup
      * ./source/config.inc.php
      * ./source/.htaccess

   .. note::

        In a development environment, the easiest way to adapt permissions, is to run

        .. code:: bash

            sudo chmod 777 -R var source/config.inc.php source/.htaccess source/tmp/ source/log/ source/out/pictures/ source/out/media/ source/export

Step 4: Run the graphical setup
----------------------------------------------

   Open **http(s)://<your shop URL>/Setup** in your browser and follow the instructions of the graphical setup.

   At the end of the installation process, the directory ./source/Setup is deleted.

   After the graphical setup, please set the following files to read-only for the HTTP server:

      * ./source/config.inc.php
      * ./source/.htaccess

   .. note::

        As the file ./source/config.inc.php contains database credentials, you should consider to restrict read access to
        the HTTP server.

Activate pre-installed modules
------------------------------

    None of the bundled modules is activated by default during the setup.
    Please refer to the documentation you find inside the module directory about system requirements and configuration of
    each module.

Install more modules and module dependencies
--------------------------------------------

    After the installation, you may proceed with the installation of some of the many modules the OXID eco system provides.
    Refer to the installation instructions of each of the modules.

    Keep in mind that some OXID eShop modules may have special requirements, which may go beyond the
    `system requirements of a standard installation of OXID eShop. <https://docs.oxid-esales.com/eshop/de/6.1/installation/neu-installation/server-und-systemvoraussetzungen.html>`__
    These requirements may either be installable via Composer or may require the installation of certain PHP extensions or even system
    libraries.
    In any case, the authors of the modules will have provided you with all necessary information about these requirements and
    how to install them on your application server.

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

Hints for development
---------------------

Always use Composers' --no-plugins switch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
