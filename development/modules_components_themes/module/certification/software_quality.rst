Software quality
================

Basics
------

No globals
^^^^^^^^^^

Do not use global variables like

.. code:: php

    $_POST
    $_GET
    $_SERVER
    // etc.

In order to receive their represented values, use the methods provided by the shop framework, e.g.:

.. code:: php

            Registry::getRequest()->getRequestEscapedParameter($name, $defaultValue);

No global functions
^^^^^^^^^^^^^^^^^^^

Avoid creating new global functions (e.g. in the :file:`modules/functions.php` file).

No business logic in smarty functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Use smarty only for design purposes. Business logic belongs to the PHP level.

PHP code
^^^^^^^^

Object-oriented programming is highly preferred.
Your code should be compatible with the PHP versions described in the `system requirements <https://docs.oxid-esales.com/eshop/en/7.0-rc.1/installation/new-installation/server-and-system-requirements.html>`__.

OXID standards
--------------

Module Structure
^^^^^^^^^^^^^^^^

The module's directory structure should be as described in :ref:`modules/structure <modules_structure-20170217>`.

Module constituents
^^^^^^^^^^^^^^^^^^^

All modifications introduced by a module must be part of the module directory. This applies for theme extensions, such as
blocks, new templates, as well as language files and resources. A module must not come with manual modification instructions
for templates or language files of the core product or 3rd party modules.

Class design
------------

Base extensions
^^^^^^^^^^^^^^^

Your classes should, in general, be -- directly or indirectly -- derived from the ``Base`` (``\OxidEsales\Eshop\Core\Base``)
class of the eShop framework. There are some exception where ``Base`` does not have to be used:

* in classes where lazy loading is not needed (not directly working with database)
* new classes intended for working with the file system

But you *must* inherit from ``Base``,

* when lazy loading is needed (for example like original shop file ``Article``)
* whenever you want to be able to access the shop's configuration

.. _modules_certification_getters_setters:

Getters and setters
^^^^^^^^^^^^^^^^^^^

Accessing public variables of the class should be implemented using getter and setter methods.

Do not use $this->_aViewData
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the shop's frontend templates, and unless you are not working with admin templates, do not use

.. code:: php

    $this->_aViewData['someVar'] = 'some Value';

Instead, use

.. code:: php

    $this->setViewData('someVar', 'some Value');

In general, keep in mind that :ref:`setters and getters <modules_certification_getters_setters>` should be used whenever
values are assigned to protected variables.

Exception handling
^^^^^^^^^^^^^^^^^^

Create your own classes for exception handling and therefore use ``StandardException``:

.. code:: php

    use \OxidEsales\Eshop\Core\Exception\StandardException

Maximum length of methods < 80 lines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The number of lines of a method should not be higher than 80. The best practice is to stick with values below 40.
Modules with more than 120 lines of code in a method cannot be certified.

Complexity
----------

Maximum NPath complexity < 200
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The NPath complexity is the number of possible execution paths through a method. Each control
structure, e.g.

.. code:: php

    if
    elseif
    for
    while
    case

is taken into account also the nested and multipart boolean expressions. The NPath complexity should be lower than 200.
Modules with values above 500 cannot be certified.

Maximum Cyclomatic Complexity = 4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Cyclomatic Complexity is measured by the number of statements of

.. code:: php

    if
    while
    do
    for
    ?:
    catch
    switch
    case

as well as operators like

.. code:: php

    &&
    ||
    and
    or
    xor

in the body of a constructor, method, static initializer, or instance initializer. It is a measure of the minimum number
of possible paths through the source and therefore the number of required tests. In general, 1-4 is considered
good, 5-7 ok, 8-10 means "consider re-factoring", and 11 and higher tells you "re-factor now!". A hard limit for the
module certification process is a Cyclomatic Complexity of 8.

Maximum C.R.A.P. index < 30
^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Change Risk Analysis and Predictions (C.R.A.P.) index of a function or method uses Cyclomatic Complexity and
Code Coverage from automated tests to help estimate the effort and risk associated with maintaining legacy code.
Modules with a CRAP index above 30 will not be accepted in the certification process.

Extending views and frontend
----------------------------

Blocks
^^^^^^

Use block definitions in the templates. This is not an obligation. The naming convention for new blocks is:
``[vendor]_[module]_[blockname]``. In the templates, use blocks like that:

.. code:: php

    [{block name="thevendor_themodule_theblock"}][{/block}]

All blocks information should be stored into :file:`views/blocks` directory:

For example, if a block is intended for a certain file of a theme, like :file:`Application/views/[theme name]/tpl/page/details/details.tpl`,
inside the module directory, the block file should be located in :file:`views/blocks/originalTemplateName_blockname.tpl`.

When adding contents for blocks in the admin interface, blocks should be located in paths like
:file:`views/blocks/admin/originalTemplateName_blockname.tpl`.

Blocks should be used whenever the shop's functionality is extended to the frontend side and a requested function or method
would not be available as long as the module is disabled. Using blocks allows you to move function calls into small snippet
files for the frontend that are only included when the modules is set active. Therefore, using blocks can be considered
a quality feature of a module.

Module templates
^^^^^^^^^^^^^^^^

All new templates must be registered in :file:`metadata.php` and should use naming convention:

:file:`[vendor]_[module]_[templateName]`

All templates should be stored in the same structure like shop templates are.

For example:
	:file:`views/` - all frontend templates
	:file:`views/admin/` - all admin templates

Using JavaScript and including .js files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

JavaScript files should be stored into:

* :file:`assets/js/libs` – if needs to define some additional JS libraries
* :file:`assets/js/widgets` – all newly created widgets

Naming convention for new widgets:
:file:`[vendor]_[module]_[widgetName].js`

.. important::

    All Javascript code must be in files in the widgets folder. Javascript code is not allowed directly in the template.
    In the template you are only allowed to do the assignment for widgets and do includes for the Javascript files you need.

In order to include Javascript files in frontend, use:

.. code:: php

    [{oxscript include=$oViewConf->getModuleUrl("[MODULE ID]", "js/[path where the needed file is] ") priority=10}]

And for output:

.. code:: php

	[{oxscript}]

Assignment of a DOM element for a widget:

.. code:: php

    [{oxscript add="$('dom element').neededWidget();" priority=10}]

In this way Javascript files will be included correctly within the template.

Using CSS and including .css files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

CSS files should be stored in: :file:`assets/css/<filename>`

CSS file naming convention is: :file:`[vendor]_[module]_[css file name].css`

To include new CSS file from module needs to use:

.. code:: php

    [{oxstyle include=$oViewConf->getModuleUrl("module id", "css/{FileName}.css")}]

And for output:

.. code:: php

    [{oxstyle}]

.. important::

    All needed styles must be stored into CSS file and must not be assigned directly in template.

Language files and templates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Individual language files and templates must be inside the module directory.

Database access
---------------

Database access compatibility
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Database access should be master-slave compatible.
For details, see :ref:`Database: Master/Slave <modules-database-master_slave>`.

