Software quality
================

.. todo: #HR: USe Twig instead of Smarty -- ist das schon umgesetzt im Folgenden?

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

To receive their represented values, use the methods provided by the shop framework, e.g.:

.. code:: php

            Registry::getRequest()->getRequestEscapedParameter($name, $defaultValue);

No global functions
^^^^^^^^^^^^^^^^^^^

Avoid creating new global functions (e.g. in the :file:`modules/functions.php` file).

PHP code
^^^^^^^^

Object-oriented programming is highly preferred.

Make sure your code is compatible with the PHP versions described under `Server and system requirements <https://docs.oxid-esales.com/eshop/en/7.0/installation/new-installation/server-and-system-requirements.html>`__.

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

    $this->addTplParam('someVar', 'some Value');

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

Module templates
^^^^^^^^^^^^^^^^

Store all templates in the same structure as the shop templates are stored in.

For example:

*   :file:`views/` - all frontend templates
*   :file:`views/admin_twig/` - all admin templates

Using JavaScript and including .js files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Store JavaScript files in the following directories:

* :file:`assets/js/libs` – if needs to define some additional JS libraries
* :file:`assets/js/widgets` – all newly created widgets

Use the following naming convention for new widgets:

:file:`[module_id]_[widget_name].js`

.. important::

    All Javascript code must be in files in the widgets folder.

    Javascript code is not allowed directly in the template.

    In the template, you are only allowed to do the assignment for widgets and do includes for the Javascript files you need.

To include Javascript files in the frontend, use the following expression:

.. code:: php

    {{ script({ include: oViewConf.getModuleUrl('[MODULE ID]', '[path where the needed file is]'), priority: 10 }) }}

And for output:

.. code:: php

	{{ script() }}

Assignment of a DOM element for a widget:

.. code:: php

    {{ script({ add: "const myModal = new bootstrap.Modal('#isRootCatChanged');myModal.show();" }) }}

In this way, Javascript files will be included correctly in the template.

Using CSS and including .css files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Store CSS files in: :file:`assets/css/<filename>`.

For CSS files, use the following naming convention: :file:`[module_id]_[css_file_name].css`

To include a module's custom CSS file, use the following expression:

.. code:: php

    {{ style({ include: oViewConf.getModuleUrl('module id', '[path where the needed file is]') }) }}


And for output:

.. code:: php

    {{ style() }}

.. important::

    All required styles must be stored into CSS file and must not be assigned directly in the template.

Language files and templates
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Make sure that individual language files and templates are stored in the module directory.

Database access
---------------

Database access compatibility
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Database access should be replication-compatible.
