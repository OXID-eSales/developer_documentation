Usage
=====

The convert command tries to fix as much coding standards problems as possible on a given file, directory or database.

path and ext parameters
-----------------------

Converter can work with files and directories:

``php toTwig convert --path=/path/to/file``
  
``php toTwig convert --path=/path/to/dir``  


By default files with ``.html.twig`` extension will be created. To specify different extensions use ``--ext`` parameter:

``php toTwig convert --path=/path/to/dir --ext=.js.twig``

database and database-columns parameters
----------------------------------------

It also can work with databases:

``php toTwig convert --database="mysql://user:password@localhost/db"``

The ``--database`` parameter gets
`database doctrine-like URL <https://www.doctrine-project.org/projects/doctrine-dbal/en/2.9/reference/configuration.html#connecting-using-a-url>`__.
Converter by default converts following tables columns: ``oxactions.OXLONGDESC``, ``oxactions.OXLONGDESC_1``,
``oxcontents.OXCONTENT``, ``oxcontents.OXCONTENT_1``.

The ``--database-columns`` option lets you choose tables columns to be converted (the table column names has to be
specified in table_a.column_b format and separated by comma):

``php toTwig convert --database="..." --database-columns=oxactions.OXLONGDESC,oxcontents.OXCONTENT``

You can also blacklist the table columns you don't want using -table_a.column_b:

``php toTwig convert --database="..." --database-columns=-oxactions.OXLONGDESC_1,-oxcontents.OXCONTENT_1``

converters parameter
--------------------

The ``--converters`` option lets you choose the exact converters to apply (the converter names must be separated by a
comma):

``php toTwig convert --path=/path/to/dir --ext=.html.twig --converters=for,if,misc``

You can also blacklist the converters you don't want if this is more convenient, using -name:

``php toTwig convert --path=/path/to/dir --ext=.html.twig --converters=-for,-if``

dry-run, verbose and diff parameters
------------------------------------

A combination of ``--dry-run``, ``--verbose`` and ``--diff`` will display summary of proposed changes, leaving your
files unchanged.

All converters apply by default.

The ``--dry-run`` option displays the files that need to be fixed but without actually modifying them:

``php toTwig convert --path=/path/to/code --ext=.html.twig --dry-run``

config-path parameter
---------------------

Instead of building long line commands it is possible to inject PHP configuration code. Two example files are included
in main directory: ``config_file.php`` and ``config_database.php``. To include config file use --config-path parameter:

``php toTwig convert --config-path=config_file.php``

Config script should return instance of ``toTwig\Config\ConfigInterface``. It can be created using
``toTwig\Config\Config::create()`` static method.
