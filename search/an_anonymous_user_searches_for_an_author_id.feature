    Scenario: An Anonymous User searches for an author ID
        Given that an Anonymous User is on the start page
        And they know an Author ID
        And there are ten Publications with that Author ID
        When the user searches for the Author ID
        And clicks Search
        Then the user sees ten Hits for the author ID displayed in the search display
        And each hit contains information about the title, author, year, and publication type