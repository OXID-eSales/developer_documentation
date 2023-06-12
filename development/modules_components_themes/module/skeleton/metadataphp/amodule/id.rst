id
==

.. todo #VL: wie todo oben: VL prüft; https://oxidforge.org/de/modulkurzel outdated? Wo liegt die Datei jetzt? "This file is outdated for we moved on to another system to display your acronyms, namespaces"

Description
    The extension id must be unique.

    It is recommended to use `vendor prefix <https://oxidforge.org/de/modulkurzel>`_ + the module root directory name.

    The module ID is used for getting all needed information about extension.

    The directory of the module must be equal to the module_id.

Type
    String

Mandatory
    Yes

Example
    .. code:: php

        'id'           => 'oe_moduletemplate',


.. note::

  The extension id mustn't be > 93 characters. Please also see https://bugs.oxid-esales.com/view.php?id=5549.
