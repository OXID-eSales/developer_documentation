Known issues
============

- Variable scope. In Twig, variables declared in templates have scopes limited by block (``{% block %}``, ``{% for %}``
  and so on). Some variables should be declared outside these blocks if they are used outside.

- Re-declaring blocks - it’s forbidden in Twig.

- Access to array item ``$myArray.$itemIndex`` should be manually translated to ``myArray[itemIndex]``.

- Problem with checking non existing (null) properties. E.g., we want to check the value of the non-existing property
  ``oxarticles__oxunitname``. With ``isset``, Twig checks if this property exists. If it doesn't exist, Twig assumes that
  the property name is a function name and tries to call it.

- Uses of regex strings in templates: The tool can break or work incorrectly in such complex cases, so it’s safer to
  manually copy & paste regular expressions.

- ``[{section}]`` - ``loop`` is array or integer - different behaviors. The tool is not able to detect the variable type.

- If you want to output new lines added by users inside product reviews, use Twig's `nl2br <https://twig.symfony.com/doc/3.x/filters/nl2br.html>`__ filter.
  |br|
  Background: For Smarty, a similar insertion of the ``<br>`` HTML elements was performed at model level.
