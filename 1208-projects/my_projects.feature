Feature: User My Projects
    In order know of all project where I'm involved
    As a logged in User 
    I want to see lists of active and concluded project, and have access to manage those I'm responsible of

    @2874a
    Scenario: User opens My Projects
        Given that a User is logged in
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
        # A "REK" Approved project is a Health Project. 
        # See health_related_projects.feature for details.
        When they click the Edit Button 
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
