**************
Twig templates
**************

.. _register-module-templates:

Register module templates
#########################

To register your Twig templates you have to put them to `/views/twig/tpl/` directory in your module root directory.
After module activation templates will be automatically registered with namespace which equals your module id `@<module-id>/template-name.html.twig`.

For example, PayPal module has module id `oepaypal` and template `/views/twig/tpl/custom-template.html.twig`. This template will be available as
`@oepaypal/custom-template.html.twig`.

Extend template
###############

Twig templates can be extended from another one by `extends` tag. Also, there is a possibility to have more than one
extends tag called per rendering which is possible by supporting multiple inheritances. Therefore a specific template
can be extended in multiple modules.

We can extend templates for :ref:`All themes<all-themes>` or :ref:`specific theme<specific-theme>`,
and also we can extend :ref:`admin templates<admin-templates>`.

.. _all-themes:

Extend for all themes
*********************

To extend a shop template you have to create in your module's template directory
`/views/twig/tpl/`
new file with the same name and directory structure as the path from shop's `tpl` directory,
and extend template blocks in the standard Twig way, providing the relative path.
For more information about Twig inheritance: `Twig inheritance documentation <https://twig.symfony.com/doc/3.x/tags/extends.html>`_

.. warning::

    Dynamic or conditional inheritance of shop templates is not supported by modules and must not be used.

Example:

You want to extend `tpl/page/details/inc/productmain.html.twig` for all themes which have this template. The relative path to the theme `tpl` directory
is `page/details/inc/productmain.html.twig`. You have to create a template in your module with the following path and content
`/views/twig/tpl/page/details/inc/productmain.html.twig`

::

    module
    └── views
        └── twig
            └── tpl
                └── page
                    └── details
                        └── inc
                            └── productmain.html.twig

.. code:: php

    {% extends "page/details/inc/productmain.html.twig" %}
    {% block details_productmain_title %}
        {{ parent() }}
        Your module content.
    {% endblock %}

.. _specific-theme:

Extend for specific theme
*************************

Inheritance for a specific theme is similar to inheritance for all themes,
but you have to put your template in `/views/twig/tpl/<theme-id>` directory in your module instead of `/views/twig/tpl/`.

Example:

You want to extend `tpl/page/details/inc/productmain.html.twig` only for the "wave" theme. You have to create a template in your module with
the following path `/views/twig/tpl/wave/page/details/inc/productmain.html.twig`


.. note::

    If the activated theme doesn't have a specific template extension, the template from the `/views/twig/tpl/` will be used.

.. _admin-templates:

Extend admin templates
**********************

Inheritance for the admin is similar to inheritance for a specific theme, because admin is a theme as well,
you just have to use inheritance for a specific theme and admin theme id for this.

Example:

The default admin theme in oxid has id `admin_twig', to extend `tpl/some-template.html.twig` from the admin theme you have to create a template in your module with
following path `/views/twig/tpl/admin_twig/some-template.html.twig`