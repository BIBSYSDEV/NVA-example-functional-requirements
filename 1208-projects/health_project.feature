Feature: Health related Project
    
    <Whay> --> In order to
    <Who>  --> As a 
    <What> --> I want to
    (<How> --> One or more Scenarios, below Background)
    
    In order to do health research a project needs an REK approval
    As a logged in User
    I want to see the current REK approval of my project

    In order to report correctly to HOD about health research project
    As a Anonymus User
    I want to see the Clinical Trial Phase for Drug studies on Landing Page

    Rules:
    * A project with a REK Approval is a Health Project
    * A REK approval originate from REK, through a API call
    * A REK approval containing a ProjectID, update that project 
    * A REK approval lacking a ProjectID, originate a new Project
    * Health Project need an updated REK Approval to change title, coordinating institution, start date, end data or participants of type PRO_MANAGER.

    Questions:
    * Do REK send us changed/updated approvals today?
    * Do a REK approval have a field for our Project ID?
    * How do we cleen up that REK is Project Owner on a lot of projects today?

    # Given bør kun brukes når det er ein bestemt sekvens av scenario - generelt kan Given utrykkes som ein del av Then -> DRY-code
    # Så langt som mulig bør ikkje Scenario inneholde ord som click og button etc - det skaper vedlikeholdsutfordringer
    # Test pyramiden oppfordrer til at omfanget av tester skal ligge mot "bunnen" av stacken - ikkje på UI. Brudd på dette utfordrer CI, da build'n'deploy raskt vil overstige 10-15 min

    Background: The Project has a Approval of type "REK"
    # Must be legal for all following Scenarios
    # Use this is keep your code DRY

    @xxx - referense to Jira task
    Scenario: User opens a Health Project in the Project Wizard
        When the User tries to edit a project 
        Then they are notified that an updated REK approval is needed to change:
            | Title                    |
            | Coordinating Institution |
            | Start Date               |
            | End Date                 |
            | Project Manager          | 
 
   @2697
    Scenario: User sees Clinical Trial Phase for Drug studies
        When the Project is a Drug study
        Then the Landing Page contains the Project's Clinical Trial Phase
