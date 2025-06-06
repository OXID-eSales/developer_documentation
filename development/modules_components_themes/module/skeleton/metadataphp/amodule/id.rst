id
==

Description
    The extension id must be unique.

    It is recommended to use the vendor prefix + the module root directory name.

    For more information, see :ref:`development/modules_components_themes/module/certification/inter_module_compatibility:Vendor Prefixes`.

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
