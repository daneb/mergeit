Feature: Mergeit Command Line
  As a end-user 
  When I want to merge data from files
  In order to indicate which files
  I want to specify them on the command-line

Scenario: No command line arguments
  Given I dont know how to interact with the application
  When I specify no arguments
  Then I want to be presented with information on how to use it

Scenario: Incorrect argument
  Given My incorrect usage of the application argument names
  When I specify an incorrect argument name
  Then I want to be guided on what to do next

Scenario: Empty second argument
  Given My incorrect usage of the applications second argument
  When I specify the first filename but not the second
  Then I want to be notified 'filename is required'

Scenario: Empty first argument
  Given My incorrect usage of the applications first argument 
  When I specify the second filename but leave the first empty
  Then I want to be notified 'filename is required'
