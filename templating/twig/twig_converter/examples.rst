Converted plugins and syntax pieces
===================================

Here is list of plugins and syntax pieces with basic examples how it is converted. Note that these examples are only to
show how it is converted and doesn't cover all possible cases as additional parameters, block nesting, repetitive calls
(as for counter and cycle functions) etc.

.. contents::
   :depth: 1
   :local:

Core Smarty
-----------

assign => set
^^^^^^^^^^^^^

Converter name: ``assign``

| Smarty:
| ``[{assign var="name" value="Bob"}]``
|
| Twig:
| ``{% set name = "Bob" %}``
|

block => block
^^^^^^^^^^^^^^

Converter name: ``block``

| Smarty:
| ``[{block name="title"}]Default Title[{/block}]``
|
| Twig:
| ``{% block title %}Default Title{% endblock %}``
|

capture => set
^^^^^^^^^^^^^^

Converter name: ``CaptureConverter``

| Smarty:
| ``[{capture name="foo" append="var"}] bar [{/capture}]``
|
| Twig:
| ``{% set foo %}{{ var }} bar {% endset %}``
|

Comments
^^^^^^^^

Converter name: ``comment``

| Smarty:
| ``[{* foo *}]``
|
| Twig:
| ``{# foo #}``
|


counter => set
^^^^^^^^^^^^^^

Converter name: ``counter``

| Smarty:
| ``[{counter}]``
|
| Twig:
| ``{% set defaultCounter = ( defaultCounter | default(0) ) + 1 %}``
|

cycle => smarty_cycle
^^^^^^^^^^^^^^^^^^^^^

Converter name: ``cycle``

| Smarty:
| ``[{cycle values="val1,val2,val3"}]``
|
| Twig:
| ``{{ smarty_cycle(["val1", "val2", "val3"]) }}``
|

foreach => for
^^^^^^^^^^^^^^

Converter name: ``for``

| Smarty:
| ``[{foreach $myColors as $color}]foo[{/foreach}]``
|
| Twig:
| ``{% for color in myColors %}foo{% endfor %}``
|

if => if
^^^^^^^^

Converter name: ``if``

| Smarty:
| ``[{if !$foo or $foo->bar or $foo|bar:foo["hello"]}]foo[{/if}]``
|
| Twig:
| ``{% if not foo or foo.bar or foo|bar(foo["hello"]) %}foo{% endif %}``
|

include => include
^^^^^^^^^^^^^^^^^^

Converter name: ``include``

| Smarty:
| ``[{include file='page_header.tpl'}]``
|
| Twig:
| ``{% include 'page_header.tpl' %}``
|

insert => include
^^^^^^^^^^^^^^^^^

Converter name: ``insert``

| Smarty:
| ``[{insert name="oxid_tracker" title="PRODUCT_DETAILS"|oxmultilangassign product=$oDetailsProduct cpath=$oView->getCatTreePath()}]``
|
| Twig:
| ``{% include "oxid_tracker" with {title: "PRODUCT_DETAILS"|oxmultilangassign, product: oDetailsProduct, cpath: oView.getCatTreePath()} %}``
|

mailto => mailto
^^^^^^^^^^^^^^^^

Converter name: ``mailto``

| Smarty:
| ``[{mailto address='me@example.com'}]``
|
| Twig:
| ``{{ mailto('me@example.com') }}``
|

math => core Twig math syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``math``

| Smarty:
| ``[{math equation="x + y" x=1 y=2}]``
|
| Twig:
| ``{{ 1 + 2 }}``
|


Variable conversion
^^^^^^^^^^^^^^^^^^^

Converter name: ``variable``

+-----------------------------------------------------------+----------------------------------------------------------+
| Smarty                                                    | Twig                                                     |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$var}]``                                              | ``{{ var }}``                                            |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$contacts.fax}]``                                     | ``{{ contacts.fax }}``                                   |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$contacts[0]}]``                                      | ``{{ contacts[0] }}``                                    |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$contacts[2][0]}]``                                   | ``{{ contacts[2][0] }}``                                 |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$person->name}]``                                     | ``{{ person.name }}``                                    |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$oViewConf->getImageUrl($sLangImg)}]``                | ``{{ oViewConf.getImageUrl(sLangImg) }}``                |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{$_cur->link|oxaddparams:$oView->getDynUrlParams()}]`` | ``{{ _cur.link|oxaddparams(oView.getDynUrlParams()) }}`` |
+-----------------------------------------------------------+----------------------------------------------------------+
| ``[{($a && $b) || $c}]``                                  | ``{{ (a and b) or c }}``                                 |
+-----------------------------------------------------------+----------------------------------------------------------+

Other
^^^^^

Converter name: ``misc``

+--------------------------------+------------------------------------------+
| Smarty                         | Twig                                     |
+--------------------------------+------------------------------------------+
| ``[{ldelim}]foo[{ldelim}]``    | ``foo``                                  |
+--------------------------------+------------------------------------------+
| ``[{literal}]foo[{/literal}]`` | ``{# literal #}foo{# /literal #}``       |
+--------------------------------+------------------------------------------+
| ``[{strip}]foo[{/strip}]``     | ``{% spaceless %}foo{% endspaceless %}`` |
+--------------------------------+------------------------------------------+


OXID custom extensions
----------------------

assign_adv => set assign_advanced
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``assign_adv``

| Smarty:
| ``[{ assign_adv var="name" value="Bob" }]``
|
| Twig:
| ``{% set name = assign_advanced("Bob") %}``
|

oxcontent => include content
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxcontent``

| Smarty:
| ``[{oxcontent ident='oxregisteremail'}]``
|
| Twig:
| ``{% include 'content::ident::oxregisteremail' %}``
|

oxeval => include(template_from_string())
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``OxevalConverter``

| Smarty:
| ``[{oxeval var=$variable}]``
|
| Twig:
| ``{{ include(template_from_string(variable)) }}``
|

oxgetseourl => seo_url
^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxgetseourl``

| Smarty:
| ``[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]``
|
| Twig:
| ``{{ seo_url({ ident: oViewConf.getSelfLink()|cat("cl=basket") }) }}``
|

oxhasrights => hasrights
^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxhasrights``

| Smarty:
| ``[{oxhasrights object=$edit readonly=$readonly}]foo[{/oxhasrights}]``
|
| Twig:
| ``{% hasrights { "object": "edit", "readonly": "readonly", } %}foo{% endhasrights %}``
|

oxid_include_dynamic => include_dynamic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxid_include_dynamic``

| Smarty:
| ``[{oxid_include_dynamic file="form/formparams.tpl"}]``
|
| Twig:
| ``{% include_dynamic "form/formparams.tpl" %}``
|

oxid_include_widget => include_widget
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxid_include_widget``

| Smarty:
| ``[{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() deepLevel=0 noscript=1 nocookie=1}]``
|
| Twig:
| ``{{ include_widget({ cl: "oxwCategoryTree", cnid: oView.getCategoryId(), deepLevel: 0, noscript: 1, nocookie: 1 }) }}``
|

oxifcontent => ifcontent
^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxifcontent``

| Smarty:
| ``[{oxifcontent ident="TOBASKET" object="aObject"}]foo[{/oxifcontent}]``
|
| Twig:
| ``{% ifcontent ident "TOBASKET" set aObject %}foo{% endifcontent %}``
|

oxinputhelp => include "inputhelp.tpl"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxinputhelp``

| Smarty:
| ``[{oxinputhelp ident="foo"}]``
|
| Twig:
| ``{% include "inputhelp.tpl" with {'sHelpId': getSHelpId(foo), 'sHelpText': getSHelpText(foo)} %}``
|

oxmailto => oxmailto
^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxmailto``

| Smarty:
| ``[{oxmailto address='me@example.com'}]``
|
| Twig:
| ``{{ mailto('me@example.com') }}``
|

oxmultilang => translate
^^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxmultilang``

| Smarty:
| ``[{oxmultilang ident="ERROR_404"}]``
|
| Twig:
| ``{{ translate({ ident: "ERROR_404" }) }}``
|

oxprice => format_price
^^^^^^^^^^^^^^^^^^^^^^^

Converter name: ``oxprice``

| Smarty:
| ``[{oxprice price=$basketitem->getUnitPrice() currency=$currency}]``
|
| Twig:
| ``{{ format_price(basketitem.getUnitPrice(), { currency: currency }) }}``
|

oxscript => script
^^^^^^^^^^^^^^^^^^

Converter name: ``oxscript``

| Smarty:
| ``[{oxscript include="js/pages/details.min.js" priority=10}]``
|
| Twig:
| ``{{ script({ include: "js/pages/details.min.js", priority: 10, dynamic: __oxid_include_dynamic }) }}``
|

oxstyle => style
^^^^^^^^^^^^^^^^

Converter name: ``oxstyle``

| Smarty:
| ``[{oxstyle include="css/libs/chosen/chosen.min.css"}]``
|
| Twig:
| ``{{ style({ include: "css/libs/chosen/chosen.min.css" }) }}``
|

section => for
^^^^^^^^^^^^^^

Converter name: ``section``

| Smarty:
| ``[{section name=picRow start=1 loop=10}]foo[{/section}]``
|
| Twig:
| ``{% for picRow in 1..10 %}foo{% endfor %}``
|

Filters
^^^^^^^

+-----------------------+--------------------------+
| Smarty                | Twig                     |
+-----------------------+--------------------------+
| ``smartwordwrap``     | ``smart_wordwrap``       |
+-----------------------+--------------------------+
| ``date_format``       | ``date_format``          |
+-----------------------+--------------------------+
| ``oxaddparams``       | ``add_url_parameters``   |
+-----------------------+--------------------------+
| ``oxaddslashes``      | ``add_slashes``          |
+-----------------------+--------------------------+
| ``oxenclose``         | ``enclose``              |
+-----------------------+--------------------------+
| ``oxfilesize``        | ``file_size``            |
+-----------------------+--------------------------+
| ``oxformattime``      | ``format_time``          |
+-----------------------+--------------------------+
| ``oxformdate``        | ``format_date``          |
+-----------------------+--------------------------+
| ``oxmultilangassign`` | ``translate``            |
+-----------------------+--------------------------+
| ``oxmultilangsal``    | ``translate_salutation`` |
+-----------------------+--------------------------+
| ``oxnubmerformat``    | ``format_currency``      |
+-----------------------+--------------------------+
| ``oxtruncate``        | ``truncate``             |
+-----------------------+--------------------------+
| ``oxwordwrap``        | ``wordwrap``             |
+-----------------------+--------------------------+
