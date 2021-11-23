Feature: sending message on a private chat

  As a user of Columbia Chat
  when I send a message on a chat intended for a specific member of the Columbia fraternity
  I want to ensure that only that person can see the message and not anyone else.

  Background: users have been added to database

    Given the following users exist:
      | username                  | email                    | password     | email_confirmed |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  1              |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              |

  Scenario: having the option to send private chat to everyone apart from self after logging in
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
    Then I should see "Hi Umang_Raj"
    And "Umang_Raj" should see options to send messages to "Sounak_Ray", "Chinmay_Garg" and "Harrison_Groll"


  Scenario Outline: send a private chat to a single person
    Given I am logged in as "<arg1>" with password as "<arg4>"
    When "<arg1>" send a message "<arg2>" to "<arg3>"
    Then "<arg1>" with password as "<arg4>" should see the message "<arg2>" on the chat with "<arg3>"
    And "<arg1>" with password as "<arg4>" should not see the message "<arg2>" on the chat with "<arg31>"
    And "<arg1>" with password as "<arg4>" should not see the message "<arg2>" on the chat with "<arg32>"
    Examples:
      | arg1        | arg4      |  arg2                     | arg3             | arg31        | arg32          |
      | Umang_Raj   | Lol@123   |  Happy Birthday Sounak!   | Sounak_Ray       | Chinmay_Garg | Harrison_Groll |
      | Umang_Raj   | Lol@123   |  Happy Birthday Chinmay!  | Chinmay_Garg     | Sounak_Ray   | Harrison_Groll |
      | Umang_Raj   | Lol@123   |  Happy Birthday Harrison! | Harrison_Groll   | Chinmay_Garg | Sounak_Ray     |