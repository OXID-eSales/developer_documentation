Using the Twig Sandbox Extension
================================

Twig offers a `Sandbox extension <https://twig.symfony.com/doc/3.x/api.html#sandbox-extension>`__ that enables the use
of the ``{% sandbox %}`` tag with the ``{% include %}`` and ``{% include_content %}`` tags. This extension is
particularly useful for controlling which tags, filters, and functions are allowed within templates, enhancing security
in dynamic template rendering. Below are the steps to configure and use the Twig Sandbox extension in OXID eShop.

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

2. Register the sandbox extension

.. code:: yaml

    ACME\Twig\Extensions\SandboxExtensionFactory:
      class: ACME\Twig\Extensions\SandboxExtensionFactory

    Twig\Extension\SandboxExtension:
      factory: ['ACME\Twig\Extensions\SandboxExtensionFactory', 'getExtension']
      tags: [ 'twig.extension' ]

3. Clear the cache

.. code:: bash

    vendor/bin/oe-console oe:cache:clear

4. Wrap template includes with the ``{% sandbox %}`` tag to enforce the sandbox policy

.. code:: twig

    {% sandbox %}
        {% include 'user.html.twig' %}
    {% endsandbox %}

    # Or

    {% sandbox %}
        {% include_content "sandbox_test" %}
    {% endsandbox %}

5. Templates that do not comply with the defined sandbox policy will trigger a ``Twig\Sandbox\SecurityError`` exception
