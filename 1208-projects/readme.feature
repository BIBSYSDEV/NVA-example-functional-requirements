Project is a vital part of the Reaserch Graph or core data model. 

The project fullfilles this roles by:
    i) being the entity that connects other core entites:
        - Person
        - Institution
        - Result
    ii) it define the scope by:
        - describing it (Description)
        - give roles to Persons (Participants)
        - show the money trail (Financing)
        - documents Approvals (and indirectly also applications)

The project is described by four feature files:
    project_landing_page:
        - describes the public view of a project
        - privileged users may preview a project prior to publication
    my_project:
        - give the user a overview of all projects where he is involved
        - seperate between active and closed projects
        - enable the user to create new projects
        - has search functionality
    project_wizard:
        - enable the user to fill in needed information about a project
    healt_project:
        - if the project got a REK approval, it is a healt project
        - it describe what changes, when the project is a healt project