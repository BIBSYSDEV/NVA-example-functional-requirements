# encoding: utf-8
# language: en

Feature: MVP features for NVA

  Scenario: A user logs in with Feide for the first time
    Given that the user is on the Start page
    When they click Log in
    And they are redirected to Feide
    And they enter their valid Feide credentials
    And they approve sharing of data with the NVA application regarding
      | Username            |
      | Email address       |
      | Real name           |
      | Affiliation         |
      | Organization number |
    Then they are redirected back to the Start page
    And they see their name in the Menu
    And they see the Connect Author dialog

  Scenario: A user logs in with Feide not for the first time
    Given that the user is on the Start page
    When they click Log in
    And they are redirected to Feide
    And they enter their valid Feide credentials
    Then they are redirected back to the Start page
    And they see their name in the Menu
    And they see the Connect ORCID dialog

  Scenario: A user is already authenticated with Feide (single sign on)
    Given that the user is already authenticated with Feide
    When they navigate to the Start page
    And they click Log in
    And they are redirected to Feide
    And they click on the identity they wish to proceed with in the Feide interface
    Then they are redirected back to the Start page
    And they see their name in the Menu

  Scenario: A user logs out
    Given that the user is already logged in
    When they click on the Menu
    And they click Log out
    Then they are logged out of the NVA application

  @217
  Scenario Outline: User with no Feide ID in ARP sees matching Author identities
    Given that Kim Smith has a valid Feide ID and password
    And they do not have a Feide ID in their ARP entry
    And there are entries in ARP
      | Smith, Kim (died 2019) |
      | Smith, Kim F.          |
      | Smith, Kim             |
    When they log in
    Then they see a list containing <Author name> and <Last publication> for each ARP entry matching their <Name>
    Examples:
      | Name      | Author name   | Last publication  |
      | Kim Smith | Smith, Kim    | Some Title        |
      | Kim Smith | Smith, Kim    | Some Other Title  |
      | Kim Smith | Smith, Kim F. | Yet Another Title |


  Scenario: User has no matching Author identity
    Given that Sandy Jones has a valid Feide ID and password
    And they do not have a Feide ID in their ARP entry
    And there are no matching entries in ARP
    When they log in
    Then they see the Create Authority dialog
    And that their name is selected

  @219
  Scenario: User updates an Author identity
    Given that a user with no Feide ID in ARP sees matching Author identities
    When they select an Author identity
    And they click Connect Author identity
    Then their Feide ID is added to their Author identity
    And their Feide organization number is mapped to an Organizational ID (Cristin ID)
    And their Organizational ID (Cristin ID) is added to their Author identity
    And they see a notification that confirms the connection
    And they are redirected to the ORCID dialog
  # This last step hides cases where an ORCID already exists in ARP
  # There should also be a possibility to ask for support if there is a problem in the data, i.e. there are multiple registered Author identities for a single Author

  @384
  Scenario: User creates an Author identity
    Given that a user has no matching Author identity
    When they click Create Author identity
    Then their identity is added to ARP
    And their Feide ID is added to their Author identity
    And their Feide organization number is mapped to an Organizational ID (Cristin ID)
    And their Organizational ID (Cristin ID) is added to their Author identity
    And they are redirected to the ORCID dialog

  @222
  Scenario: User attempts to add an ORCID to their Author identity
    Given that the user:
      | User updates an Author identity |
      | User creates an Author identity |
    When they click Add ORCID
    And they are redirected to ORCID for login
    And they log into ORCID
    And they accept that NVA uses their data
    Then they are redirected back to NVA
    And their ORCID is added to their Author identity
    And they see their ORCID on their Profile page

  @226
  Scenario: User begins registering a Publication
    Given that the user is logged in
    And they are on the Start page
    When they click Register new publication
    Then they are redirected to the Register new publication page
    And they see an Expansion panel for Upload file
    And they see an Expansion panel for Link to publication
    And they see an Expansion panel for Suggestions from ORCID

  @228
  Scenario: User begins registering with a Link with direct data from Datacite/Crossref
    Given that the user begins registering a Publication
    When they expand Link to publication
    And enter a DOI or a fully qualified DOI URL
    And click Search
    Then they see metadata about the Link in the Expansion panel

  @439
  Scenario: User begins registering with a Link with data from Datacite/Crossref from citation_doi meta tag (DOI)
    Given that the user begins registering a Publication
    When they expand Link to publication
    And they enter https://dlr.unit.no/resources/66888570-3504-4d12-81a4-c3ffe0605945
    And click Search
    Then they see metadata about the Link in the Expansion panel

  #DLR does not have a meta tag with a DOI

  @440
  Scenario: User begins registering with a Link with data from Datacite/Crossref from dc:identifier meta tag
    Given that the user begins registering a Publication
    When they expand Link to publication
    And they enter https://loar.kb.dk/handle/1902/1674?show=full
    And click Search
    Then they see metadata about the Link in the Expansion panel

  @441
  Scenario: User begins registering with a Link with data from DC and DCTERMS meta tags
    Given that the user begins registering a Publication
    When they expand Link to publication
    And they enter a https://ntnuopen.ntnu.no/ntnu-xmlui/handle/11250/2638973
    And click Search
    Then they see metadata about the Link in the Expansion panel

  @442
  Scenario: User begins registering with a Link with data from Open Graph tag
    Given that the user begins registering a Publication
    When they expand Link to publication
    And they enter https://www.nrk.no/norge/klimakur-2030_-mer-strom-og-mindre-kjott-kan-fa-norge-i-mal-1.14883788
    And click Search
    Then they see metadata about the Link in the Expansion panel

  @443
  Scenario Outline: User starts registering a Publication
    Given that the user begins registering a Publication
    And they have selected one of the <Methods> for starting the Wizard
    When they click Start
    Then the Wizard is started
    Examples:
      | Methods                |
      | Link to publication    |
      | Upload file            |
      | Suggestions from ORCID |

  @452
  Scenario: User starts Wizard registration and navigates to Description tab
    Given that the user starts registering a Publication
    When they navigate to the Description tab
    Then they see the tab Description is selected
    And they see mandatory fields for
      | Title |
    And optional fields for
      | Alternative title(s)         |
      | Abstract                     |
      | Alternative abstract(s)      |
      | Description                  |
      | Date published               |
      | NPI disciplines              |
      | Keywords                     |
      | Primary language for content |
      | Project association          |
    And they see the tab Reference is clickable
    And they see the tab Contributor is clickable
    And they see the tab Files and Licenses is clickable
    And they see the tab Submission is clickable
    And they see Next is enabled
    And they see Save is enabled

  @453
  Scenario: User navigates to the Reference tab
    Given that the user starts registering a Publication
    When they navigate to the Reference tab
    Then they see the mandatory field for Type
    And they see the tab Description is clickable
    And they see the tab Reference is selected
    And they see the tab Contributor is clickable
    And they see the tab Files and Licenses is clickable
    And they see the tab Submission is clickable
    And they see Next is enabled
    And they see Save is enabled

  @274
  Scenario: User navigates to the Reference tab and selects Publication in Journal
    Given that the user navigates to the Reference tab
    When they select a Reference Type — Publication in Journal
    And they can select a Publication Subtype from the list
      | Article              |
      | Short communication  |
      | Leader               |
      | Letter to the editor |
      | Review               |
    Then they see the Search box for "Journal title" #this needs to be tested for mandatory-ness
    And they see fields for
      | DOI            |
      | Volume         |
      | Issue          |
      | Pages from     |
      | Pages to       |
      | Article number |
    And they see a preselected value for Peer review "Not peer reviewed" #also mandatory
    And they see the NVI evaluation is Not NVI Applicable

  @392
  Scenario: User navigates to the Reference tab and selects Book
    Given that the user navigates to the Reference tab
    When they select a Reference Type — Book
    And they select a Publication Subtype from the list
      | Monograph  |
      | Anthology  |
    Then they see Search box for "Publisher name" #this needs to be tested for mandatory-ness
    And they see a checkbox for "Is this a textbook?"
    And they see fields for
      | ISBN                  |
      | Total number of pages |
    And they see Search box for "Title of the Series"
    And they see a preselected value for Peer review "Not peer reviewed" #also mandatory
    And they see the NVI evaluation is Not NVI Applicable

  @393
  Scenario: User navigates to the Reference tab and selects Report
    Given that the user navigates to the Reference tab
    When they select a Reference Type — Report
    And they select a Publication Subtype from the list
      | Report          |
      | Research report |
      | Policy report   |
      | Working paper   |
    Then they see Search box for "Publisher name"
    And they see fields for
      | ISBN                  |
      | Total number of pages |
    And they see Search box for "Title of the Series"

  @394
  Scenario: User navigates to the Reference tab and selects Degree
    Given that the user navigates to the Reference tab
    When they select a Reference Type — Degree
    And they select a Publication Subtype from the list
      | Bachelor  |
      | Master    |
      | Doctorate |
    Then they see Search box for "Publisher name"
    And they see Search box for "Title of the Series"

  @395
  Scenario: User navigates to the Reference tab and selects Chapter
    Given that the user navigates to the Reference tab
    When they select a Reference Type — Chapter
    Then they see an Information box with text "Before you register the chapter, register the book so you can look it up"
    And they see field "Link to publication"
    And they see Search box for "Published in"
    And they see a preselected value for Peer review "Not peer reviewed" #also mandatory
    And they see field for Page number from
    And they see field for Page number to
    And they see Search box "Series title"
    And they see the NVI evaluation is Not NVI Applicable

  @417
  Scenario: User navigates to the Contributor tab
    Given that the user starts registering a Publication
    When they navigate to the Contributor tab
    Then they see Add Author is enabled
    And they see the tab Description is clickable
    And they see the tab Reference is clickable
    And they see the tab Contributor is selected
    And they see the tab Files and Licenses is clickable
    And they see the tab Submission is clickable
    And they see Next is enabled
    And they see Save is enabled

  @275
  Scenario: User navigates to the Files and Licenses tab
    Given that the user starts registering a Publication
    When they navigate to the Files and Licenses tab
    Then they see information about the Open Access Status for the Journal which they selected on the Reference page based in information from the Norwegian Register
    And they see the Sherpa Romeo data for the Journal which they selected on the Reference page based in information from the Norwegian Register
    And they see that the journal allows publication of the article with the license CCBY 4.0 based in information from the Norwegian Register
    And they can upload files for the Publication
    And they see the tab Description is clickable
    And they see the tab Reference is clickable
    And they see the tab Contributor is clickable
    And they see the tab Files and Licenses is selected
    And they see the tab Submission is clickable
    And they see Next is enabled
    And they see Save is enabled

  @277
  Scenario: User navigates to the Submission tab
    Given that the user starts registering a Publication
    When they navigate to the Submission tab
    Then they see all of the data they have entered including mandatory fields
      | Title                   |
      | Resource (file or link) |
      | License                 |
    And they see the tab Description is clickable
    And they see the tab Reference is clickable
    And they see the tab Contributor is clickable
    And they see the tab Files and Licenses is clickable
    And they see the tab Submission is selected
    And they see Next is enabled
    And they see Save is enabled
    And they see Publish is enabled

  @385
  Scenario: User begins registration by uploading a file
    Given that the user begins registering a Publication
    When they click Upload file
    And they upload a file
    Then they see the filesize and checksum
    And Delete file is enabled
    And Start is enabled

  #Scenario: User start Wizard registration by uploading a file
  #  Given that the user begins registration by uploading a file
  #  When they click Start
  #  Then they see the tab Description

  @386
  Scenario: User begins registration by using suggestions from ORCID
    Given that the user begins registering a Publication
    When they click Suggestions from ORCID
    Then they see a list of last publications from ORCID API assosiated with the users ORCID ID
    And each list entry contains metadata for:
      | Title         |
      | Year          |
      | Journal title |
      | DOI           |
    And that each entry is selectable

  #Scenario: User start Wizard registration by using suggestions from ORCID
  #  Given that the user begins registration by using suggestions from ORCID
  #  When they click Start
  #  Then they see the tab Description

  @388
  Scenario Outline: User sees a Publication based on a Link
    Given that the user begins registering with a Link
    And they see that the title <Metadata> for the Link is correct
    When they click Start
    And they click My Publications
    Then they see the Publication is saved and the title is listed and marked as Draft
    Examples:
      | Metadata |
      | Title    |
  #| First three authors |
  #| Publication date    |

  @391
  Scenario: User sees publication for a registration based on uploading a file
    Given User begins registration by uploading a file
    And they see that filesize and checksum
    When they click Start
    And they click My Publications
    Then they see the Publication is saved and the title is listed (filename) and marked as Draft

  @432
  Scenario: User verifies file upload for a registration based on uploading a file
    Given User sees publication for a Publication based on uploading a file
    When they open the item in the Wizard
    And they select the tab Files and Licenses
    Then the files are available for download

  @229
  Scenario: User verifies initial metadata on the Description tab for a registration
    Given that the user starts Wizard registration with a Link
    When they see the Description tab
    Then they see that the Description tab is populated with metadata for
      | Title                        |
      | Alternative title(s)         |
      | Abstract                     |
      | Alternative abstract(s)      |
      | Description                  |
      | Date published               |
      | Primary language for content |

  # Dette er av typen "Publication in Journal"
  Scenario: User verifies initial metadata on the Reference tab for a registration
    Given that the user starts Wizard registration with a Link
    Then they they see that the Reference tab is populated with metadata values for
      | Publication type                              |
      | Link (the link that was provided by the user) |
      | The unmapped text for Journal                 |
      | Volume                                        |
      | Issue                                         |
      | Page from                                     |
      | Page to                                       |
      | Article number                                |
      | Peer review                                   |

  Scenario Outline: User verifies initial metadata on the Contributors tab for a registration
    Given that the user starts Wizard registration with a Link
    Then they see that the Contributors tab Authors section is populated with metadata values for <Author> and <Institution>
    And they see that the Contributors tab Contributors section is populated with metadata values for <Contribution Type>, <Name> and <Institution>
    Examples:
      | Author       | Institution |
      | Name Nameson | NTNU        |
      | Jan Jansson  | MTNU        |

    Examples:
      | Contribution Type | Name        | Institution |
      | Photographer      | Jim Jimsson | AVH         |

  Scenario: User verifies initial metadata on the Files and Licenses tab for a registration
    Given that the user starts Wizard registration with a Link
    Then they see that the Files and Licenses tab is prepopulated with metadata values for
      | Possible mapped value for License, Archiving policy and Unit agreement |
      | Possible file for upload  (Filename, File size)                        |

  # SLETT?
  @236
  Scenario: User verifies Contributor information
    Given that the user registers initial metadata for a Publication based on a Link
    And they have clicked Next
    When they review the information for Contributors
    Then they see that the Contributors are grouped in sections Authors and Other Contributors
    And they see that the Authors are verified in ARP
    And they see that the Authors are in the expected order
    And they see that the Authors have the expected institutional affiliations
    And they see that the correct authors have the expected value for Corresponding Author
    And they see that the Other Contributors are listed alphabetically by Surname
    And they see that the Other Contributors have the correct Role, Name and Institution

  @230
  Scenario: User adds NPI data for a Publication
    Given that the user starts registering a Publication
    When they select a value in the dropdown for NPI subject area
    Then this is added to the metadata for the Publication
    And the NPI subject area is listed in the Submission

  @231
  Scenario: User views Projects Widget
    Given that the user starts registering a Publication
    When they click the Projects search box
    Then they see a list of up to ten most recent active projects in NVA associated with their ID
    And an empty search box

  @444
  Scenario: User selects prepopulated Project from initial dropdown
    Given that the user views Project Widget
    When they click a project in the Widget
    Then the Project ID is added to the Publication metadata
    And the user can add another Project

  @445
  Scenario: User searches for a Project
    Given that the user views Project Widget
    When they write a project name in the search box
    Then they see a list of results based on free text search for Project title in the Projects API

  @446
  Scenario: User selects Project from dropdown
    Given that the user searches for a Project
    When they click a project in the Widget
    Then the Project ID is added to the Publication metadata
    And the user can add another Project

  @233
  Scenario: User verifies Norwegian Registry information for a Publication based on a Link
    Given that the user registers initial metadata for a Publication based on a Link
    And the Publication is a Publication in Journal
    And the Journal for the Publication is found in the Norwegian Register
    When they verify the information from the Norwegian Register that appears in the Journal Metadata
    Then they see that the information for Journal Title is correct
    And they see that the information for Print ISSN is correct
    And they see that the information for Online ISSN is correct
    And they see that the information for Academic Level is correct

  # Happy day scenario for a DOI-sourced Academic Publication
  # The DOI dereferences to a data document that contains ORCIDs for every Contributor
  # The DOI dereferences to a data document that contains a Grant ID
  # The Grant ID is available in Cristin Project DB
  # Cristin Project DB data document contains the ORCIDs for project members
  # There is a match between all ORCIDs from the DOI data document and (a subset of) the Cristin Project DB Project data document ORCIDs
  # All of the ORCIDs are in ARP

  @418
  Scenario: User opens the add Author dialog
    Given that the user navigates to Contributor tab
    When they click Add Author
    Then the dialog to add an Author is opened
    And the dialog contains fields for
      | Author search |
    And a button to close the dialog

  @419
  Scenario: User adds an Author to the Author list
    Given that the user opens the add Author dialog
    And enters a Name in the Author search box
    And see search results for the Author search containing the last publication
    And see the Institution from ARP
    When they click Add Author
    Then the dialog is closed
    And the Author is shown in the Author table in the Contributor tab

  # Tegn delete og fullfør beskrivelse
  @
  Scenario: User creates a new Author in the Author dialog
    Given that the user opens the add Author dialog
    And they click the link to create a new Author
    And enters a Name in the Author name box
    And enter Institution details
    When they click Add Author
    Then the dialog is closed
    And the Author is shown in the Author table in the Contributor tab

  #Legg til Scenario for delete, edit, move, korresponding

  @
  Scenario: User registers Corresponding Author
    Given that the user registers initial metadata for a Publication based on a Link
    And they have clicked Next
    When they review the information for Contributors
    Then they see that the Contributors are grouped in sections Authors and Other Contributors
    And they set the correct values for Corresponding Author
    And they see that the Other Contributors are listed alphabetically by Surname
    And they see that the Other Contributors have the correct Role, Name and Institution

  # Corresponding Author is not in fact present in the Datacite data, but probably will be soon

  # Important note about the "License": This assumes that the article is published in a journal that has a special Unit
  # agreement, which entails that Unit has negotiated a contract for Norwegian corresponding authors
  # In all other cases, a License-picker is provided

  @276
  Scenario: User uploads files for the Publication
    Given that the user navigates to Files and Licenses
    When they drag and drop a file into the File drag-and-drop area
    Then they see that the files are uploaded
    And for each file they see the file receipt and settings

  @454
  Scenario: User views file receipt and settings the Publication
    Given that the user uploads files for the Publication
    When the view each file
    Then they see that the files are uploaded
    And for each file they see the file receipt and file settings
    And they see the original filename
    And they see the filesize
    And they see the checksum for the uploaded file
    And see mandatory radio Select version with values
      | Accepted version  |
      | Published version |
    And see mandatory dropdown for License with values
      | CC-BY 4.0 |
    And optional fields for
      | Postponed publication |
    And optional checkbox for Administrative contract
    And a Preview button
    And a Remove button

  Scenario Outline: User select values for uploaded files
    Given that the user uploads files for the Publication
    When set values for the <Field>
    And they navigate to the Submission Page
    And they look at the Files section
    Then they see the <Value> for the <Field>
    Examples:
      | Field               | Value                 |
      | Filename            | original-filename.pdf |
      | Filesize            | 128k                  |
      | Version             | Accepted version      |
      | License             | CC-BY 4.0             |
      | Delayed Publication | 2032-12-21            |

  @455
  Scenario: User selects Administrative contract for uploaded files
    Given that the user uploads files for the Publication
    When the user selects Administrative contract
    Then they see the original filename
    And they see the filesize
    And they see the checksum for the uploaded file
    And optional checkbox for Administrative contract
    And a Preview button
    And a Remove button

  @278
  Scenario: User publishes Publication
    Given that the user views Submission
    When they click Publish
    Then they see the Public page containing all data and files
    And they see the Publication is Published

  # Access to the different menu items
  @244
  Scenario: User sees non-logged-in menu
    Given that the user is not logged in
    When they look at any page in NVA
    Then they see a menu containing
      | Logg inn |

  @345
  Scenario: User sees a menu when logged in
    Given that the user is logged in (and has no NVA role)
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile |
      | Log Out    |

  @346
  Scenario: User sees the menu for Creator
    Given that the user is logged in
    And has the role of Creator
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile       |
      | Log Out          |
      | New Registration |
      | My Publications  |
      | My Messages      |

  @347
  Scenario: User sees the menu for Curator
    Given that the user is logged in
    And has the role of Curator
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile  |
      | Log Out     |
      | My Worklist |

  @348
  Scenario: User sees the menu for Administrator
    Given that the user is logged in
    And has the role of Administrator
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile          |
      | Log Out             |
      | User administration |
      | My Institution      |

  @349
  Scenario: User sees the menu for Editor
    Given that the user is logged in
    And has the role of Editor
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile            |
      | Log Out               |
      | Editor administration |

  @350
  Scenario: User sees the menu for Application administrator
    Given that the user is logged in
    And has the role of Application administrator
    When they look at any page in NVA
    Then they see a menu containing
      | My Profile   |
      | Log Out      |
      | Institutions |

  # Description of each menu item

  # Menu items for anonymous
  @351
  Scenario: User opens login page
    Given that the user is not logged in
    When they click the menu item Logg inn
    Then the page for login with Feide is opened

  # Menu items for logged in person
  @352
  Scenario: User opens the page My Profile
    Given that the user is logged in
    When they click the menu item My Profile
    Then the page My Profile is opened
    And see their Profile page which includes information for
      | Real name          |
      | Feide ID           |
      | Email              |
      | ORCID              |
      | Role(s)            |
      | Institution        |
      | Contact info       |
      | Preferred language |

  @406
  Scenario: User views a list of subunits at their Institution on My Profile
    Given user opens My Profile
    When they click Change Institution
    Then the user sees the Change Institution window
    And their Institution from ARP is selected
    And a dropdown with the units connected to the Institution is shown
    And a Change button is available

  @407
  Scenario: User adds a subunit to their Institution from My Profile
    Given user views a list of subunits to their Institution from My Profile
    When the user selects a subunit
    And saves the changes
    Then the changes are saved to ARP
    And the changes are shown in My Profile

  @409
  Scenario: User views all subunits at their Institution on My Profile
    Given that the user views a list of subunits at their Institution on My Profile
    When the users selects a subunit
    Then they see a dropdown with subunits
    And they see a new subunit dropdown until there are no more subunit levels

  @410
  Scenario: User opens Add Institution from My Profile
    Given user opens the page My Profile
    When they click Add (Institution)
    Then the Add Institution window is opened
    And the user can search for Institutions

  @411
  Scenario: User Adds an Institution from My Profile
    Given User opens Add Institution from My Profile
    When they have searched for an Institution
    And they have selected an Institution
    And they have clicked Add
    Then the Add Institution window is closed
    And the Institution ID is saved to ARP
    And the user sees the new Institution in My Profile

  @383
  Scenario: User removes an ORCID connection from My Profile
    Given user opens the page My Profile
    When they click Remove ORCID
    Then they are asked to confirm
    And their ORCID is removed from ARP

  @353
  Scenario: User logs out
    Given that the user is logged in
    When they click the menu item Log Out
    Then the user is logged out from Feide
    And the search page is opened
    And the user sees non-logged-in menu

  # Menuitems for Creator
  Scenario: User opens New Registration
    Given that the user is logged in as Creator
    When they click the menu item New Registration
    Then the page New Registration is opened
    And the user sees options
      | Start med å laste opp fil          |
      | Start med en lenke til publikasjon |
      | Start med forslag fra din ORCID    |

  @354
  Scenario Outline: User opens My Publications
    Given that the user is logged in as Creator
    When they click the menu item My Publications
    Then the page My Publications is opened
    And a list of all unpublished registrations with the fields
      | Title    |
      | <Status> |
      | Created  |
    And each list item has a button Delete and Edit that is enabled

    Examples:
      | Status   |
      | Draft    |
      | Rejected |

  # Actions from Page : My Publications (Edit)
  @355
  Scenario: User opens an item in the My Publication list
    Given that the user is logged in as Creator
    And has opened the page My Publications
    When they click Edit on an item
    Then the item is opened in the Wizard
    And the user sees the Description tab
    And the fields in the Wizard are populated with values from the saved publication

  # Actions from Page : My Publications (Delete)
  @356
  Scenario: User delete an item in the My Publications list
    Given that the user is logged in as Creator
    And has opened the page My Publications
    When they click Delete on an item
    Then a comfirmation pop-up is opened
    When the user selects Yes the publication is marked as Deleted
    When the user selects No the pop-up is closed

  @421
  Scenario: User opens their Public Profile from My Publications Page
    Given that the user is logged in as Creator
    And has opened the page My Publications
    When they click to go to their public profile
    Then their public profile page is open
    And the page fields for
      | Name                                       |
      | Institutions                               |
      | Public email                               |
      | ORCID                                      |
      | List of publications with status Published |

  # Menuitems for Curator
  @357
  Scenario: User opens My Worklist
    Given that the user is logged in as Curator
    When they click the menu item My Worklist
    Then the page My Worklist is opened
    And the user see the lists
      | For Approval |
      | Support      |
      | DOI request  |
    And the lists have fields
      | Title     |
      | Submitter |
      | Date      |
    And a button Open that is enabled

  # Actions from Page : My Worklist
  @358
  Scenario Outline: User opens an item in the For Approval or DOI request list
    Given that the user is logged in as Curator
    And has opened the page My Worklist
    And they select a <Tab>
    When they click Open on an item
    Then the item is opened in the Wizard
    And the user sees the Submission tab
    And <Button> is enabled

    Examples:
      | Tab          | Button     |
      | For Approval | Publish    |
      | For Approval | Reject     |
      | DOI request  | Create DOI |

  # Menuitems for Administrator
  @359
  Scenario: The user opens User administration
    Given that the user is logged in as Administrator
    When they click the menu item User administration
    Then the page User administration is opened
    And the user sees a list of all users connected to their institution
    And the users are grouped by NVA roles
    And has the fields
      | Autentication ID |
      | Name             |
      | ORCID            |
      | Last login       |
      | Created          |
    And a button Remove that is enabled for each user
    And a Button to add a user with a specific role

  @360
  Scenario: The user opens My Institution
    Given that the user is logged in as Administrator
    When they click the menu item My Institution
    Then are on the page My Institution

  @361
  Scenario: The Administrator edits an Institution
    Given the Administrator has opened My Institution
    When they edit the fields
      | Name in organization registry |
      | Display name                  |
      | Short displayname             |
      | CNAME                         |
      | Intitution DNS                |
    And select Pubications must be approved by Curator
    And upload a new logo
    Then they see a message telling them that the information was saved
    And they can visit the institutional portal

  @362
  Scenario: Administrator views the institutional portal
    Given the Administrator edits an Institution
    When they visit the institutional portal from My Institution
    Then they see the web address in their web browser is the CName + .nva.unit.no
    And the page title is the same as the Display Name that they entered on My Institution

  # Actions from page : Useradministration
  @363
  Scenario Outline: Administrator adds a role to a user
    Given that the user is logged in as Administrator
    And they are on the User Administration Page
    When they click Add User under the <Section>
    Then the page adds a line with the fields
      | ID   |
      | Name |
    And a button Add that is enabled
    Examples:
      | Section       |
      | Administrator |
      | Curator       |
      | Editor        |

  # Menuitems for Editor
  @364
  Scenario: The user opens Editor administration
    Given that the user is logged in as Editor
    When they click the menu item Editor administration
    Then the page Editor administration is opened
    And has the fields
      | Email |
    And a button Save that is enabled

  # Menuitems for Application adminstrator
  @365
  Scenario: The Application adminstrator opens Institutions
    Given that the user is logged in as Application adminstrator
    When they click the menu item Institutions
    Then the page Institutions is opened
    And the user sees a table of all institutions (customers)
    And the table contains the fields
      | Institution |
      | Created     |
      | Editor      |
    And a button Open that is enabled for each institution
    And a button Create Institution that is enabled

  # Actions from page : Institution (Add/Update)
  @366
  Scenario Outline: Application adminstrator changes / adds an institution
    Given that the user is logged in as Application adminstrator
    When they click <Button> in the page Institutions
    Then the page Institution is opened with the fields
      | Name in organization registry |
      | Display name                  |
      | Short displayname             |
      | CNAME                         |
      | Intitution DNS                |
      | Administration ID             |
      | Feide Organization ID         |
    And a button Add that is enabled
    Examples:
      | Button |
      | Add    |
      | Save   |
