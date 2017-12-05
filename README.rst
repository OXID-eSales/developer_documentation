OXID eShop developer documentation
==================================

.. image:: https://travis-ci.org/OXID-eSales/developer_documentation.svg?branch=master
   :target: https://travis-ci.org/OXID-eSales/developer_documentation

This is the OXID eShop developer documentation.

The generated documentation can be found here: https://docs.oxid-esales.com/developer/en/6.0/

If you want to contribute, please read https://docs.oxid-esales.com/developer/en/6.0/index.html#help-improving-this-documentation.
Generate the documentation locally in order to test your changes as described in the following section.

Generating docs locally
-----------------------

Section describes how to generate documentation locally.

#. First of all you'll need to install `sphinx <http://www.sphinx-doc.org/>`__
#. Install the `PHP highlighting extensions <https://github.com/fabpot/sphinx-php>`__
#. Install the `plantuml extension <https://pypi.python.org/pypi/sphinxcontrib-plantuml>`__.
   Either configure the path to the file `plantuml.jar` in the file `config.py` or put a wrapper script in your path
   like described in the link above.
#. Clone documentation repository:
    .. code:: bash

        git clone https://github.com/OXID-eSales/developer_documentation.git

#. To generate documentation run:
    .. code:: bash

        cd developer_documentation
        sphinx-build ./ ./build

#. Open `build/index.html` file with your browser.

Generating diagrams
-------------------

To generate diagrams using plantUml, use this command:

.. code:: bash

   java -jar /opt/plantuml.jar -svg -o ./ **.puml
   
*/opt/plantuml.jar - path to your plantUml file.*

PlantUml will generate .svg files, which can be used in documentation.