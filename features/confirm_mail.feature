#Feature: confirm mail on Columbia Chat
#
#  As a new member of the Columbia fraternity
#  when I want to confirm my account by clicking the confirmation link on my email
#  I want to ensure that my data is correctly added to the database.
#
#  Background: there are certain number of users already in the database
#
#    Given the following users exist in the database:
#      | username                  | email                    | password     | email_confirmed | confirm_token |
#      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      | 0               | ccfFFDsa=dvs  |
#
#
#  Scenario: able to reach the confirm email
#    When I click on the link with confirm_token as "ccfFFDsa=dvs"
#    Then I should see the message "Welcome to the ColumbiaChat! Your email has been confirmed."
