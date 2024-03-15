OXID eShop developer documentation
==================================

This is the OXID eShop developer documentation.

The generated documentation can be found here: https://docs.oxid-esales.com/developer/en/7.0-rc.2/

If you want to contribute, please read https://docs.oxid-esales.com/developer/en/7.0-rc.2/index.html#help-improving-this-documentation.
Generate the documentation locally in order to test your changes as described in the following section.

Generating docs locally
-----------------------

To generate documentation locally, our SDK with preconfigured Sphinx container can be used. Please refer to `SDK README file Sphinx usage section <https://github.com/OXID-eSales/docker-eshop-sdk#using-sphinx-container-for-documentation-generation>`_.

The Old way:
~~~~~~~~~~~~

#. Install `sphinx <http://www.sphinx-doc.org/>`__.
#. Install the `sphinx_rtd_theme <https://sphinx-rtd-theme.readthedocs.io/en/stable/installing.html>`__ (if it is missing).
#. Install the `PHP highlighting extensions <https://github.com/fabpot/sphinx-php>`__.
#. Install the `plantuml extension <https://pypi.python.org/pypi/sphinxcontrib-plantuml>`__.

   If you have a mac PC, install plantuml separately e.g. via `brew <https://formulae.brew.sh/formula/plantuml>`__.

   Either configure the path to the file `plantuml.jar` in the file `config.py` or put a wrapper script in your path as described in the link above.
#. Clone thw documentation repository:
    .. code:: bash

        git clone https://github.com/OXID-eSales/developer_documentation.git

#. To generate documentation, run:
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

Using OXID SDK for regenerating the documentation
-------------------------------------------------

By being in the root of the project (where Makefile is), install the documentation and required containers by using
following commands:

.. code:: bash

    git clone https://github.com/OXID-eSales/developer_documentation docs
    make addsphinxservice docpath='./docs'
    docker-compose up --build -d sphinx

To run documentation regeneration, use:

.. code:: bash

    make generate-docs

Generated documentation will be available in `docs/build` folder