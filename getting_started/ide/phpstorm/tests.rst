Executing Tests
===============

In order to execute OXID eShop tests (or any tests written with the
`Testing Library <https://github.com/OXID-eSales/testing_library>`__)
you have to configure PhpStorm to use the same PHPUnit settings as e.g. the command :command:`runtests`
of the testing library.

First make sure that you configured the CLI PHP interpreter from the VM
(:menuselection:`File --> Settings --> Languages & Frameworks --> PHP`).

Then visit
:menuselection:`File --> Settings --> Languages & Frameworks --> PHP --> Test Frameworks`
and add a new test framework ``PHPUnit by Remote Interpreter``. You get a new configuration form. Choose the following
settings:

- PhpUnit library

  Choose ``Use composer autoloader`` and configure
  ``Path to script: /var/www/oxideshop/vendor/autoload.php``


.. important::

  Be sure to refresh the detection of the PhpUnit version with the refresh button every time the version changes.
  Otherwise PhpStorm might call PhpUnit with the wrong parameters.

- Test runner

  ``Default configuration file``: ``/var/www/oxideshop/vendor/oxid-esales/testing-library/phpunit.xml``

  ``Default bootstrap file``: Not configured