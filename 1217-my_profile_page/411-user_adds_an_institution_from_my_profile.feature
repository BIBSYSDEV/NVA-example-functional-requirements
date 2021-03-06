Feature: User adds an Institution from My Profile

    @test
    @411
    Scenario: User adds an Institution from My Profile
        Given User opens Add Institution from My Profile
        When they enter an Institution name
        And they select an Institution
        And they see a button Add that is enabled for the new Institution
        And they see a button Cancel that is enabled for the new Institution
        And they click Add
        Then they see the new Institution in My Profile
        And they see a button Remove that is enabled for the new Institution
