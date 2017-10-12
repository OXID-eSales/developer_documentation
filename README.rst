OXID eShop developer documentation
==================================

.. image:: https://travis-ci.org/OXID-eSales/developer_documentation.svg?branch=master
   :target: https://travis-ci.org/OXID-eSales/developer_documentation

This is OXID eShop developer documentation. It should provide necessary up to date information for developers.

Currently this repository contains skeleton for documentation which should become useful documentation for developers.

Generated documentation can be found here: http://oxid-eshop-developer-documentation.readthedocs.io/en/latest/

Generating docs locally
-----------------------

Section describes how to generate documentation locally.

#. First of all you'll need to install `sphinx <http://www.sphinx-doc.org/>`_.
#. Install PHP highlighting extensions: https://github.com/fabpot/sphinx-php
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


Contribution
------------

Rules for writing documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Conventions for writing documentation can be found `here <http://oxid-eshop-developer-documentation.readthedocs.io/en/latest/conventions.html>`_.

