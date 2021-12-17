Feature: filtering groups by department

  As a user of Columbia Chat
  when I filter for a particular department
  then I should only see the groups for that department

  Background: rooms have been created on database

    Given the following rooms exist:
      | name                      | is_private | created_at           |  updated_at          | dept_code |
      | Food lovers               | false      | 2021-10-25 09:53:42  | 2021-10-29 10:34:32  | NONE      |
      | music                     | false      | 2021-10-26 10:34:32  | 2021-10-30 14:45:54  |           |
      | ice skating               | false      | 2021-10-26 13:32:37  | 2021-10-30 13:32:37  |           |
      | halloween party           | false      | 2021-10-27 14:45:54  | 2021-10-31 10:34:32  |           |
      | Operating Systems         | false      | 2021-10-27 14:45:54  | 2021-10-31 10:34:32  | COMS      |
    Given the following users exist:
      | username                  | email                    | password     | email_confirmed | name            | lat         | long          |
      | Umang_Raj                 | ur1236@columbia.edu      | Lol@123      |  1              | Umang Raj       | 40.8028039  | -73.965221    |
      | Chinmay_Garg              | cg3286@columbia.edu      | Password@123 |  1              | Chinmay Garg    | 40.8136649  | -73.9622991   |
      | Harrison_Groll            | hsg2136@columbia.edu     | Lol@321      |  1              | Harrison Groll  | 40.7999209  | -73.9683102   |
      | Sounak_Ray                | sr3846@columbia.edu      | Password@321 |  1              | Sounak Ray      | 40.8136855  | -73.9622017   |
    Given the following courses exist:
      | course_code   | course_title              | class_id        | department          | department_code |
      | ACCT B6001    | Financial Accounting      | B6001-20221-001 | Accounting (ACCT)   | ACCT            |
      | COMS E6111    | Advanced Database Systems | E6111-20221-V01 | Video Network       | COMS            |
      | COMS W4771    | Machine Learning          | W4771-20221-001 | Computer Science    | COMS            |
      | COMS W4118    | Operating Systems         | W4118-20221-001 | Computer Science    | COMS            |

  Scenario: I filter the courses only for the COMS department
    Given I am logged in as "Umang_Raj" with password as "Lol@123"
    And I select "COMS" from "dept_id"
    And I press "Search"
    Then I should see "Machine Learning"

  Scenario: I filter the courses for ALL departments
    Given I am logged in as "Umang_Raj" with password as "Lol@123"
    And I select "ALL" from "dept_id"
    And I press "Search"
    Then I should see "Machine Learning"

  Scenario: I create a new private group with only person
    Given I am logged in as "Umang_Raj" with password as "Lol@123"
    And I fill in "room_name" with "Room with Chinmay"
    And I select "Yes" from "room_private_room"
    And I select "Chinmay Garg" from "room_selected_users"
    And I press "Create Room"
    Then "Chinmay_Garg" with password as "Password@123" should see a new room named "Room with Chinmay"
    And "Sounak_Ray" with password as "Password@321" should not see a new room named "Room with Chinmay"
    And "Harrison_Groll" with password as "Lol@321" should not see a new room named "Room with Chinmay"