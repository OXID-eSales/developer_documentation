title
=====

Description
    Used to display extension title in the extensions list and detail information. If the value is an array,
    the sub keys have to be a language abbreviation and the values the according translations.
    If this field value is a string, this text string will be displayed in all languages.

Type
    String or associative array

Mandatory
    No

Example
    .. code:: php

        // single language
        'title'        => 'OxidEsales Module Template (OEMT)',

        // multiple languages
        'title'       => [
            'de' => 'OxidEsales Module Template (OEMT)',
            'en' => 'OxidEsales Module Template (OEMT)',
        ],


.. note::
    If you want to use translations in your module for frontend or backend, you should place them in your module
    (see :ref:`module structure conventions <modules_structure_language_files>`).