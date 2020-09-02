Documentation
=============

Documentation resources
-----------------------

README.md
^^^^^^^^^

Your module directory should contain a :file:`README.md` file. We recommend using the markdown format.
The file should provide basic information about the extension, e.g.:

* Title – the name of the module
* Author – the author/company of the module
* Prefix – the prefix you use
* Version – version of the module which is described
* Link – a link to the homepage of the author/company
* Mail – email for contact
* Description – a short description of the function of the module
* Installation – a detailed description how to install the module
* Modules – which other modules are used
* Resources – other resources

Here is a (shortened) example:

.. code:: html

    The ... extension for OXID eShop 6
    ==================================

    ![Alt text for an image](an-image.jpg)

    ### List of features

    * List item A
    * List item B
    * List item C

    ### Setup

    For installation instructions please see...

    ### Module installation via Composer

    Install this module...

CHANGELOG.md
^^^^^^^^^^^^

The file :file:`CHANGELOG.md` should contain a description of the changes that were added for each release.
The latest releases should be on top of that file.

A simple example:

.. code:: html

    ### 1.0.1

    * Fixed a bug that prevented...

    ### 1.0.0

    * Completed all features, tested and stable.

PHPDoc
^^^^^^

You can provide a HTML document that contains the PHPDoc from the code's comments. See also :ref:`PHP comments <phpcomments-20171213>`.

Documentation directory
^^^^^^^^^^^^^^^^^^^^^^^

You can provide additional documentation materials inside a ``documentation`` directory (within the directory structure of
the module), e.g. in PDF files.

.. _phpcomments-20171213:

PHP Comments
------------

Add comments to your code. Each class, variable and method should have a comment.
A comment should give additional information and not only repeat the name. See the following example:

.. code:: php

    <?php
    /**
    * Cupboard
    *
    * @package Furniture
    * @version $Revision$
    * @author
    * @copyright Copyright (C) 2003-2017 SomeCompany . All rights reserved.
    * @license http://www.gnu.org/licenses/gpl-3.0.txt GPL
    * @extend Base
    */
    class Cupboard extends Cupboard_parent
    {
    /**
    * Number of cups in the cupboard. Declared in units
    *
    * @var int
    */
    protected $numberOfCups;
    /**
    * Take a cup from cupboard
    *
    * Reduces the amount of cups by the specified amount. If
    * there are not enough cups left the cupboard is emptied. The actual amount
    * of cups removed from the cupboard will be returned.
    *
    * @extend drink
    * @param int $amount
    * @return int
    */
    public function take( $amount )
    {
        // inline comment
        $this->numberOfCups -= $amount = max( $this->numberOfCups, $amount );
        return $amount;
    }

Get rid of old standards
------------------------

No :file:`copy_this` directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

As the modules must be installable via Composer, an additional directory structure would make it complicated to install
them. Your module package should have the vendor directory on top.

No :file:`changed_full` directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This directory is no longer needed.

No install.sql
^^^^^^^^^^^^^^

Unlike in previous shop versions, the database setup should not happen with a SQL file, but rather using an installer with
an ``onActivate()`` method as well as configurations in the ``settings`` array on the :file:`metadata.php` file.
