    @531
    Scenario: Curator views DOI Request tab (Part I)
        Given that the Curator opens My Worklist (Part I)
        When they click the tab:
            | DOI request |
        Then they see a list with expandable items with fields:
            | DOI Request Status |
            | Publication Title  |
            | Submitter          |
            | Date               |
        And they see that each row in the list has an Expand button