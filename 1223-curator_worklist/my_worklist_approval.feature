Feature: Curator handles an Approval Request

	Background: 
		Given Curator open a Requests Resource

	@needJiraTag
	Scenario: Curator decline a Approval Request
		When the Curator decline the Request 
		Then the Request Status is set to "Declined"
		And the Curator may send a reason to the User

	@needJiraTag
	Scenario: Curator approve a Approval Request
		Given Owner wish to publish Registration, all restrictions
		And Editor has restricted publishing
		When Curator approves the Request
		Then the Request status is "Done"
		And the Resource's status is "Published"

	@needJiraTag
	Scenario: Curator approve a File Approval Request
		Given Owner wish to publish Registration, file restrictions
		And Editor has restricted publishing of files
		When Curator approves the Request
		Then the Request status is "Done"
		And remove the extra embargo on files
		# Resource is published and Landing Page is public
		# Don't remove the potentially original embargo on the files