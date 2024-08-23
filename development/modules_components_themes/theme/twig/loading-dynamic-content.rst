Loading dynamic content via AJAX
================================

.. todo: #HR Querverweis seten in folgendem Kapitel?

:ref:`development/modules_components_themes/module/tutorials/override_functionality:Override existing OXID eShop functionality`

The `setOuterHtmlAndExecuteScripts` method replaces an existing HTML element with new content, while also ensuring that any JavaScript embedded in the new content is executed.

The `setOuterHtmlAndExecuteScripts` function is an addition to the `main.js` file.

As a module developer, when working with dynamic content loaded via Ajax, use the method to replace elements in the DOM with new content while also handling the execution of any JavaScript embedded in that content.

Benefit
-------

One of the main advantages of using this function over directly setting an element's `outerHTML` is that it automatically executes any JavaScript code included in the new HTML content.

When you simply set the `outerHTML` of an element, any embedded scripts in the new content are not automatically executed. This function addresses that limitation.

Practical Example
-----------------

A specific example of where this function is utilized is in the variant selection process within an e-commerce setting (as referenced by `variants.js`).

When a user selects a different product variant, the description or other content related to that variant might be loaded via Ajax and used to replace the existing content.

If the new content includes scripts (such as for tracking or displaying variant-specific information), `setOuterHtmlAndExecuteScripts` ensures these scripts are executed not only when the page loads initially but also each time the user changes the variant.

Using the method
----------------

To dynamically load content, pass the required paramaters.

|procedure|

.. todo: #HR: practical example of how to pass the parameters would be nice

.. code::

   setOuterHtmlAndExecuteScripts

* The first is the HTML element that is to be replaced.
* The second is the HTML content that will be used as the replacement.





