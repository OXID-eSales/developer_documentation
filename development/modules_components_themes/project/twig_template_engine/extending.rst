Extending Twig
==============

If needed twig extensions can be replaced or new extension can be added to the project.

Replacing existing extensions
-----------------------------

Replacing extension can be done in two ways.

* The first one is to simply `add extension to Twig environment <https://twig.symfony.com/doc/2.x/advanced.html#overloading>`__.
* The other way is to override extension service of the `OXID eShop twig component <https://github.com/OXID-eSales/twig-component>`__ .

As every extension is a service, so redefining particular service in custom :file:`services.yaml` file does the job.

Adding new extension
--------------------

Adding new extension is as simple as defining service. Extension is automatically added to Twig environment if service
has ``twig.extension`` tag::

  services:
    OxidEsales\Twig\Extensions\StyleExtension:
      class: OxidEsales\Twig\Extensions\StyleExtension
      tags: ['twig.extension']

Adding new escapers
-------------------

Every escaper is a class which implements \OxidEsales\Twig\Escaper\EscaperInterface. Escaper is
registered in Twig as service with ``twig.escaper`` tag::

  services:
    OxidEsales\Twig\Escaper\MailEscaper:
      class: OxidEsales\Twig\Escaper\MailEscaper
      tags: ['twig.escaper']

If needed, escapers can be overloaded by redefining services.
