Using the Twig Sandbox Extension
================================

.. todo: #HR: ist there a reason while the file was not included in the toctree?
         #HR 2025-04-08: we did not include it for 7.2 as twig package we used for 7.2 and below had some security issues wit sandbox. For 7.3 please include this document as we will use newer twig package.

Twig offers a `Sandbox extension <https://twig.symfony.com/doc/3.x/api.html#sandbox-extension>`__ that enables the use
of the ``{% sandbox %}`` tag with the ``{% include %}`` and ``{% include_content %}`` tags.

This extension is particularly useful for controlling which tags, filters, and functions are allowed within templates, enhancing security during dynamic template rendering.

To configure and use the Twig Sandbox extension in your OXID eShop, perform the following steps.

|procedure|

1. Create a sandbox extension factory.

   .. todo: #HR: Reichen die Beispiele so roh, oder wären erklärungen nötig/hilfreich, warum bestimmte Tags, Filter und Funktionen erlaubt sind, warum in unserem Beispiel escape und raw erlaubt sind oder warum for als Tag zugelassen ist?
            #HR 2025-04-08: should be enough examples as only developers familiar with twig will touch this part anyway. If we get feedback, we can still improve.

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

#. Register the sandbox extension.

   .. todo: #HR: Wo registriere ich? in services.yml oder service.yml?
            #HR 2025-04-08: usually you'll put all of this in a component or a module and then register it in that component's/module's services.yaml file

   .. code:: yaml

        ACME\Twig\Extensions\SandboxExtensionFactory:
          class: ACME\Twig\Extensions\SandboxExtensionFactory

        Twig\Extension\SandboxExtension:
          factory: ['ACME\Twig\Extensions\SandboxExtensionFactory', 'getExtension']
          tags: [ 'twig.extension' ]

#. Clear the cache.

   .. code:: bash

      vendor/bin/oe-console oe:cache:clear

#. To enforce the sandbox policy, wrap template includes with the ``{% sandbox %}`` tag.

   .. code:: twig

        {% sandbox %}
            {% include 'user.html.twig' %}
        {% endsandbox %}

        # Or

        {% sandbox %}
            {% include_content "sandbox_test" %}
        {% endsandbox %}

#. Templates that do not comply with the defined sandbox policy will trigger a ``Twig\Sandbox\SecurityError`` exception.

   .. todo: #HR: Könnte es nützlich sein, ein Beispiel zu geben, was genau eine Ausnahme auslöst, wie zum Beispiel das Verwenden eines nicht erlaubten Tags oder einer nicht erlaubten Funktion?
            #HR 2025-04-08: statement above should be enough to give a hint what can trigger that error
