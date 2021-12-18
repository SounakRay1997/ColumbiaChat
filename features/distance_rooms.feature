Feature: creating a discoverable group

  As a user of Columbia Chat
  when I create a discoverable group with a certain radius
  all people within that radius should see the group.

  Background: rooms have been created on database

    Given the following users exist:
      | username                  | email                    | password     | email_confirmed | name            | lat         | long          |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              | Umang Raj       | 40.8028039  | -73.965221    |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              | Chinmay Garg    | 40.8136649  | -73.9622991   |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  1              | Harrison Groll  | 40.7999209  | -73.9683102   |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              | Sounak Ray      | 40.8136855  | -73.9622017   |

  Scenario: I create a new group for which is discoverable to everyone
      Given I am logged in as "Umang_Raj" with password as "Lol@123"
      And I fill in "room_name" with "Discoverable To Everyone"
      And I select "No" from "room_private_room"
      And I fill in "room_distance" with "20000"
      And I press "Create Room"
      Then "Chinmay_Garg" with password as "Password@123" should see a new room named "Discoverable To Everyone"
      And "Sounak_Ray" with password as "Password@321" should see a new room named "Discoverable To Everyone"
      And "Harrison_Groll" with password as "Lol@321" should see a new room named "Discoverable To Everyone"
      And "Chinmay_Garg" with password as "Password@123" should not see a new room named "Not Discoverable To Everyone"
      And "Sounak_Ray" with password as "Password@321" should not see a new room named "Discoverable Not To Everyone"
      And "Harrison_Groll" with password as "Lol@321" should not see a new room named "Not Discoverable To Everyone"

#  Scenario: I create a new group for which is discoverable to some people
#    Given I am logged in as "Sounak_Ray" with password as "Password@321"
#    And I fill in "room_name" with "Not Discoverable To Everyone"
#    And I select "No" from "room_private_room"
#    And I fill in "room_distance" with "1"
#    And I press "Create Room"
#    Then "Chinmay_Garg" with password as "Password@123" should not see a new room named "Not Discoverable To Everyone"
#    And "Umang_Raj" with password as "Lol@123" should not see a new room named "Not Discoverable To Everyone"
#    And "Harrison_Groll" with password as "Lol@321" should not see a new room named "Not Discoverable To Everyone"