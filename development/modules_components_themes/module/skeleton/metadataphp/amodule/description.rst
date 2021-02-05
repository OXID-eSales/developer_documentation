description
===========

Description
    Used to display extension description in the extension detail information page. If the value is an array,
    the sub keys have to be a language abbreviation and the values the according translations.
    If this field value is a string, this text string will be displayed in all languages.

Type:
    String or associative array

Mandatory
    No

Example
    .. code:: php

        // single language
        'description'  => 'Module for PayPal payment.',

        // multiple languages
        'description'  => [
            'de' => 'Modul für die Zahlung mit PayPal.',
            'en' => 'Module for PayPal payment.',
        ],

.. note::
    If you want to use translations in your module for frontend or backend, you should place them in your module
    (see :ref:`module structure conventions <modules_structure_language_files>`).

