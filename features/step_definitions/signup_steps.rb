And(/^I click on "([^"]*)"$/) do |arg|
  click_link(arg)
end

Then(/^I should reach the sign up page$/) do
  expect(page.body).to have_content("Sign up") and expect(page.body).to have_content("Confirmation")
end

Then(/^I fill up my details on the signup page$/) do
  fill_in("user_username", :with => "Bruce_Wayne")
  fill_in("user_email", :with => "batman@columbia.edu")
  fill_in("user_password", :with => "wayne_enterprise")
  fill_in("user_password_confirmation", :with => "wayne_enterprise")
  click_button("Create my account")
end

Then(/^my details should be saved in the users database and there would be "([^"]*)" users in the database$/) do |arg|
  User.count.should be arg.to_i
end
