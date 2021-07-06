Feature: Anonymous User searches for Registrations

    @xxx
    Scenario: Anonymous User opens search page
        Given an Anonymous User uses a browser
        When they navigate to the search page
        Then they see a input field for basic free text search
        And they see a section with advanced search parameters with filters for:
            | Institution       |
            | Registration Type |
        And they see a list of Published Registration matching the current search
        And they see each Registrations':
            | Title             |
            | Registration Type |
            | Published date    |
            | Contributors      |

    @xxx
    Scenario: Anonymous User performs a basic free text search
        Given Anonymous User opens search page
        When they enter a text in the search field
        And they press Enter
        Then they see only Published Registration where the search input is a substring of either of their:
            | Title             |
            | Abstract          |
            | Contributor names |
        And they see total number of search hits

    @xxx
    Scenario: Anonymous User filters on Institution
        Given Anonymous User opens search page
        When they click on an Institution in the advanced search section
        Then they see the Checkbox for the Institution is checked
        And they see only Published Registrations where the selected Institution is the Publisher
        And they see total number of search hits

    @xxx
    Scenario: Anonymous User filters on Registration Type
        Given Anonymous User opens search page
        When they click on an Registration Type in the advanced search section
        Then they see the Checkbox for the Registration Type is checked
        And they see only Published Registrations where the selected Type is the Registration Type
        And they see total number of search hits