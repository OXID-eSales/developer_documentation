Module installation and setup states
====================================

To understand data flow in OXID eShop functionality please have a look to the diagram bellow:

.. uml::

    @startuml

    top to bottom direction

    state "Setup done" as Setup
    state "None existent" as NonExistent
    state "Configured" as Configured
    Installed: Files and configuration \n in place.
    Configured: Module configured\nConfiguration files\nupdated
    Setup: Module activated
    [*] --> NonExistent
    NonExistent --> Installed: **Installation**\nvia <i> composer install</i>
    Installed --> Configured: Configure module
    Configured --> Setup : Module activation via eShop\nadmin web interface\nor CLI command

    @enduml

In schema you can see 4 states:

**1. None existent:**

State where module in OXID eShop does not exist yet.

**2. Installed:**

When all files are in place and configuration files are generated.

**3. Configured:**

State where OXID eShop administrator configures a module via OXID eShop admin, or by editing configuration files.
More about module configuration please read :doc:`modules configuration document </project/modules_configuration_setup>`.

**4. Setup done:**

When module being activated, the data goes from configuration files to the database. At this state
module becomes active.
