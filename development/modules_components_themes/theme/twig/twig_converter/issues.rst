Known issues
============

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

- Use the Twig's `nl2br <https://twig.symfony.com/doc/3.x/filters/nl2br.html>`__ filter if you want to output new lines added by users inside Product reviews
  (for Smarty similar insertion of the ``<br>`` HTML elements was performed at Model level).
