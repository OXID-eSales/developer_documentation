Possibility to use Twig Sandbox extension
=========================================

Twig provides `Sandbox extension <https://twig.symfony.com/doc/3.x/api.html#sandbox-extension>`__ that allows usage of
`{% sandbox %} tag <https://twig.symfony.com/doc/3.x/tags/sandbox.html>`__ with ``{% include %}`` and
``{% include_content %}`` tags. To configure it for OXID eShop you can follow the steps below.

1. Create a sandbox extension factory

.. code:: php

    class SandboxExtensionFactory
    {
        public static function getExtension(): Twig\Extension\SandboxExtension
        {
            $policy = new Twig\Sandbox\SecurityPolicy(
                allowedTags: ['for'],
                allowedFilters: ['escape', 'raw'],
                allowedFunctions: ['range'],
            );
            return new Twig\Extension\SandboxExtension($policy);
        }
    }

2. Register the sandbox extension using the factory

.. code:: yaml

  ACME\Twig\Extensions\SandboxExtensionFactory:
    class: ACME\Twig\Extensions\SandboxExtensionFactory

  Twig\Extension\SandboxExtension:
    factory: ['ACME\Twig\Extensions\SandboxExtensionFactory', 'getExtension']
    tags: [ 'twig.extension' ]

3. Clean up the cache

.. code:: bash

    vendor/bin/oe-console oe:cache:clear

4. Wrap template includes with the ``{% sandbox %}`` tag

.. code:: twig

    {% sandbox %}
        {% include 'user.html.twig' %}
    {% endsandbox %}

    # or

    {% sandbox %}
        {% include_content "sandbox_test" %}
    {% endsandbox %}

5. Sandboxed templates that don't follow policy restrictions should throw a ``Twig\Sandbox\SecurityError`` exception
