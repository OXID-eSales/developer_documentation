Unit tests
==========

We should try to write good and real unit tests:
 - Easy to write
 - Readable
 - Reliable
 - Fast
 - Truly unit (test should not access the network resources, databases, file system, etc.)

To run unit tests call:

.. code::

  vendor/bin/phpunit -c phpunit.xml tests/Unit
