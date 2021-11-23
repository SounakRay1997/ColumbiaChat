Feature: signin on Columbia Chat

  As a new user of Columbia Chat
  I have created my account
  Now I want to sign in and enjoy access to all the amazing features of the application

  Background: there are certain number of users already in the database

    Given the following users exist:
      | username                  | email                    | password     | email_confirmed |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      | 1               |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 | 1               |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      | 0               |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 | 1               |

  Scenario: I should not be able to signin with a non-existent username
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Suvansh_Dutta"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
    Then I should see a message "Incorrect Username"

  Scenario: I should not be able to signin with a wrong password
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@1234"
    And I press "Sign In"
    Then I should see a message "Incorrect Password"

  Scenario: I should not be able to signin with a non confirmed account for an account for which email id is not confirmed
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Harrison_Groll"
    And I fill in "session_password" with "Lol@321"
    And I press "Sign In"
    Then I should see a message "Please activate your account by following the instructions in the confirmation email you received. If you did not receive the mail please check your spam folder."




