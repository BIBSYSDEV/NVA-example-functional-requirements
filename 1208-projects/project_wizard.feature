Feature: User edits Project

    In order to manage a projects content
    I want to be able to manage all relevant information

    In order to achive a low mental load on the user
    I want to achive a high degree of recognition between the desing of Projects registration wizard and Publications registration wizard

    Background: A User is logged in with relevant access
    # The User has a role defined in the project 
    # or is a Curator for one of the defined users

    Rule: Any User can create a project, becoming origin Project Owner

    @2903a
    Scenario Outline: User sees the Project Wizard
        Given User opens My Projects
        When they click Create New Project Button
        Then the User is the Project Owner
        And they see tabs:
            | Description  |
            | Participants |
            | Financing    |
        And they see the Description tab
        And they see fields:
            | Title                    |
            | Summary                  |
            | Coordinating Institution |
            | Start Date               |
            | End Date                 |
            | Internal Project Code    |
        And they see a Support Button
        And they see a Button "<Button>" decided by Project's "<Status>"
        And they see a Next Button
        Examples:
            | Status    | Button                   |
            | Draft     | Save draft               |
            | Published | Update published project |

    Rule:The Projects Coordinating Institution grants it's Curators access to the project

    @2905
    Scenario: Curator opens a Project in the Project Wizard
        # Same result as "User Edits a Project in the Project Wizard",
        # but enables a Curator to edit projects
        Given User opens Landing Page for Project
        And User is Curator on Project's Coordinating Institution
        And the project lacks an Approval of type "REK"
        # See health_related_projects.feature for details.
        When they click the Edit button
        Then User sees the Project Wizard
        And it contains data about the Project

    Rule:A project have Participents, like the Local Project Manager

    @2906a
    Scenario Outline: User opens Participants tab for Project
        Given User sees the Project Wizard
        And User has one of these role in the project:
            | Curator               |
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |
        When they click the Participants tab
        Then they see lists of:
            | Project Managers     |
            | Project Participants |
        And they see Button Add Project Participant
        And they see a Previous Button
        And they see a Support Button
        And they see a Button "<Button>" decided by Project's "<Status>"
        And they see a Next Button
        Examples:
            | Status    | Button                   |
            | Draft     | Save draft               |
            | Published | Update published project |

    Rule:The Local Project Manager is a Project Manager at his institutions' scope of the project

    @2906b
    Scenario Outline: User opens Dialog for adding Project Participant
        Given User opens Participants tab for Project
        And User has role "<Role>" in the project
        When they click the Add Project Participant Button
        Then they can select role to be either of:
            | Project Partcipant    |
            | Local Project Manager |
        And they can see User search field
        Examples:
            | Role                  |
            | Curator               |
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |
    
    @2906c
    Scenario: User adds a Project Participant
        Given User opens Dialog for adding Project Participant
        When they enter a name in the User search field
        And they select a role
        And they select a User from the search
        And they click the Add Button
        Then they see the User listed as a Project Participant

    Rule: The Project Owner can grant the Project Manager role, both roles have same access to the project
    
    @2907a
    Scenario Outline: Privileged user opens Participants tab for Project
        Given User opens Participants tab for Project
        When User has role "<Role>" in the project
        Then they see Button Add Project Manager
        Examples:
            | Role            |
            | Curator         |
            | Project Owner   |
            | Project Manager |

    Rule:A project can only have one Project Owner, Project Manager and Coordinating Institution - at any given time

    @2907b
    Scenario Outline: Privileged user opens Dialog for adding Project Manager
        Given Privileged user opens Participants tab for Project
        And User has role "<Role>" in the project:
        When they click the Add Project Manager Button
        Then they see fields:
            | Start Date  |
            | User search |
        Examples:
            | Role            |
            | Curator         |
            | Project Owner   |
            | Project Manager |

    @2907c
    Scenario: Privileged user adds a Project Manager
        Given Privileged user opens Dialog for adding Project Manager
        When they select a Start Date
        And they enter a name in the User search field
        And they select a User from the search
        And they click the Add Button
        Then they see the User listed as a Project Manager

    Rule:A project may have several sources of funding (or grants)
    
    @2908a
    Scenario Outline: User opens Financing tab for Project
        Given User sees the Project Wizard
        And User has the "<Role>" role in the project
        When they click the Financing tab
        Then they see fields for:
            | Financing Code |
        And the fields are "<FieldStatus>"
        And they see a Previous Button
        And they see a Support Button
        And they see a Save and Present Button
        Examples:
            | Role                  | FieldStatus |
            | Curator               | Enabled     |
            | Project Owner         | Enabled     |
            | Project Manager       | Enabled     |
            | Local Project Manager | Disabled    |

    Rule:Funding organisazations consider there funding a project, but it is a funding source (a grant) from our point of view

    @2908b
    Scenario: User adds a Financing source for Project
        Given User opens Financing tab for Project
        When they enter a search text in the search field
        And they select a Financing source from the search results
        #https://prosjektbanken.forskningsradet.no/prosjektbanken/rest/cristin/search?query=111
        #https://beta.explore.openaire.eu/search/advanced/projects?q=&op=and
        Then they see that the Project/Financing Code is added to the project

    @2909
    Scenario Outline: User Save a Project draft
        Given User sees the Project Wizard
        And the Project has a Draft status
        And User has role "<Role>" in the project:
            | Local Project Manager |
        When the User clicks on the Save draft Button
        Then the Project is saved with a Draft status
        And the User is notified of result
        Examples:
            | Role                  |
            | Curator               |
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |
