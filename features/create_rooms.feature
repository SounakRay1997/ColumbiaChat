Feature: creating a new room

  As a user of Columbia Chat
  I have developed a new interest but I cannot find a group for this hobby
  I want to create a new group and want to ensure that it is visible to everyone else.

  Background: rooms have been created on application

    Given the following rooms exist:
      | name                      | is_private | created_at           |  updated_at          |
      | Food lovers               | false      | 2021-10-25 09:53:42  | 2021-10-29 10:34:32  |
      | music                     | false      | 2021-10-26 10:34:32  | 2021-10-30 14:45:54  |
      | ice skating               | false      | 2021-10-26 13:32:37  | 2021-10-30 13:32:37  |
      | halloween party           | false      | 2021-10-27 14:45:54  | 2021-10-31 10:34:32  |
    Given the following users exist:
      | username                  | email                    | password     | email_confirmed |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  1              |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              |

  Scenario: I should be able to see all the existing groups
    When I am on the ColumbiaChat signin page
    And I fill in "session_username" with "Umang_Raj"
    And I fill in "session_password" with "Lol@123"
    And I press "Sign In"
    Then I should see "Hi Umang_Raj"
    And I should have options to send messages to "halloween party", "music", "ice skating", "Food lovers"

    Scenario: I create a new group for "Equestrian"
      Given I am logged in as "Umang_Raj" with password as "Lol@123"
      And I fill in "room_name" with "Equestrian"
      And I press "Create Room"
      Then "Chinmay_Garg" with password as "Password@123" should see a new room named "Equestrian"
      And "Sounak_Ray" with password as "Password@321" should see a new room named "Equestrian"
      And "Harrison_Groll" with password as "Lol@321" should see a new room named "Equestrian"
      And "Chinmay_Garg" with password as "Password@123" should not see a new room named "Equestrian Horse Riding"
      And "Sounak_Ray" with password as "Password@321" should not see a new room named "Equestrian Columbia"
      And "Harrison_Groll" with password as "Lol@321" should not see a new room named "Equestrian Olympics"