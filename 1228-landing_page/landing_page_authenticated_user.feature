Feature: Authenticated User opens a Resources Landing Page

	Background:
		Given a User has logged in
		And the User opens a Resources' Landing Page

	@needJiraTag
	Scenario: Authenticated User claim ownership of the Resource
		When the User claims ownership of the Resource
		Then a Ownership Request is created
		And it contains a Message where the User present his claim