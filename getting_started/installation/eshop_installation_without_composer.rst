Install OXID eShop compilation on servers, where Composer is not available
==========================================================================

We strongly recommend to :doc:`install OXID eShop via Composer<./eshop_installation>` on the application server!
But if  Composer is not available e.g. on a "shared hosting account" or in a high-security environment, it is still
possible to install or deploy an OXID eShop.
This solution requires more effort and also some knowledge about Composer, as you will run the Composer commands on one
machine and then copy the files over to the application server.

The process is roughly:

.. contents ::
    :local:
    :depth: 1


Setup a local environment
-------------------------

As a first step setup a local environment.
For the sake of simplicity we call this environment `local`, but it can also be a remote machine, a docker container, a
virtual machine or any other installation where you have sufficient access rights to install and run executables.

This local environment should be as similar as possible to the server, where OXID eShop should finally
be installed or deployed.
Especially the PHP stack and the required system libraries should be identical to the stack of the application server.
Keep in mind that even differences in patch versions may matter.
So it is really important to keep the local environment and the application server in sync in order be able to copy files
from one system to another. Failing to do so may lead to hard to detect errors during the runtime of OXID eShop.

Make sure to have a working installation of Composer on this local environment.
You will find details how to install and use Composer `here <https://getcomposer.org/doc/00-intro.md>`__.
Please make also sure to have a sufficient understanding of how Composer works before proceeding.


Deploy the source code and install project dependencies in the local environment
--------------------------------------------------------------------------------

On your local environment follow the installation instructions, section :ref:`eshop_installation_deploy_source_code`.
After this step has been completed without errors, you will find a new directory in your current directory.
This new directory is called *your_project_name* in the example, but you may have chosen a different name.
This directory will be referred to as *project root directory*.

Prepare the generated files for deployment on the remote server (UNIX-based only)
---------------------------------------------------------------------------------

Users of Windows servers can skip this step, as Composer does not create symbolic links on Windows based systems.

On UNIX based systems, Composers creates symbolic links in the directory *project root directory*/vendor/bin/, which
cannot be just copied to a remote system like plain files.

There are at least 2 possible solutions to overcome this issue:

1.
In case you have *shell access* to the remote server, you should consider archiving the files using the `tar`-command:

    .. code:: bash

        # create tar archive in the local environment
        tar -cvzf oxid-eshop.tar.gz <project root directory>

Like this, also the symbolic links are extracted on the application server. Use this command to extract the tar archive
on the application server

    .. code:: bash

        # extract tar archive on the application server
        tar -xvzf oxid-eshop.tar.gz


2.
In case you have *no shell access* to the remote server, you have to delete the symbolic links and to manually create
alternative files, which have to be copied to the application server.

    .. code:: bash

        cd <project root directory>
        rm vendor/bin/*

        cat << 'EOF' >> vendor/bin/oe-eshop-db_views_generate
        #!/usr/bin/env sh

        dir=$(d=${0%[/\\]*}; cd "$d" > /dev/null; cd "../oxid-esales/oxideshop-db-views-generator" && pwd)

        dir=$(echo $dir | sed 's/ /\ /g')
        "${dir}/oe-eshop-db_views_generate" "$@"
        EOF

        cat << 'EOF' >> vendor/bin/oe-eshop-demodata_install
        #!/usr/bin/env sh

        dir=$(d=${0%[/\\]*}; cd "$d" > /dev/null; cd "../oxid-esales/oxideshop-demodata-installer/bin" && pwd)

        dir=$(echo $dir | sed 's/ /\ /g')
        "${dir}/oe-eshop-demodata_install" "$@"
        EOF

        cat << 'EOF' >> vendor/bin/oe-eshop-doctrine_migration
        #!/usr/bin/env sh

        dir=$(d=${0%[/\\]*}; cd "$d" > /dev/null; cd "../oxid-esales/oxideshop-doctrine-migration-wrapper/bin" && pwd)

        dir=$(echo $dir | sed 's/ /\ /g')
        "${dir}/oe-eshop-doctrine_migration" "$@"
        EOF

Copy the files to the application server and continue installation
------------------------------------------------------------------

Copy the *project root directory* to your application server and set all files in the vendor/bin directory to be executable.
Then finish the installation on the application server starting with Step 2 of the :doc:`standard installation instructions <./eshop_installation>`.

Managing modules and module dependencies
----------------------------------------

Some OXID eShop modules are installable via Composer or may require some 3rd party components (e.g. monolog/monolog) to
be installed via Composer.

To install these modules or their dependencies, follow the same strategy: Install them in a local environment following
the installation instructions of the module and then copy the newly installed files to the application server.

All files, which are managed by Composer live inside a subdirectory of *project root directory* called *vendor*.
The contents of this directory and all its subdirectories may completely change with every execution of :command:`composer require`
or :command:`composer update`, so it is a good practice to always completely replace this directory on the server.

Continue the installation procedure (copy modules files, configure module, etc.) on the application server.
