Feature: Mergeit Command Line
  As a end-user 
  When I want to merge data from files
  In order to indicate which files
  I want to specify them on the command-line

Scenario: No command line arguments
  Given I dont know how to interact with the application
  When I specify no arguments
  Then I want to be presented with information on how to use it

Scenario: Incorrect option
  Given My incorrect usage of the application option names
  When I specify an incorrect option name
  Then I want to be notified 'unknown option'

Scenario: Empty first argument
  Given My incorrect usage of the applications first argument 
  When I specify the second filename but leave the first empty
  Then I want to be notified 'both filenames are required'

Scenario: Empty second argument
  Given My incorrect usage of the applications second argument
  When I specify the first filename but not the second
  Then I want to be notified 'missing argument'

Scenario: No second option
  Given My incorrect usage of the applications second option
  When I dont specify the second option and second filename
  Then I want to be notified 'both filenames are required'

