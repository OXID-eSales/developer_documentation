title
"""""

Description:
    Used to display extension title in the extensions list and detail information. If the value is an array,
    the sub keys have to be a language abbreviation and the values the according translations.
    If this field value is a string, this text string will be displayed in all languages.

Type:
    string or array of strings

Mandatory:
    no

Example
    .. code:: php

        // single language
        'title'        => 'PayPal',

        // multiple languages
        'title'       => [
            'de' => 'PayPal Zahlungen',
            'en' => 'PayPal Payments',
        ],


.. note::
    If you want to use translations in your module for frontend or backend, you should place them in your module according
    the :ref:`module structure conventions <modules_structure_language_files_20170316>`