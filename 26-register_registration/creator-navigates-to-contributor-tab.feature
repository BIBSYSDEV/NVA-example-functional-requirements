Feature: Creator navigates to Contributors tab

  @417
  Scenario: Creator navigates to Contributors tab
    Given Creator begins registering a Registration in the Wizard
    When they navigate to the Contributors tab
    Then they see "Add Author" Button is enabled
    And they see the tab Description is clickable
    And they see the tab Resource Type is clickable
    And they see the tab Contributors is selected
    And they see the tab Files and License is clickable
    And they see Previous is enabled
    And they see Next is enabled
    And they see Save is enabled

  @1837
  Scenario: Creator adds themselves to the list of Authors
    Given Creator begins registering a Registration in the Wizard
    When they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they click "Add Author"
    And they see the Author Search Dialog
    And they click "Add me as Author"
    Then their Author identity is added to the list of Authors

  @419
  Scenario: Creator adds an Author to the list of Authors
    Given Creator begins registering a Registration in the Wizard
    When they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they click "Add Author"
    And they search for Author in the Author Search Dialog
    And they select an Author identity
    And they click "Add"
    Then the selected Author identity is added to the list of Authors

  Scenario: Creator adds an Author to the list of Authors for Reference Type Book, Monograph
    Given Creator begins registering a Registration in the Wizard
    And they navigate to the References tab
    And they select Reference Type "Book"
    And they select Registration Subtype "Monograph"
    When they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they click "Add Author"
    And they search for Author in the Author Search Dialog
    And they select an Author identity
    And they click "Add"
    Then the selected Author identity is added to the list of Authors

  Scenario: Creator adds an Author to the list of Authors for Reference Type Chapter
    Given Creator begins registering a Registration in the Wizard
    And they navigate to the References tab
    And they select the Reference Type "Part of book/report"
    And they select the Registration Subtype "Chapter in anthology"
    When they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they click "Add Author"
    And they search for Author in the Author Search Dialog
    And they select an Author identity
    And they click "Add"
    Then the selected Author identity is added to the list of Authors

  @2203
  Scenario: Creator adds an Editor to the list of Editors for Reference Type Book, Anthology
    Given Creator begins registering a Registration in the Wizard
    And they navigate to the References tab
    And they select Reference Type "Book"
    And they select Registration Subtype "Anthology"
    When they navigate to the Contributors tab
    And they see the "Add Editor" Button
    And they click "Add Editor"
    And they search for Editor in the Author Search Dialog
    And they select an Author identity
    And they click "Add"
    Then the selected Author identity is added to the list of Editors

  @2204
  Scenario: Creator adds a Supervisor to the list of Supervisors for Reference Type Student Thesis
    Given Creator begins registering a Registration in the Wizard
    And they navigate to the References tab
    And they select Reference Type "Student Thesis"
    And they select any Registration Subtype
    When they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they see the "Add Supervisor" Button
    And they click "Add Supervisor"
    And they search for Supervisor in the Author Search Dialog
    And they select an Author identity
    And they click "Add"
    Then the selected Author identity is added to the list of Supervisors

  @788
  Scenario: Creator creates a new Author in the Author dialog
    Given Creator begins registering a Registration in the Wizard
    And they navigate to the Contributors tab
    And they see the "Add Author" Button
    And they click "Add Author"
    And they see the "Create new Author" Button
    When they click "Create new Author"
    Then they see fields:
      | First name |
      | Last name  |
    And they see the "Create new Author" Button