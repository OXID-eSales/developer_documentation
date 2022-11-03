Executing Tests
===============

In order to execute OXID eShop tests you have to configure PhpStorm to use the same PHPUnit settings.

First make sure that you configured the CLI PHP interpreter from the VM
(:menuselection:`File --> Settings --> Languages & Frameworks --> PHP`).

Then visit
:menuselection:`File --> Settings --> Languages & Frameworks --> PHP --> Test Frameworks`
and add a new test framework ``PHPUnit by Remote Interpreter``. You get a new configuration form. Choose the following
settings:

- PhpUnit library

  Choose ``Path to phpunit.phar`` and configure
  ``Path to script: /var/www/oxideshop/vendor/bin/phpunit``


.. important::

  Be sure to refresh the detection of the PhpUnit version with the refresh button every time the version changes.
  Otherwise PhpStorm might call PhpUnit with the wrong parameters.

- Test runner

  ``Default configuration file``: ``/var/www/oxideshop/phpunit.xml``

  ``Default bootstrap file``: ``/var/www/oxideshop/tests/bootstrap.php``