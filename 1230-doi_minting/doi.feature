Feature: DOI related scenarios moved from MVP feature

  @1247
  Scenario: Creator Edits a comment on a DOI request
    Given that the Creator Opens a DOI request entry from My Worklist
    And the request has status Requested
    When they click the Edit button on a DOI request
    Then they can edit the comment
    And they see a Save button

  @1248
  Scenario: Creator Saves a comment on a DOI request
    Given that the Creator Edits a comment on a DOI request
    When they Save the comment
    Then the comment is saved
    And they see a confirmation message
    And they can no longer edit the comment

  @1250
  Scenario: Creator closes a DOI request
    Given that the Creator Opens a DOI request entry from My Worklist
    When they click the Close button
    Then they see the Worklist

  @1251
  Scenario: Creator opens a Publication with a DOI request
    Given that the Creator Opens a DOI request entry from My Worklist
    When they click the Edit publication button
    Then the Publication is opened in the Wizard on the first tab

  @1240
  Scenario: Creator deletes a DOI request
    Given that the Creator opens My Worklist
    When they click the Delete button on a DOI request
    Then the request is deleted from their Worklist
    And the request is deleted from the Worklist of their Curator
    And the Public Page for Publication has an enabled "Request DOI" button

  @511
  Scenario: Owner opens the "Request a DOI" dialog
    Given that a Creator navigates to the Public Page for Publication for published publication without DOI
    And they are the Owner of this Publication
    When they click the "Request a DOI" button
    Then the "Request a DOI dialog" is opened
    And they see fields for Message
    And they see a "Send Request" button

  @1232
  Scenario: Owner navigates to the Public Page for Publication and requests a DOI
    Given that the Creator navigates to the Public Page for Publication for published publication without DOI
    And they are the Owner of the Publication
    And open "Request a DOI" dialog
    And optional add a message to the Curator
    When the user click the Send Button
    Then the Public Page for Publication is displayed
    And the "Request a DOI" button is renamed to "DOI pending" and is disabled
    And the request is listed in User Worklist
    And the request is listed in Curator Worklist

  @1233
  Scenario: Owner navigates to the Public Page for Publication for unpublished publication without DOI
    Given that the Owner view Public Page for Publication for publication
    And the publication is not Published
    And the publication has no DOI
    When they look at the Status Bar
    Then they see buttons for Draft a DOI and Edit publication

  @1234
  Scenario: Owner drafts a DOI for an unpublished Publication
    Given that the Owner View Public Page for Publication for unpublished publication without DOI
    And they are the Owner of the Publication
    When they click the "Draft a DOI" button
    Then the Public Page for Publication is displayed
    And the "Draft a DOI" button is renamed to "DOI pending" and is disabled
    And the Draft DOI is added to the metadata
    And the Public Page for Publication contains the Draft DOI
    And the Draft DOI is not a link
  #Draft DOIs are not acknowledged by the resolving mechanisms (Handle-system)

  @1235
  Scenario: Owner navigates to the submission tab and publish a Publication with a drafted DOI
    Given that the Owner navigates to Submission tab
    And the Publication has status Draft
    And the Publication has a Draft DOI
    When the Owner clicks the publish button
    Then the Public Page for Publication is displayed
    And the "Request a DOI" button is still named "DOI pending" and is disabled
    And the Public Page for Publication lists the Draft DOI
    And the Draft DOI is still not a link
    And the DOI request is listed in the Owners work list
    And the DOI request is listed in the Curators work list

  @358
  Scenario: Curator opens a Publication from a DOI Request Worklist Item
    Given that a Curator views details of a Worklist item
    And the item is a DOI request
    When they click "Go to Publication"
    Then they see the Publication is opened in the Wizard
    And they see the Submission tab
    And they see the Create DOI button is enabled
    And they see the Decline DOI button is enabled

  @512
  Scenario: A Curator approves a DOI request
    Given that a Curator opens a Publication from a DOI Request Worklist Item
    When they click Create DOI
    Then they see the Public Page for Publication
    And the Publication has a DOI Link
    And the Request DOI item is marked as Approved in their Worklist

  @1243
  Scenario: A Curator enter a decline-comment on a DOI request
    Given that a Curator opens an item in the Worklist
    And the item is a DOI request
    When they click Decline DOI
    Then they may enter a decline-comment

  @1244
  Scenario: A Curator declines a DOI request
    Given that a Curator enters a decline comment on a DOI request
    When they click Save
    Then the DOI request is marked as "Declined"
    And the request in the User's Worklist is updated to "Declined"
    And the request is removed from the Curator's Worklist
    And they see their Worklist
