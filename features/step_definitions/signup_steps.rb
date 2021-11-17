And(/^I click on "([^"]*)"$/) do |arg|
  click_link(arg)
end

Then(/^I should reach the sign up page$/) do
  expect(page.body).to have_content("Sign Up") and expect(page.body).to have_content("It’s quick and easy. Sign Up with your LionMail Account")
end

Then(/^I fill in username as "([^"]*)", email as "([^"]*)" and password as "([^"]*)" on the signup page and database is updated$/) do |arg1, arg2, arg3|
  fill_in("user_username", :with => arg1)
  fill_in("user_email", :with => arg2)
  fill_in("user_password", :with => arg3)
  fill_in("user_password_confirmation", :with => arg3)
  expect{click_button("Sign Up")}.to change(User, :count).by(1)
end

And(/^I fill in name as "([^"]*)", username as "([^"]*)", email as "([^"]*)" and password as "([^"]*)"$/) do |arg1, arg2, arg3, arg4|
  fill_in("user_name", :with => arg1)
  fill_in("user_username", :with => arg2)
  fill_in("user_email", :with => arg3)
  fill_in("user_password", :with => arg4)
  fill_in("user_password_confirmation", :with => arg4)
end

Then(/^I should see a message "([^"]*)"$/) do |arg|
  expect(page.body).to have_content(arg)
end

And(/^I fill in name as "([^"]*)", username as "([^"]*)", email as "([^"]*)" and password as "([^"]*)" and confirm_password as "([^"]*)"$/) do |arg1, arg2, arg3, arg4, arg5|
  fill_in("user_name", :with => arg1)
  fill_in("user_username", :with => arg2)
  fill_in("user_email", :with => arg3)
  fill_in("user_password", :with => arg4)
  fill_in("user_password_confirmation", :with => arg5)
end