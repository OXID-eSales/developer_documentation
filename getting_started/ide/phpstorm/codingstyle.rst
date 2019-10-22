Coding Style
============

OXID eShop uses PSR-2 as coding style. This guide shows you step by step, how PhpStorm can assist you with
the coding style.

1. Installation of CodeSniffer
------------------------------

PhpStorm uses the command line tool `CodeSniffer <https://github.com/squizlabs/PHP_CodeSniffer>`_ to detect coding style
warnings and errors. When installing OXID eShop, CodeSniffer is installed by composer as
well (if you did not specify the  ``--no-dev`` switch on the command line). Check, this by executing CodeSniffer on the
command line:

.. code:: bash

   vendor/bin/phpcs

2. Configure PhpStorm to use CodeSniffer
----------------------------------------

#. Configure the path to CodeSniffer in PhpStorm. This is described in the
   `Jetbrains documentation <https://www.jetbrains.com/help/phpstorm/using-php-code-sniffer.html>`_

#. PhpStorm has multiple profiles where you can configure, how PHP files should be inspected:

   #. Go to :menuselection:`File --> Settings`.
   #. Choose :menuselection:`Editor --> Inspections`
   #. Choose :menuselection:`Profile: Project Default`.
   #. Choose :menuselection:`PHP --> Quality Tools` and enable :menuselection:`PHP Code Sniffer validation`.
   #. Choose :menuselection:`Coding standard: PSR2`.

#. Configure the PhpStorm editor to use PSR2 as well:

   #. Go to :menuselection:`File --> Settings`.
   #. Choose :menuselection:`Editor -> Code Style -> PHP`
   #. Select :menuselection:`Scheme: Project`.
   #. Select :menuselection:`Set from --> Predefined Style --> PSR1/PSR2`.

3. Coding Style in Action
-------------------------

* The PhpStorm editor shows you in every file via grey, serrated line where the coding style is corrupted.
* PhpStorm can apply the coding style by reformatting existing code via :menuselection:`Code --> Reformat Code`.
* You are able to run an inspection via :menuselection:`Code --> Inspect Code`. PhpStorm reports
  you CodeSniffer errors (and warnings if configured) in the section :menuselection:`PHP --> Quality Tools`.





