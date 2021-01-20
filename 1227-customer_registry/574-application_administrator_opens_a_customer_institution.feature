Feature: Application Administrator opens a Customer Institution

    @574
    Scenario: Application Administrator opens a Customer Institution
        Given that the user is logged in as Application Administrator
        When they open a Customer Institution
        Then they see fields:
            | Name in organization registry |
            | Display name                  |
            | Short display name            |
            | Archive name                  |
            | Feide Organization ID         |
            | ROR ID                        |
        And they see the Save button
        And they see the list of current Institution Administrators
        And every Institution Administrator has a Remove button
        And they see button to add a new Institution Administrator
