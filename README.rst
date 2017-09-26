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

#. Clone the documentation repository

    .. code:: bash

        git clone https://github.com/OXID-eSales/developer_documentation.git
        cd developer_documentation

#. Manually install the PHP highlighting extension: https://github.com/fabpot/sphinx-php
#. Then you can run *pip install* to install the proper version of `sphinx <http://www.sphinx-doc.org/>`_ and the other requirements

    .. code:: bash

        pip install -r requirements.txt

#. You need to download `plantuml <http://plantuml.com/>`_ and provide the JAR file under /opt/plantuml.jar
#. To generate documentation run

    .. code:: bash

        cd developer_documentation
        sphinx-autobuild -b html . build
#. Watch out for **WARNINGS** during the build and get rid of them.
#. Open `http://127.0.0.1:8000/` in your browser. Press ^C to stop the server.

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

