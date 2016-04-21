Given(/^I dont know how to interact with the application$/) do
  @test.app
end

When(/^I specify no arguments$/) do
  expect(@test.execute_without_arguments).to eq true
end

Then(/^I want to be presented with information on how to use it$/) do
  expect(@test.help_information_is_printed).to eq true
end

Given(/^My incorrect usage of the application option names$/) do
  @test.application_with_incorrect_option_name
end

When(/^I specify an incorrect option name$/) do
  expect(@test.use_incorrect_option_name).to eq true
end

Then(/^I want to be notified 'unknown option'$/) do
  expect(@test.notified_with_unknown_option).to eq true
end

Given(/^My incorrect usage of the applications second argument$/) do
  @test.application_with_no_second_file
end

When(/^I specify the first filename but not the second$/) do
  expect(@test.dont_use_second_filename).to eq true
end

Then(/^I want to be notified 'missing argument'$/) do
  expect(@test.notified_missing_argument).to eq true
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