Given(/^the following rooms exist:$/) do |table|
  # table is a table.hashes.keys # => [:name, :is_private]
  table.hashes.each do |room|
    Room.create(name:room[:name], is_private:room[:is_private], created_at:room[:created_at], updated_at:room[:updated_at])
  end
end

And(/^I should have options to send messages to "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  puts (page.body)
  expect(page.body).to have_content(arg1) and expect(page.body).to have_content(arg2) and expect(page.body).to have_content(arg3) and expect(page.body).to have_content(arg4)
end

Then(/^"([^"]*)" should see a new room named "([^"]*)"$/) do |arg1, arg2|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "username" with "#{arg1}"
    And I press "Sign in"
  )
  expect(page.body).to have_content(arg2)
end

And(/^"([^"]*)" should not see a new room named "([^"]*)"$/) do |arg1, arg2|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "username" with "#{arg1}"
    And I press "Sign in"
  )
  expect(page.body).to have_no_content(arg2)
end