Feature: User My Projects

    In order to achive a low mental load on the user
    I want to achive a high degree of recognition between the desing of My Projects and My Publications - both accessible from the top menu

    In order to know of all project where I'm involved
    I want to see lists of active and concluded project, and have access to manage those I'm responsible of

    In order to keep projects I'm responsible of up to date
    I want easy access to manage those 

    In order to see all details of a project
    I want easy access to the landing page 

    In order to locate the project in mind
    I want easy access to search in My Projects

    In order to create new projects
    I want easy access to create new projects

    Background: A User is logged in

    @2874a
    Scenario: User opens My Projects
        When they navigate to the My Projects Page
        Then they see a Create New Project Button
        And they see a search field
        And they see a list of Active Projects
        And they see a collapsed list of Concluded Projects
        And the lists contains Projects where the User has the role as:
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |
            | Participants          |
        And each Project has:
            | Title           |
            | Institution     |
            | Project Manager |
        And each Project has an Edit button if the User has role: 
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |
        And the list can be sorted by:
            | Title           |
            | Institution     |
            | Project Manager |
        And they see pagination buttons for the Concluded Projects list
    
    @2874b
    Scenario: User opens a Project's Landing Page
        Given User opens My Projects
        When they click a Project's Title 
        Then they see the Landing Page for the Project

    @2874c
    Scenario Outline: User Edits a Project in the Project Wizard
        # See also Curator opens a Project in the Project Wizard
        Given User opens My Projects
        And User has "<Role>" on the Project
        And the project lacks an Approval of type "REK"
        # See health_related_projects.feature for details.
        When they click the Edit Button on a project
        Then they see the Project in the Project Wizard
        Examples:
            | Role                  |
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |

    @2875
    Scenario: User search in My Projects
        Given User opens My Projects
        When they enter a search term in the search field
        Then they see Projects matching the search term in the Project's:
            | Title        |
            | Institution  |
            | Participants |
