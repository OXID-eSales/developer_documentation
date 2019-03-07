.. uml::

    @startuml

    left to right direction

    state "Launched (eShop) \n Activated(eShop Module)" as LaunchedActivated
    state "Not Existent" as NotExistent
    Installed: Files and configuration \n in place.
    NotExistent --> Installed : Installation
    Installed --> LaunchedActivated : Setup

    @enduml