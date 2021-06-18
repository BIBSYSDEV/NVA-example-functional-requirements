Feature: Curator search in meassages from My Worklist

    @2795
    Scenario: Curator search in meassages from My Worklist
        Given Curator opens My Worklist
        When they execute a search in the search field
        Then they see <MessageStatus> listed as <CheckboxStatus> Checkboxes
        And they see the tabs with numbers of search results corresponding to the Checked <Message Status> and Institution scope:
            | For Approval    |
            | Support         |
            | DOI request     |
            | Change ownersip |
        And they see the previous selected tab
        Examples:
            | Message Status | CheckboxStatus |
            | New            | Checked        |
            | Active         | Checked        |
            | Done           | Unchecked      |
            | Denied         | Unchecked      |
            | Archived       | Unchecked      |
            | Deleted        | Unchecked      |
