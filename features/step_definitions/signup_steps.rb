And(/^I click on "([^"]*)"$/) do |arg|
  click_link(arg)
end

Then(/^I should reach the sign up page$/) do
  expect(page.body).to have_content("Sign up") and expect(page.body).to have_content("Confirmation")
end

Then(/^I fill in username as "([^"]*)", email as "([^"]*)" and password as "([^"]*)" on the signup page and database is updated$/) do |arg1, arg2, arg3|
  fill_in("user_username", :with => arg1)
  fill_in("user_email", :with => arg2)
  fill_in("user_password", :with => arg3)
  fill_in("user_password_confirmation", :with => arg3)
  expect{click_button("Create my account")}.to change(User, :count).by(1)
end
