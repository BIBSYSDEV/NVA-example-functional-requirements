Feature: Project Landing Page

    Project is a vital part of the core data model, it fullfilles two roles:
    i) it define a scope that connects other core entites together 
        - Person
        - Institution
        - Result
    ii) it defines this scope by
        - describing it (Description)
        - give roles to Persons (Participants)
        - show the mony trail (Financing)
        - documents Approvals (and applications)

    In order to know about a project
    As an anonymous User
    I want an overview of the projects details 

    In order to publish validated information about a project
    As a logged in User 
    I want to get an preview of my project, before I make it public

    In order to correct a project that is missleading
    As a logged in User with relevant access
    I want to be able to manage the published project

    In order to understand the Reasearch Graph
    As an anonymous User
    I want to experience a high recognition between the Projects and the Outputs Landing Pages desings

    In order to navigate the Reasearch Graph
    As an anonymous User
    I want to get all relevant navigation options for further discovery of the projects outputs, praticipants, finances and approvals

    Rule: A project has a persistent identifier, enabling correct citation and coining it as a enity in the Reaserch Graph

    @2630
    Scenario: User opens Landing Page for Project
        Given Anonymous User views Landing Page for Registration
        And the Registration has a Project
        When they click the Link to a Project
        Then they see:
            | Title     |
            | Owner     |
            | Manager   |
            | Period    |
            | Financing |
            | Approvals |
        And they see collapsed panels:
            | Scientific summary |
            | Participants       |
            | Results            |

    @2697
    Scenario: User sees Clinical Trial Phase for Drug studies
        Given User opens Landing Page for Project
        When the Project is a Drug study
        Then they can see the Project's Clinical Trial Phase

    @2631
    Scenario: User opens Scientific summary for a Project
        Given User opens Landing Page for Project
        When they expand "Scientific summary"
        Then they see the Scientific summary

    @2632
    Scenario: User opens Participants for a Project
        Given User opens Landing Page for Project
        When they expand "Participants"
        Then they see a list of Participants and their:
            | Name        |
            | Role        |
            | Affiliation |

    @2633
    Scenario: User opens Results for a Project
        Given User opens Landing Page for Project
        When they expand "Results"
        Then they see a list of Results

    @2904
    Scenario Outline: User Publish a Draft Project
        Given User opens Landing Page for Project
        And the Project status is Draft
        And User has role "<Role>" in the project
        And the project has all required fields
        And the User see the enabled Publish Button
        When the User clicks on the Publish Button
        Then the project status is Published 
        And the Project has a public accessible Landing Page
        Examples:
            | Role            |
            | Curator         |
            | Project Owner   |
            | Project Manager |
