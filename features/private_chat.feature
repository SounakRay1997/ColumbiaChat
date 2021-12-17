Feature: sending message on a private chat

  As a user of Columbia Chat
  when I send a message on a chat intended for a specific member of the Columbia fraternity
  I want to ensure that only that person can see the message and not anyone else.

  Background: users have been added to database

    Given the following rooms exist:
      | name                      | is_private | created_at           |  updated_at          | dept_code |
      | Food lovers               | false      | 2021-10-25 09:53:42  | 2021-10-29 10:34:32  | NONE      |
      | music                     | false      | 2021-10-26 10:34:32  | 2021-10-30 14:45:54  |           |
      | ice skating               | false      | 2021-10-26 13:32:37  | 2021-10-30 13:32:37  |           |
      | halloween party           | false      | 2021-10-27 14:45:54  | 2021-10-31 10:34:32  |           |
      | Operating Systems         | false      | 2021-10-27 14:45:54  | 2021-10-31 10:34:32  | COMS      |

    Given the following users exist:
      | username                  | email                    | password     | email_confirmed | name            | lat         | long         |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              | Umang Raj       | 40.8027804  | -73.9652053  |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              | Chinmay Garg    | 40.8136649  | -73.9622991  |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  0              | Harrison Groll  | 40.7999209  | -73.9683102  |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              | Sounak Ray      | 40.8136659  | -73.962224   |


  Scenario: having the option to send private chat to everyone apart from self after logging in
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
    Then I should see "Umang Raj"
    And "Umang Raj" should see options to send messages to "Sounak Ray", "Chinmay Garg" and "Harrison Groll"


  Scenario Outline: send a private chat to a single person
    Given I am logged in as "<arg1>" with password as "<arg4>"
    When "<arg1>" send a message "<arg2>" to "<arg3>"
    Then "<arg1>" with password as "<arg4>" should see the message "<arg2>" on the chat with "<arg3>"
    And "<arg1>" with password as "<arg4>" should not see the message "<arg2>" on the chat with "<arg31>"
    And "<arg1>" with password as "<arg4>" should not see the message "<arg2>" on the chat with "<arg32>"
    Examples:
      | arg1        | arg4      |  arg2                     | arg3             | arg31        | arg32          |
      | Umang_Raj   | Lol@123   |  Happy Birthday Sounak!   | Sounak Ray       | Chinmay Garg | Harrison Groll |
      | Umang_Raj   | Lol@123   |  Happy Birthday Chinmay!  | Chinmay Garg     | Sounak Ray   | Harrison Groll |
      | Umang_Raj   | Lol@123   |  Happy Birthday Harrison! | Harrison Groll   | Chinmay Garg | Sounak Ray     |