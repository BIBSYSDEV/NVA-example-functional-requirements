Feature: User logs in

  @test
  @217
  Scenario: User without their Feide ID in ARP logs in
    Given that the user logs in with their Feide ID
    And they do not have their Feide ID in any ARP entry
    Then they see a list containing "Name", "Last registration" and "Institutions" for each ARP entry matching their name
    And they see a Create New Author Button
    And they see a Support button

  @test
  @1206
  Scenario: User with their Feide ID in ARP logs in
    Given that the user logs in with their Feide ID
    And their Feide ID is in an ARP entry
    Then they can see their name in the menu

  @test
  @384
  Scenario: User creates a new Author identity
    Given that the user logs in with their Feide ID
    And they do not have their Feide ID in any ARP entry
    Then they see proposed name for a new Author identity based on data from their Feide account
    When they click Create Author identity button
    Then this new Author identity is added to ARP
    And their Feide ID is added to their Author identity
    And their Organization ID (Cristin ID) is added to their Author identity
    And they can see confirmation message that they have connected an Author identity

  @test
  @219
  Scenario: User updates an Author identity
    Given that the user logs in with their Feide ID
    And they do not have their Feide ID in any ARP entry
    And they see a list containing "Name", "Last registration" and "Institutions" for each ARP entry matching their name
    When they select an Author identity
    And they click Connect Author identity
    Then their Feide ID is added to their Author identity
    And their Organization ID (Cristin ID) is added to their Author identity
    And they can see confirmation message that they have connected an Author identity

  @test
  @222
  Scenario: User adds an ORCID to their Author identity
    Given that the user has just connected to an Author identity
    And they can see confirmation message that they have connected an Author identity
    And their Author identity do not have any connection to ORCID
    When they click the Next button
    Then they see a dialog for connecting ORCID
    When they click Create or add ORCID
    And they are redirected to ORCID for login
    And they log into ORCID
    And they accept that NVA uses their data
    Then they are redirected back to NVA
    And their ORCID is added to their Author identity
    And they see their ORCID on My Profile

      @351
  Scenario: A user logs in with Feide for the first time
    Given that the user has valid Feide credentials
    And they have NOT logged in with Feide before
    And they are on the Start page
    When they click Log in
    And they are redirected to Feide
    And they enter their Feide credentials
    And they approve sharing of data with the NVA application regarding
      | Username            |
      | Email address       |
      | Real name           |
      | Affiliation         |
      | Organization number |
    Then they are redirected back to the Start page
    And they see their name in the Menu
    And they see the Connect Author dialog

  @1205
  Scenario: User connects Author
    Given that the user logs in with Feide for the first time
    When they click OK in the Connect Author dialog
    Then the Connect Author dialog closes
    And they see a confirmation dialog

  @28
  Scenario: A user is already authenticated with Feide (single sign on)
    Given that the user is already authenticated with Feide
    When they navigate to the Start page
    And they click Log in
    And they are redirected to Feide
    And they click on the identity they wish to proceed with in the Feide interface
    Then they are redirected back to the Start page
    And they see their name in the Menu

  @353
  Scenario: A user logs out
    Given that the user is already logged in
    When they click on the Menu
    And they click Log out
    Then they are logged out of the NVA application

  @1207
  Scenario: User has no matching Author identity
    Given that Sandy Jones has a valid Feide ID and password
    And they do not have a Feide ID in their ARP entry
    And there are no matching entries in ARP
    When they log in
    Then they see the Create Authority dialog
    And that their name is selected

  @646
  Scenario: Creator creates own Author identity
    Given that Sandy Jones has a valid Feide ID and password
    And there are results for Sandy Jones in ARP
    And they do not identify with one of the results
    When they click the Create New Author Button
    Then they see the Create New Authority dialog
    And that their name is selected
