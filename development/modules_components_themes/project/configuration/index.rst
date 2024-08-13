Configuration
=============

Configuration parameters are used to customize various functionalities of OXID SHOP.
They fall into two main categories:

- values loaded by the Symfony Dotenv Component
    - value can be specified globally within the scope of the active environment
- values defined inside the Symfony DependencyInjection Container
    - value can be specified for the scope of the current shop ID and the active environment


.. toctree::
    :titlesonly:
    :glob:

    dotenv
    environment_parameters
    container_parameters
    db_config
    email_configuration
    password_hashing
