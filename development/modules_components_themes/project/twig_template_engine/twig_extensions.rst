Custom OXID extensions
======================

All extensions can be found in ``src\Extensions`` directory of the `OXID eShop twig component <https://github.com/OXID-eSales/twig-component>`__

.. contents::
   :depth: 2
   :local:

Tags
----

HasRights
^^^^^^^^^

This extension introduces ``{% hasrights %}`` tag which covers the Right and Roles functionality. Example of use::

    {% hasrights { "object": "edit", "readonly": "readonly" } %}
        Lorem ipsum
    {% endhasrights %}

All parameters are passed as associative array right after the keyword ``hasrights``.

IfContent
^^^^^^^^^

This extension introduces ``{% ifcontent %}`` tag which covers the content loading functionality. Opening tag syntax::

    {% ifcontent ident|oxid ... set ... %}

Example of use::

    {% ifcontent ident "TOBASKET" set aObject %}
        Lorem ipsum
    {% endifcontent %}

ifcontent can work with ident or oxid - depends on word after ``ifcontent`` keyword and sets variable which is named
after ``set`` keyword.

IncludeDynamic
^^^^^^^^^^^^^^

This extension introduces ``{% include_dynamic %}`` which renders or leaves dynamic parts with parameters in templates
used by content caching algorithm. Syntax is similar to Twig ``{% include %}`` tag::

    {% include_dynamic ... with { ... } %}

Example of use::

    {% include_dynamic "widget/product/compare_links.html.twig" with {type: "compare", anid: altproduct } %}

Functions
---------

FormatPriceExtension
^^^^^^^^^^^^^^^^^^^^

This extension introduces ``format_price`` function which outputs price in string format. Example of use::

    {{ format_price(VATitem, { currency: 'EUR' }) }}

First argument is price, and all other parameters are passed in associative array.

IncludeWidgetExtension
^^^^^^^^^^^^^^^^^^^^^^

This extension introduces ``include_widget`` function which sets params and renders widget. Example of use::

    {{ include_widget({ cl: "oxwCategoryTree", cnid: oView.getCategoryId(), deepLevel: 0, noscript: 1, nocookie: 1 }) }}

All parameters are passed in associative array as first argument.

InputHelpExtension
^^^^^^^^^^^^^^^^^^

This extension introduces 2 helper functions: ``get_help_id`` and ``get_help_text`` which outputs help popup icon and
help text. Examples of use:

    {% include "inputhelp.tpl" with {'sHelpId': get_help_id("foo"), 'sHelpText': get_help_text("foo")} %}

MailtoExtension
^^^^^^^^^^^^^^^

This extension introduces ``mailto`` function which covers send email functionality. Example of use::

    {{ mailto('me@example.com', { text: 'send me some mail' }) }}

Address as mandatory parameter is passed as first argument, all other parameters are passed as second argument in array.

MathExtension
^^^^^^^^^^^^^

This extension introduces few math functions that do not exist by default: cos, sin, tan, exp, log, log10, pi, sqrt::

    {{ cos(2*pi())/log(3) }}

PhpFunctionExtension
^^^^^^^^^^^^^^^^^^^^

This extension introduces few PHP functions that do not exist by default: count, empty, isset. Example of use::

    {{ (isset(myArray) and not empty(myArray)) ? count(myArray) : "Array is not set or it's empty" }}

All of these functions are deprecated and it's better to use ``length`` filter and ``is defined`` Twig test.

ScriptExtension
^^^^^^^^^^^^^^^

This extension introduces ``script`` function which collects given javascript includes/calls, but includes/calls them
at the bottom of the page.. Example of use::

    {{ script({ include: "js/pages/details.min.js", priority: 10, dynamic: __oxid_include_dynamic }) }}

All parameters are passed in associative array as first argument.

StyleExtension
^^^^^^^^^^^^^^

This extension introduces ``style`` function which collects given css files,  but includes them only at the top of
the page. Example of use::

    {{ style({ include: "css/ie8.css", if: "IE 8" }) }}

All parameters are passed in associative array as a first argument.

TranslateExtension
^^^^^^^^^^^^^^^^^^

This extension introduces ``translate`` function which is responsible for translation functionality. Example of use::

    {{ translate({ ident: "ERROR_404" }) }}

All parameters are passed in associative array as first argument.

UrlExtension
^^^^^^^^^^^^

This extension introduces ``seo_url`` function and ``add_url_parameters`` filter which outputs SEO style url.
Example of use::

    {{ seo_url({ ident: oViewConf.getSelfLink() }) }}
    {{ _lng.link|add_url_parameters(oView.getDynUrlParams()) }}

For both all parameters are passed in associative array as first argument and ``add_url_parameters`` must operate on
string.

Filters
-------

CatExtension
^^^^^^^^^^^^

This extension introduces ``cat`` filter which concatenates two strings. Example of use::

    {{ varA|cat(varB) }}

This filter is deprecated and it's better to use Twig syntax::

    {{ varA ~ varB }}

DateFormatExtension
^^^^^^^^^^^^^^^^^^^

This extension introduces ``date_format`` filter which is responsible for formatting the date into string.
Example of use::

    {{ review.getCreatedAt()|date_format("%Y-%m- % d") }}

EncloseExtension
^^^^^^^^^^^^^^^^

This extension introduces ``enclose`` filter. Examples of use::

    {{ article.oxarticles__oxartnum.value|enclose(encl) }}

FileSizeExtension
^^^^^^^^^^^^^^^^^

This extension introduces ``file_size`` filter which converts integer file size to readable format. Example of use::

    {{ oOrderFile.getFileSize()|file_size }}

FormatTimeExtension
^^^^^^^^^^^^^^^^^^^

This extension introduces ``format_time`` filter which converts time to readable format. Example of use::

    {{ oViewConf.getBasketTimeLeft()|format_time }}

FormatDateExtension
^^^^^^^^^^^^^^^^^^^

This extension introduces ``format_date`` filter which converts date to readable format. Example of use::

    {{ edit.oxorder__oxsenddate|format_date('datetime', true) }}

FormatCurrencyExtension
^^^^^^^^^^^^^^^^^^^^^^^

This extension introduces ``format_currency`` filter which formats currency in defined form. Example of use::

    {{ 'EUR@ 1.00@ .@ ,@ EUR@ 2'|number_format(25000000.5584) }}

SmartWordwrapExtension
^^^^^^^^^^^^^^^^^^^^^^

This extension introduces ``smart_wordwrap`` filter which wraps a string of text at a given length and row count.
Example of use::

    {{ 'Lorem ipsum'|smart_wordwrap(20) }}

TranslateExtension (Filter)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This extension introduces ``translate`` filter which is responsible for translation functionality. Example of use::

    {{ 'QUESTIONS_ABOUT_THIS_PRODUCT'|translate }}

TranslateSalutationExtension
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This extension introduces ``translate_salutation`` filter which is responsible for salutation translation functionality.
Example of use::

    {{ order.oxorder__oxbillsal.value|translate_salutation }}

TruncateExtension
^^^^^^^^^^^^^^^^^

This extension introduces ``truncate`` filter which truncates a string to a certain length if necessary, optionally
splitting in the middle of a word, and appending the 'etc' string or inserting 'etc' into the middle. Example of use::

    {{ review.getObjectTitle()|truncate(60) }}

WordwrapExtension
^^^^^^^^^^^^^^^^^

This extension introduces ``wordwrap`` filter which wraps a string of text at a given length. Example of use::

    {{ sQuery|wordwrap(100, "<br>", true) }}

Escape
^^^^^^

Escape is internal Twig filter but it can be extended and so is done in OXID. Custom escapers that have been introduced:
``decentity``, ``hexentity``, ``hex``, ``htmlall``, ``mail``, ``nonstd``, ``quotes``, ``urlpathinfo``. All escapers can
be found under source\Internal\Twig\Escaper directory. Example of use::

    {{ 'example@me.com'|escape('mail') }}
