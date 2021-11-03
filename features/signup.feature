Feature: signup on Columbia Chat

  As a new member of the Columbia fraternity
  when I want to create a new account using the signup form
  I want to ensure that my data is correctly added to the database.

  Background: there are certain number of users already in the database

    Given the following users exist:
      | username                  | email                    | password     |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |

  Scenario: able to reach the signup page
    When I am on the ColumbiaChat signin page
    And I click on "Signup"
    Then I should reach the sign up page

  Scenario: when I signup my data should be added to the database
    When I am on the ColumbiaChat signin page
    And I click on "Signup"
    Then I fill in username as "Bruce_Wayne", email as "batman@columbia.edu" and password as "wayne_enterprise" on the signup page and database is updated
