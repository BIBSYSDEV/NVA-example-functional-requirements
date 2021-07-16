Feature: Curator handles an Ownership Request

	Background: 
		Given Curator open a Ownership Resource

	@needJiraTag
	Scenario: Curator decline a Ownership Request
		When the Curator decline an Request 
		Then the Request Status is set to "Declined"
		And the Curator may send a reason to the Request Sender

	@needJiraTag
	Scenario: Curator approve a Ownership Request
		When Curator approves the Request
		Then the Request status is "Done"
		#next line is future stuff - Resource's Owner is'nt part of this Request, needs to create a new type of Request. Same need is identified before - to communicate between two Curators at same or different Hosts.
		#And the Curator may send a reason to the Resource's Owner
		And the Resource's Owner is changed to the Requests' Sender
		And the Resource's Host is changed to the Requests' Senders' Host
		# The Resource and it's Requests must tell it's history correctly - who did what, when and why
