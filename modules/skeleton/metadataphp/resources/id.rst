id
""

Description:
    The extension id must be unique. It is recommended to use `vendor prefix <https://oxidforge.org/de/modulkurzel>`__
    + module root directory name. Module ID is used for getting all needed information about extension. The directory of
    the module has to equal the module_id. If this module
    has defined config variables in ``oxconfig`` and ``oxconfigdisplay`` tables (e.g. ``module:oepaypal``),
    the extension id used in these tables should the match extension id defined in metadata file.
    Also same id (``oepaypal``) must be used when defining extension templates blocks in ``oxtplblocks`` table.


Type:
    string

Mandatory:
    yes

Example:
    .. code:: php

        'id'           => 'oepaypal',


.. note::

  The extension id mustn't be > 93 characters. Please also see https://bugs.oxid-esales.com/view.php?id=5549.
