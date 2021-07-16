Feature: Curator searches in My Worklist

    Background: 
        Given Curator is loged in
        And Curator opens My Worklist from main menu
        And My Worklist contains Requests of all four types

    @2795
    @updated
    Scenario: Curator search in Requests from My Worklist
        When Curator execute a search in the search field
        Then Curator see "<RequestStatus>" listed as "<Status>" Checkboxes
        And the tabs has numbers of search results corresponding to the Checked "<Message Status>" and Institution scope:
            | For Approval    |
            | Support         |
            | DOI request     |
            | Change ownersip |
        And they see the previous selected tab
        Examples:
            | RequestStatus | Status    |
            | New           | Checked   |
            | Active        | Checked   |
            | Done          | Unchecked |
            | Denied        | Unchecked |
            | Archived      | Unchecked |
            | Deleted       | Unchecked |