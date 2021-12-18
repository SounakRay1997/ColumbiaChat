And (/^I send a message "([^"]*)" to the group "([^"]*)"$/) do |arg1, arg2|
  click_link(arg2)
  fill_in("chat-text", :with => arg1)
  click_button("Send")
end

Then(/^I should see the message "([^"]*)" on the group chat titled "([^"]*)"$/) do |arg1, arg2|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
  )
  click_link(arg2)
  expect(page.body).to have_content(arg1)
end

And(/^I should not see the message "([^"]*)" on the group chat titled "([^"]*)"$/) do |arg1, arg2|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
  )
  click_link(arg2)
  expect(page.body).to have_no_content(arg1)
end