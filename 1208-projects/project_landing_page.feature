Feature: Project Landing Page

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

    #WIP
    Scenario: User clicks the Delete Button for a Project
        Given User opens My Projects
        When they click the Delete Button for a Project where they are Manager
        Then they see a Confirm Dialog

    #WIP
    @xxx
    Scenario: User deletes a Project
        Given User clicks the Delete Button for a Project
        When they Confirm the action
        Then the Confirm Dialog is closed
        And The actual Project is removed from the Projects list

