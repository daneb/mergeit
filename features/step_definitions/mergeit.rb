Given(/^I dont know how to interact with the application$/) do
  @test.application == "/bin/mergeit"
end

When(/^I specify no arguments$/) do
  @test.execute_application_without_arguments == true
end

Then(/^I want to be presented with information on how to use it$/) do
  @test.help_information_is_printed == true
end

Given(/^My incorrect usage of the application$/) do
  @test.use_only_one_argument == true
end

Then(/^I want to be notified 'two arguments required'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^My incorrect usage of the application argument names$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I specify an incorrect argument name$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^My incorrect usage of the applications second argument$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I specify the first filename but not the second$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I specify only one argument in its use$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I want to be guided on what to do next$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I want to be notified 'filename is required'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^My incorrect usage of the applications first argument$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I specify the second filename but leave the first empty$/) do
  pending # Write code here that turns the phrase above into concrete actions
end