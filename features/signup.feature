Feature: signup on Columbia Chat

  As a new member of the Columbia fraternity
  when I want to create a new account using the signup form
  I want to ensure that my data is correctly added to the database.

  Background: there are certain number of users already in the database

    Given the following users exist:
      | username                  | email                    | password     | email_confirmed | name            | lat         | long         |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              | Umang Raj       | 40.8027804  | -73.9652053  |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              | Chinmay Garg    | 40.8136649  | -73.9622991  |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  0              | Harrison Groll  | 40.7999209  | -73.9683102  |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              | Sounak Ray      | 40.8136659  | -73.962224   |

  Scenario: able to reach the signup page
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    Then I should reach the sign up page

  Scenario: when I signup my data should be added to the database
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    Then I fill in name as "Bruce Wayne", username as "Bruce_Wayne", email as "batman@columbia.edu" and password as "wayne_enterprise" on the signup page and database is updated

  Scenario: when I try to signup with a duplicate username the database should stop me
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    And I fill in name as "Umang Raj", username as "Umang_Raj", email as "umang@columbia.edu" and password as "Lol@1234"
    And I press "Sign Up"
    Then I should see a message "This username already exists. Please choose a different username."

  Scenario: when I try to signup with a duplicate email the database should stop me
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    And I fill in name as "Umang Raj", username as "ur2136", email as "ur1236@columbia.edu" and password as "Lol@1234"
    And I press "Sign Up"
    Then I should see a message "You already have an account. Please sign in with your existing account."

  Scenario: when I try to signup with a email other the LionMail account the database should stop me
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    And I fill in name as "Umang Raj", username as "ur2136", email as "ur1236@gmail.com" and password as "Lol@1234"
    And I press "Sign Up"
    Then I should see a message "Please use your LionMail Account to Sign Up."

  Scenario: when I try to signup with a different password and password confirmation then I should see a warning
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    And I fill in name as "Suvansh Dutta", username as "suvansh_dutta", email as "sd3513@columbia.edu" and password as "Lol@1234" and confirm_password as "Lol123"
    And I press "Sign Up"
    Then I should see a message "Password and Confirm Password must match."

  Scenario: when I try to signup with a
    When I am on the ColumbiaChat signin page
    And I click on "Sign Up"
    And I fill in name as "Suvansh Dutta", username as "suvansh_dutta", email as "sd3513@columbia.edu" and password as "Lol@123" and confirm_password as "Lol@123"
    And I press "Sign Up"
    Then I should see a message "Please confirm your email address to continue"