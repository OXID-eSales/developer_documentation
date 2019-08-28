.. uml::

    @startuml

    left to right direction

    state "Setup was done" as LaunchedActivated
    Installed: Files and configuration \n in place.
    LaunchedActivated: Module activated
    [*] --> Installed: **Installation**\nvia <i> composer install</i>
    Installed --> LaunchedActivated : Module activation via eShop\nadmin web interface\nor CLI command

    @enduml
