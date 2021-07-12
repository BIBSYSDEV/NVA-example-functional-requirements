Feature: Project Landing Page

    Project is a vital part of the core data model, it fullfilles two roles:
    i) it define a scope that connects other core entites together 
        - Person
        - Institution
        - Result
    ii) it defines this scope by
        - describing it (Description)
        - give roles to Persons (Participants)
        - show the money trail (Financing)
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
        When An Anonymous User open a Project Landing Page
        Then they see:
            | Project Title                |
            | Project Owner Institution    |
            | Project Manager              |
            | Project Period               |
            | Financing                    |
            | Approvals                    |
        And they see collapsed panels:
            | Scientific summary |
            | Participants       |
            | Results            |
        And they see number of elements of Participants and Results

    @2886
    Scenario Outline: Privileged user sees Edit button for Project
        Given User opens Landing Page for Project
        When the User has the "<Role>" role for the project
        Then they can see an Edit button
        Examples:
            | Role                  |
            | Curator               |
            | Project Owner         |
            | Project Manager       |
            | Local Project Manager |

    @2885a
    Scenario Outline: Privileged user sees Delete button for Project
        Given User opens Landing Page for Project
        When the User has the "<Role>" role for the project
        Then they can see a Delete button
        Examples:
            | Role            |
            | Curator         |
            | Project Owner   |
            | Project Manager |

    @2885b
    Scenario: Privileged user clicks the Delete Button for a Project
        Given Privileged user sees Delete button for Project
        When they click the Delete Button 
        Then they see a Confirm Dialog

    @2885c
    Scenario: Privileged user deletes a Project
        Given Privileged user clicks the Delete Button for a Project
        When they Confirm the action
        Then the Confirm Dialog is closed
        And the Project is marked deleted
        And The Project is removed from the Projects list

    @2631
    Scenario: User opens Scientific summary for a Project
        Given User opens Landing Page for Project
        When they expand "Scientific summary"
        Then they see the Scientific summary

    @2632a
    Scenario: User opens Participants for a Project
        Given User opens Landing Page for Project
        When they expand "Participants"
        Then they see a list of Participants and their:
            | Name        |
            | Role        |
            | Affiliation |

    @2632b
    Scenario: User sees Project Manager for a Project
        Given User opens Participants for a Project
        When they see a Project Manager
        Then they see fields:
            | Start Date  |

    @2633
    Scenario: User opens Results for a Project
        Given User opens Landing Page for Project
        When they expand "Results"
        Then they see a list of Results

    @2904
    Scenario Outline: User Publish a Draft Project
        Given User opens Landing Page for a Draft Project
        And it has all required fields:
            | Title                    |
            | Coordinating Institution |
            | Start Date               |
            | Project Manager          | 
        And User has role "<Role>" in the project
        When the User clicks on the Publish Button
        Then the project status is Published 
        And the Landing Page is public accessible 
        Examples:
            | Role            |
            | Curator         |
            | Project Owner   |
            | Project Manager |
