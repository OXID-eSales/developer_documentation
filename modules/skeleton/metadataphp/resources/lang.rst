lang
""""

Description:
    Default extension language. Displaying extension title or description there will be checked if these fields have a
    selected language. If not, the selected language defined in the lang field will be selected. E.g. if admin is opened
    in German and extension is available in English, the English title and description value will be shown as there is
    translation into German.

Type:
    string

Mandatory:
    no

Example
    .. code:: php

        'lang' => 'en'