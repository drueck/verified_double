Given /^the following classes:$/ do |string|
  write_file 'lib/main.rb', string
end

Given /^the test suite includes VerifiedDouble to verify doubles with accessor methods:$/ do |string|
  write_file 'spec/spec_helper.rb', string
end

Given /^the test suite has an after\(:suite\) callback asking VerifiedDouble to report unverified doubles:$/ do |string|
  write_file 'spec/spec_helper.rb', string
end

Given /^a test that uses VerifiedDouble to mock an object:$/ do |string|
  write_file 'spec/main_spec.rb', string
end

Given /^a test that uses VerifiedDouble to stub an object:$/ do |string|
  write_file 'spec/main_spec.rb', string
end

Given /^a test that uses VerifiedDouble to mock a class:$/ do |string|
  write_file 'spec/main_spec.rb', string
end

Given /^the test suite has a contract test for the mock:$/ do |string|
  write_file 'spec/contract_test_for_main_spec.rb', string
end

Given /^the test suite has a contract test for the stub:$/ do |string|
  write_file 'spec/contract_test_for_main_spec.rb', string
end

Given /^the test suite does not have a contract test for the mock$/ do
  # do nothing
end

When /^I run the test suite$/ do
  run_simple(unescape("rspec"), false)
end

Then /^I should be informed that the mock is unverified:$/ do |string|
  assert_partial_output(string, all_output)
  assert_success('pass')
end

Then /^I should not see any output saying the mock is unverified$/ do
  assert_no_partial_output("The following mocks are not verified", all_output)
  assert_success('pass')
end

Then /^I should not see any output saying the stub is unverified$/ do
  assert_no_partial_output("The following mocks are not verified", all_output)
  assert_success('pass')
end
