Feature: sending message on a private chat

  As a user of Columbia Chat
  when I send a message on a group chat intended for a specific groups of members of the Columbia fraternity
  I want to ensure that only that group of people can see the message and not anyone else.

  Background: rooms have been created on database

    Given the following rooms exist:
      | name                      | is_private |
      | Food Lovers               | false      |
      | music                     | false      |
      | ice skating               | false      |
      | halloween party           | false      |
    Given the following users exist:
      | username                  | email                    | password     |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |

  Scenario Outline: send a group chat to a group of people
    When I am logged in as "Umang_Raj"
    And I send a message "<arg1>" to the group "<arg2>"
    Then I should see the message "<arg1>" on the group chat titled "<arg2>"
    And I should not see the message "<arg1>" on the group chat titled "<arg21>"
    And I should not see the message "<arg1>" on the group chat titled "<arg22>"
    And I should not see the message "<arg1>" on the group chat titled "<arg23>"
    Examples:
      | arg1                                          | arg2            | arg21     | arg22       | arg23           |
      | Any knows a good taco place?                  | Food Lovers     | music     | ice skating | halloween party |
      | Who all are going to the halloween cruise?    | halloween party | music     | ice skating | Food Lovers     |

