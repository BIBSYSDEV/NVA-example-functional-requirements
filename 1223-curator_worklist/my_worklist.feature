Feature: Curator opens My Worklist

	"@needJiraTag" is used in several files to enable me to locate all new scenarios that is'nt in jira.
	"@updated" is used where I have changed a scenario, that exists in jira - but not updated it there yet.
	#If a scenarios is deleted, but still exists in Jira - it's noted as a comment

	Vocabulary clearification:
		- A named role is preferd over "they"
		- Resource is prefered over Registration

	Rules:
		- A User has a Host, an Institution (the IDP)
		- A Curator has a Host (works at an Institution)
		- A Resource's Host is equal to it's origin Creators' or current Owners'
		- A Rescourc has a Owner (a User)
		- The Worklist is populated with Requests
		- A Request is of a type (four possible)
		- A Request has a Sender (a User)
		- A Request has a Custodian (a Curator, that looks after it)
		- A Request has a date of creation
		- A Request has a date of status change
		- A Request have one or more Messages
		- A Message has a Writer (the User/Sender or a Curator)
		- A Message has a date of creation
		- A Request's Host is it's Senders'

	Future stuff:
		- The Custodian needs to be notified when a Request is updated (a new Message or someone adopts it)

	Background: 
		Given Curator is loged in
		And Curator opens My Worklist from main menu
		And My Worklist contains Requests of all four types
		And all Requsts are sendt by a User Affilliated at Curators Scope
		And the list of Approvals are in focus

    @357
    @updated
    #Replaces @1353, 1354, 2756 and 531
    Scenario Outline: Curator views a Request type 
        When they click on Requests of type "<Type>"
        Then they see a list of Requests displayed with:
            | Request status           |
            | Registration title       |
            | Submitter name           |
            | Date                     |
            | Begining of last message |
            | Owner                    |
        And they see that each Request can be opend
        Examples:
			| Approvals |
			# Må handtere at Editor kan tillate alle å publisere - kva skjer da med Approvals?
			| Support   |
			| DOI       |
			| Ownership |

	@1252
	@updated
	Scenario: Curator views details of a Request
		When they selects one Request
		Then the Requests message is expanded
		And possible previous messages is displayed
		And the Owner is viewed
		And the Curator can send an answer
		And the Curator can open the Requests Resource 
		And the Curator can change Status on the Request

	@needJiraTag
	Scenario: Curator opens a Request without owner
		Given Curator views details of a Request
		When Owner of the Request is undefined
		Then the Curator is the Owner of the request
		And the Requests Status is set to "Active"

	@needJiraTag
	Scenario: Curator declines Ownership of a Request
		When the Curator selects "Mark request unread" 
		Then the Requests Status is updated to "New"
		And the Owner is set to undefined

	@needJiraTag
	Scenario: User gets an answer on a Support Request
		When the Curator writes an answer 
		And sends it to the User 
		And the Request type is Support
		Then the User can see the answer in My Messages
		And the Request status is set to "Done"

	@needJiraTag
	Scenario Outline: Curator open the Requests Resource
		When the Curator opens the Requests Resource
		Then the Landing Page of the Resourcs is opened
		And the Resource "<Type>" Button "<Action>" is visible 
		Examples:
			| Type      | Action       |
			| Approval  | Publish      |
			| Approval  | Decline      |
			| DOI       | Mint DOI     |
			| DOI       | Decline      |
			| Ownership | Change owner |
			| Ownership | Decline      |

	@needJiraTag
	Scenario: User gets an answer to a Request
		When the Curator writes an answer 
		And sends it to the User 
		And the Request Type is:
			| Approval  |
			| DOI       |
			| Ownership |
		Then the User can see the answer in My Messages

	@needJiraTag
	Scenario Outline: Curator change Status on a Request
		When they select a new status "<Status>" on a Request
		Then the status of the Request is set to "<Status>"
		Examples:
			| Status   |
            | Archived |
            | Deleted  |

	@needJiraTag
	Scenario: Curator claims a Request
		When the Curator do either: 
			| send an answer        |
			| Publish               |
			| Mint a DOI            |
			| Decline a DOI         |
			| Change Owner          |
			| Decline a Ownerchange |
		Then the Curator is stored as Owner of the Request

	@needJiraTag
	Scenario: Decide which Approval, Support or DOI Requests is in a Curators Scope
		When the Requests' Host equals the Curators Host 
		And Curators scope on the Institution include the Requests' Users' User Profile affilliation to the Institution
		Then the Users Request is displayed to the Curator

	@needJiraTag
	Scenario: Decide which Ownership Requests is in a Curators Scope
		When the Requests' Resources' Host equals the Curators Host 
		And Curators scope on the Institution include the Resources' Owners' User Profile affilliation to the Institution
		Then the Users Request is displayed to the Curator






