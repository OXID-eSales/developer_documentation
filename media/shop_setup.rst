.. uml::

    @startuml

    left to right direction

    state "Setup was done" as LaunchedActivated
    Installed: Files and configuration \n in place.
    LaunchedActivated: eShop in working state
    [*] --> Installed: Installation\nvia <i> composer create-project</i>
    Installed --> LaunchedActivated : **Setup**\nvia graphical \nuser interface

    @enduml
