Given(/^the following users exist:$/) do |table|
  # table is a table.hashes.keys # => [:username, :email, :password]
  table.hashes.each do |user|
    User.create(username:user[:username], email:user[:email], password:user[:password])
  end
end

When /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

And /^(?:|I )press "([^"]*)"$/ do |link|
  click_button(link)
end

Then(/^I should see "([^"]*)"$/) do |arg|
  page.assert_text("Hi Umang_Raj")
end

And(/^"([^"]*)" should see options to send messages to "([^"]*)", "([^"]*)" and "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  page.body.index("Users") < page.body.index(arg2) and page.body.index("Users") < page.body.index(arg3) and page.body.index("Users") < page.body.index(arg4) and page.body.index("Users") > page.body.rindex(arg1)
end

Given(/^I am logged in as "([^"]*)"$/) do |arg|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "username" with "#{arg}"
    And I press "Sign in"
  )
  page.assert_text("Hi Umang_Raj")
end

When(/^"([^"]*)" send a message "([^"]*)" to "([^"]*)"$/) do |arg1, arg2, arg3|
  click_link(arg3)
  fill_in("chat-text", :with => arg2)
  click_button("Create Message")
end

Then(/^"([^"]*)" should see the message "([^"]*)" on the chat with "([^"]*)"$/) do |arg1, arg2, arg3|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "username" with "#{arg1}"
    And I press "Sign in"
  )
  click_link(arg3)
  assert page.has_content? (arg2)
end

And(/^"([^"]*)" should not see the message "([^"]*)" on the chat with "([^"]*)"$/) do |arg1, arg2, arg3|
  steps %(
    When I am on the ColumbiaChat signin page
    And I fill in "username" with "#{arg1}"
    And I press "Sign in"
  )
  click_link(arg3)
  assert page.has_no_content? (arg2)
end