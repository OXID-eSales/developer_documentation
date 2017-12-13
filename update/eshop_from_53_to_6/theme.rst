Theme
=====

Depending on if you use the old deprecated theme `azure <https://github.com/OXID-eSales/azure-theme>`__ or the new
standard theme `flow <https://github.com/OXID-eSales/flow_theme>`__ in OXID eShop 4.10 / 5.3, you have to take
different actions.

Theme azure
^^^^^^^^^^^

If you use or extend the deprecated theme azure in OXID eShop 4.10 / 5.3,
we recommend to use or extend the new standard theme flow instead.

If you want to use still the theme azure,
you have to include azure first in OXID eShop 6
`like described in the azure installation instructions <https://github.com/OXID-eSales/azure-theme/>`__
as it is not delivered by default any more. There is an version of the flow
theme compatible to OXID eShop 4.10 / 5.3 and a version compatible  to OXID eShop 6
`like described here <https://github.com/OXID-eSales/flow_theme>`__.

If you extended the azure theme with a custom theme, you have to update your custom theme
as described in the section :ref:`Updating a custom theme <update-eshop_from_53_to_6_theme_custom_theme>`.
Please also update your modules accordingly.


Theme flow
^^^^^^^^^^

If you already use the theme ``flow`` in OXID eShop 4.10 / 5.3, you don't have to do anything. The flow theme is delivered
by default with OXID eShop 6.

There is an OXID eShop 6 compatible version of the flow theme which has some differences
to the version delivered in OXID eShop 4.10 / 5.3 `like described here <https://github.com/OXID-eSales/azure-theme/>`__.

If you extended the flow theme in OXID eShop 4.10 / 5.3 you have to check the differences between the OXID
eShop 4.10 / 5.3 compatible flow version and the OXID eShop 6 compatible flow version. Afterwards, update
your custom theme as described in the section :ref:`Updating a custom theme <update-eshop_from_53_to_6_theme_custom_theme>`.
Please also update your modules accordingly.

.. _update-eshop_from_53_to_6_theme_custom_theme:

Updating a custom theme
^^^^^^^^^^^^^^^^^^^^^^^

In order to use your custom theme (name ``yourThemeName`` in this example) from OXID eShop 4.10 / 5.3 in OXID eShop 6,
copy the folders

* :file:`application/views/yourThemeName` from OXID eShop 4.10 / 5.3 to :file:`Application/views/yourThemeName` in OXID eShop 6
* :file:`out/yourThemeName` from OXID eShop 4.10 / 5.3 to the equivalent directory in OXID eShop 6

Afterwards you have to adapt your theme to the new version of its parent theme. Also copy
the file :file:`favicon.ico` from the shops root folder if you modified it.