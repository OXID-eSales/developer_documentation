How to Replace the HTML Sanitizer Service
=========================================

This guide explains how to extend or replace the built-in HTML sanitizer configuration in OXID eShop using Symfony services and best practices. You will learn how to override the configuration factory while maintaining compatibility with all enable/disable mechanisms and the default service container.

Step 1: Create Your Custom Configuration Factory
-------------------------------------------------

Create a new PHP class in your project:

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
                // Add your custom configuration here
                ->allowSafeElements()
                ->allowElement('img', ['src', 'alt', 'title', 'class', 'width', 'height'])
                ->allowElement('iframe', ['src', 'width', 'height', 'frameborder'])
                ->allowElement('video', ['src', 'controls', 'width', 'height'])
                ->allowAttribute('style', '*')  // Allow style attribute on all elements
                ->allowRelativeMedias()
                ->allowRelativeLinks()
                ->allowMediaSchemes(['http', 'https', 'data']);
        }
    }

Step 2: Override the Service Configuration
-------------------------------------------

Edit your services definition:

.. code-block:: yaml

    parameters:
      # Enable the sanitizer (set to false to disable)
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

Step 4: Using the `sanitize_html` Twig Filter
---------------------------------------------

OXID eShop provides a Twig filter named `sanitize_html` (see :doc:`SanitizeHtmlExtension <../modules_components_themes/project/twig_template_engine/twig_extensions>`) that automatically applies the configured HTML sanitizer to template content.

.. code-block:: twig

    {{ userInput | sanitize_html }}

- When oxid_esales.html_sanitizer_enabled is true, the content is sanitized according to your custom configuration.
- When the sanitizer is disabled, the filter passes HTML through unchanged.
- This ensures consistent behavior between the Twig layer and backend sanitization logic.

How It Works
------------

- **Enable/Disable:** You can control sanitizer activation with ``oxid_esales.html_sanitizer_enabled: true/false``
- **Custom Config:** When enabled, your custom configuration from ``CustomHtmlSanitizerConfigFactory`` will be used
- **No Sanitization:** When disabled, the ``AllowAllHtmlSanitizer`` is used (no filtering)
- **Original Architecture:** The ``HtmlSanitizerFactory`` and ``HtmlSanitizerInterface`` remain unchanged

Testing Your Configuration
--------------------------

- With sanitizer enabled: Unsafe HTML will be filtered according to your custom rules
- With sanitizer disabled: All HTML passes through unchanged
- In admin: Go to CMS content management to test HTML filtering

This approach only overrides the configuration factory while preserving the entire enable/disable mechanism and the existing service architecture.
