Known issues
============

- In Twig by default all variables are escaped. Some of variables should be filtered with ``|raw`` filter to avoid this.

- Variable scope. In Twig variables declared in templates have scopes limited by block (``{% block %}``, ``{% for %}``
  and so on). Some variables should be declared outside these blocks if they are used outside.

- Re-declaring blocks - it’s forbidden in Twig.

- Access to array item ``$myArray.$itemIndex`` should be manually translated to ``myArray[itemIndex]``

- Problem with checking non existing (null) properties. E.g. we want to check the value of non-existing property
  ``oxarticles__oxunitname``. Twig checks with ``isset`` if this property exists and it’s not, so Twig assumes that
  property name is function name and tries to call it.

- Uses of regex string in templates - the tool can break or work incorrectly on so complex cases - it’s safer to
  manually copy&paste regular expression.

- ``[{section}]`` - ``loop`` is array or integer - different behaviors. The tool is not able to detect variable type.
