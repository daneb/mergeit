Given(/^I dont know how to interact with the application$/) do
  @test.application
end

When(/^I specify no arguments$/) do
  expect(@test.execute_without_arguments).to eq true
end

Then(/^I want to be presented with information on how to use it$/) do
  expect(@test.help_information_is_printed).to eq true
end

Given(/^My incorrect usage of the application argument names$/) do
  @test.application_with_incorrect_argument_name
end

When(/^I specify an incorrect argument name$/) do
  expect(@test.use_incorrect_argument_name).to eq true
end

Given(/^My incorrect usage of the applications second argument$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I specify the first filename but not the second$/) do
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