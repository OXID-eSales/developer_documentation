How to Replace the HTML Sanitizer Service
=========================================

This guide explains how to extend or replace the built-in HTML sanitizer
configuration in OXID eShop using Symfony services and best practices.
You will learn how to override the configuration factory while
maintaining compatibility with all enable/disable mechanisms and the
default service container.

.. note::

    The HTML sanitizer is **disabled by default**
    (``oxid_esales.html_sanitizer_enabled: false``). You must explicitly
    enable it in your services configuration (see Step 2).

Default Configuration
---------------------

The shop ships with the following default sanitizer configuration in
``HtmlSanitizerConfigFactory``:

.. code-block:: php

    return (new HtmlSanitizerConfig())
        ->allowStaticElements()
        ->allowRelativeMedias()
        ->allowRelativeLinks()
        ->allowMediaSchemes(['http', 'https']);

This allows static HTML elements (headings, paragraphs, lists, tables,
etc.) but strips interactive elements such as ``<script>``, ``<iframe>``,
and event handler attributes.

Step 1: Create Your Custom Configuration Factory
-------------------------------------------------

Create a new PHP class in your module or project:

.. code-block:: php

    <?php
    // File: CustomHtmlSanitizerConfigFactory.php

    namespace YourNameSpace;

    use OxidEsales\EshopCommunity\Internal\Framework\Html\HtmlSanitizerConfigFactoryInterface;
    use Symfony\Component\HtmlSanitizer\HtmlSanitizerConfig;

    class CustomHtmlSanitizerConfigFactory implements HtmlSanitizerConfigFactoryInterface
    {
        public function create(): HtmlSanitizerConfig
        {
            return (new HtmlSanitizerConfig())
                ->allowStaticElements()
                ->allowElement('img', ['src', 'alt', 'title', 'class', 'width', 'height'])
                ->allowElement('video', ['src', 'controls', 'width', 'height'])
                ->allowRelativeMedias()
                ->allowRelativeLinks()
                ->allowMediaSchemes(['http', 'https']);
        }
    }

.. warning::

    Be careful when allowing elements like ``<iframe>``, the ``style``
    attribute on all elements, or ``data`` in media schemes. These are
    common XSS vectors. Only allow them if your use case requires it and
    you understand the security implications.

Step 2: Override the Service Configuration
-------------------------------------------

Add the override to your module's ``services.yaml``:

.. code-block:: yaml

    parameters:
      # Enable the sanitizer (disabled by default)
      oxid_esales.html_sanitizer_enabled: true

    services:
      # Override only the configuration factory
      OxidEsales\EshopCommunity\Internal\Framework\Html\HtmlSanitizerConfigFactoryInterface:
        class: YourPathToCustomService\CustomHtmlSanitizerConfigFactory

Step 3: Clear the Cache
-----------------------

Clear the OXID cache to reload the service configuration:

.. code-block:: bash

    ./vendor/bin/oe-console oe:cache:clear

Step 4: Using the ``sanitize_html`` Twig Filter
------------------------------------------------

OXID eShop provides a Twig filter named ``sanitize_html`` (see
:doc:`SanitizeHtmlExtension <../modules_components_themes/project/twig_template_engine/twig_extensions>`)
that automatically applies the configured HTML sanitizer to template
content.

.. code-block:: twig

    {{ userInput | sanitize_html }}

- When ``oxid_esales.html_sanitizer_enabled`` is ``true``, the content
  is sanitized according to your custom configuration.
- When the sanitizer is disabled, the filter passes HTML through
  unchanged.
- This ensures consistent behavior between the Twig layer and backend
  sanitization logic.

How It Works
------------

- **Enable/Disable:** You can control sanitizer activation with
  ``oxid_esales.html_sanitizer_enabled: true/false``
- **Custom Config:** When enabled, your custom configuration from
  ``CustomHtmlSanitizerConfigFactory`` will be used
- **No Sanitization:** When disabled, the ``AllowAllHtmlSanitizer`` is
  used (no filtering)
- **Original Architecture:** The ``HtmlSanitizerFactory`` and
  ``HtmlSanitizerInterface`` remain unchanged

Testing Your Configuration
--------------------------

- With sanitizer enabled: Unsafe HTML will be filtered according to
  your custom rules
- With sanitizer disabled: All HTML passes through unchanged
- In admin: Go to CMS content management to test HTML filtering

This approach only overrides the configuration factory while preserving
the entire enable/disable mechanism and the existing service
architecture.
