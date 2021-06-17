Feature: Curator opens My Worklist

    @357
    Scenario: Curator opens My Worklist
        Given that the user is logged in as Curator
        When they click the menu item My Worklist
        Then they see My Worklist page
        And they see their designated Institution scope
        And they see a search field
        And they see the tabs:
            | For Approval    |
            | Support         |
            | DOI request     |
            | Change ownersip |
        And they see the For Approval page

    @1353
    Scenario: Curator views For Approval tab
        Given that the Curator opens My Worklist
        When they click the tab "For Approval"
        Then they see a list of Worklist Items with fields:
            | Request status     |
            | Registration title |
            | Submitter name     |
            | Date               |
        And they see that each Worklist Item has an Expand button

    @1354
    Scenario: Curator views Support tab
        Given that the Curator opens My Worklist
        When they click the tab "Support"
        Then they see a list of Worklist Items with fields:
            | Request status     |
            | Registration title |
            | Submitter name     |
            | Date               |
        And the see that each Worklist Item has an Expand button

    @531
    Scenario: Curator views DOI Request tab
        Given that the Curator opens My Worklist
        When they click the tab "DOI request"
        Then they see a list of Worklist Items with fields:
            | Request status     |
            | Registration title |
            | Submitter name     |
            | Date               |
        And the see that each Worklist Item has an Expand button

    @2756
    Scenario: Curator views Change Ownership tab
        Given that the Curator opens My Worklist
        When they click the tab "Change ownership"
        Then they see a list of Worklist Items with fields:
            | Request status     |
            | Registration title |
            | Submitter name     |
            | Date               |
        And the see that each Worklist Item has an Expand button

    @1252
    Scenario: Curator views details of a Worklist item
        Given that a Curator views DOI request tab
        When they expand the item
        Then they see the item is expanded
        And they see the Title of the Publication
        And they see the DOI request status
        And they see a list of Messages with fields:
            | Message   |
            | Submitter |
            | Date      |
        And they see an input field for Answer
        And they see buttons
            | Send answer       |
            | Go to publication |
            | Archive           |