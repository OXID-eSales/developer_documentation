Debugging templates with ``dump()``
====================================

Twig's built-in DebugExtension provides the `dump() <https://twig.symfony.com/doc/3.x/functions/dump.html>`__
function, which outputs a detailed representation of one or more variables directly in the rendered template.

Prerequisites
-------------

The ``dump()`` function is only available when Twig debug mode is active.
Twig debug mode is enabled whenever :ref:`iDebug <configincphp_iDebug>` is set to any non-zero value in :file:`source/config.inc.php`.
The typical choice for a development environment is ``-1``:

.. code:: php

    $this->iDebug = -1;

.. warning::

    Enable debug mode in development environments only.
    Any non-zero ``iDebug`` value exposes internal data and exception details in the browser output.

Usage
-----

Dump a single variable:

.. code:: twig

    {{ dump(oProduct) }}

Dump multiple variables at once:

.. code:: twig

    {{ dump(oProduct, oViewConf) }}

Wrap the output in ``<pre>`` for better readability:

.. code:: twig

    <pre>{{ dump(oProduct) }}</pre>

Calling ``dump()`` without arguments dumps all variables available in the current template scope.
This is not recommended — OXID eShop templates contain many large objects, which makes the output difficult to read.
