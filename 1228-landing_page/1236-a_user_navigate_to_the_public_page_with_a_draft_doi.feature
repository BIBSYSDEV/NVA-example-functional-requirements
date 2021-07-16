Feature: A user navigates to the Public Page for Publication with a Draft DOI

    @1236
    Scenario: A user navigates to the Public Page for Publication with a Draft DOI
        Given that a user navigates to the Public Page for Publication
        And the Publication is published
        And the Publication has a Draft DOI
        Then the Public Page for Publication is displayed without the Draft DOI
