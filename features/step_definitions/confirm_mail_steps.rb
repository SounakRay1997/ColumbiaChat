Given(/^the following users exist in the database:$/) do |table|
  # table is a table.hashes.keys # => [:username, :email, :password]
  table.hashes.each do |user|
    User.create(username:user[:username], email:user[:email], password:user[:password], email_confirmed:user[:email_confirmed], confirm_token:user[:confirm_token])
  end
end

When(/^I click on the link with confirm_token as "([^"]*)"$/) do |arg|
  click_link("http://localhost:3000/users/#{arg}/confirm_email")
end

Then(/^I should see the message "([^"]*)"$/) do |arg|
  pending
end