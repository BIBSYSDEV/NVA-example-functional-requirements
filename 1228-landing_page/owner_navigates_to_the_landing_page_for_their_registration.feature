Feature: Owner navigates to the Landing Page for their Registration

    @test
    @1231
    Scenario: Owner navigates to the Landing Page for their Published Registration without DOI
        Given that the Creator navigates to the Landing Page for a Registration
        And they are the Owner of the Registration
        And the Registration has no DOI
        When they see the Status Bar
        Then they see buttons for "Request a DOI" and "Edit Registration"

    @needJiraTag
    @implemented
    Scenario: Owner wish to publish Registration
        When the Owner preview the Registration's Langing Page
        And the Registraion has a "Draft" Status
        Then they see a "Publish" option

    @needJiraTag
    Scenario: Owner wish to publish their Registration, pending Approval
        When the Owner preview the Registration's Langing Page
        And the Registraion has a "Draft" Status
        And there is a pending Approval Request on the Registration
        Then they see a "Publishing pending" information
        And the user is informed that progress can be viwed in My Messages 

    @needJiraTag
    Scenario Outline: Owner wish to publish Registration, all restrictions
        Given Owner wish to publish their Registration
        And Registration is of type "<ResourceType>" 
        And Editor has restricted publication of type "<ResourceType>" 
        When the Owner uses the Publish option
        Then an Approval Request is created
        And the User is informed that a Publishing Approval is pending and progress can be viwed in My Messages
        Examples:
            | ResourceType |
            | NVI          |
            | none-NVI     |

    @needJiraTag
    Scenario Outline: Owner wish to publish Registration, file restrictions
        Given Owner wish to publish their Registration
        And Registration is of type "<ResourceType>" 
        And the Editor has restricted access to files of Registrations of "<ResourceType>"
        When the Owner uses the Publish option
        Then an extra embargo is put on all files
        And the Resource's status is "Published"
        And the Landing Page is public accessable
        And an Approval Request is created
        And the User is informed that the Resource is published but a Publishing Approval is pending to allow access to the files and progress can be viwed in My Messages
        Examples:
        Examples:
            | ResourceType |
            | NVI          |
            | none-NVI     |

    @needJiraTag
    Scenario: Owner use the Publish option on Langing Page
        Given Owner wish to publish their Registration
        And the Editor has allowed free publishing
        When the Owner uses the Publish option
        Then the Resource's status is "Published"
        And the Landing Page is public accessable

    @test
    Scenario: Owner navigates to the Landing Page for their Registration with Validation Errors
        Given that the Creator navigates to the Landing Page for a Registration
        And they are the Owner of the Registration
        And the Registration has Validation Errors
        When they see the Landing Page for the Registration
        Then they see a List of all Validation Errors for the Registration
        And they see a "Go back to schema" button
