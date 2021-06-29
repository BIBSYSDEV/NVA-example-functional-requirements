Feature: User opens My Projects

    @xxx
    Scenario: User opens My Projects
        Given that a User is logged in
        When they navigate to the Projects Page
        Then they see a Create New Project Button
        And they see a search field
        And they see a list of Active Projects
        And they see a collapsed list of Concluded Projects
        And the lists contains Projects where the User has the role as:
            | Project Manager       |
            | Local Project Manager |
            | Participant           |
        And each Project has:
            | Title           |
            | Institution     |
            | Project Manager |
        And each Project has an Edit button if the User is listed as as Project Manager
        And the list can be sorted by:
            | Title           |
            | Institution     |
            | Project Manager |
        And they see pagination buttons for the list
    
    Scenario: User opens a Project's Landing Page
        Given User opens My Projects
        When they click the Title 
        Then they see the Landing Page for the Project

    Scenario: User Edits a Project in Project Wizard
        Given User with access rights moves the cursor over a project
        When they click the Edit Button for a Project
        Then User opens a Project in the Project Wizard

    @xxx
    Scenario: User search for Projects
        Given User opens My Projects
        When they enter a search term in the search field
        Then they see Projects matching the search term in the Project's:
            | Title           |
            | Institution     |
            | Participant     |