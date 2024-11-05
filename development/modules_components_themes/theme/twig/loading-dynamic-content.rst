Loading dynamic content via AJAX
================================

As a module developer, when working with dynamic content loaded via Ajax, use the ``setOuterHtmlAndExecuteScripts`` method to replace elements in the DOM with new content while also handling the execution of any JavaScript embedded in that content.

The ``setOuterHtmlAndExecuteScripts`` method replaces an existing HTML element with new content and ensures that any embedded JavaScript is executed."

The `setOuterHtmlAndExecuteScripts` function is an addition to the `main.js` file.

Advantages
----------

A key advantage of this function is that it automatically executes JavaScript included in new HTML content, unlike directly setting an element's ``outerHTML``.

When you simply set the `outerHTML` of an element, any embedded scripts in the new content are not automatically executed. This function addresses that limitation.

Practical Example
-----------------

This function is used, for example, in the variant selection process in e-commerce (as implemented in ``variants.js``).

When a user selects a different product variant, the description or other content related to that variant might be loaded via Ajax and used to replace the existing content.

If the new content includes scripts (such as for tracking or displaying variant-specific information), `setOuterHtmlAndExecuteScripts` ensures these scripts are executed not only when the page loads initially but also each time the user changes the variant.

Using the method
----------------

Make an asynchronous HTTP (AJAX) request to a server and update part of the webpage based on the server's response.

The ``setOuterHtmlAndExecuteScripts`` takes an HTML element (in our example, ``document.getElementById('details_container')``) and replaces its content with the provided ``html``.


|procedure|

.. code::

   // Create an XMLHttpRequest object and open a GET request.
   var request = new XMLHttpRequest();
   request.open('GET', '/widget.php?' + formData, true);

   // Handle the server response
   request.onload = function () {
       if (this.status >= 200 && this.status < 400) {
           // Success!
           let html = this.response;
           // Replace the markup
           setOuterHtmlAndExecuteScripts(document.getElementById('details_container'), html);
           // Bind the event listeners again
           addDropdownLinksEventListeners();
       }
   };






