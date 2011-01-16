Feature: Manage categories
  In order to manage categories
  A registered user
  wants to list, create, update, show and delete categories
  
  Scenario: Register new category
    Given I am a new, authenticated user
    And I am on the new category page
    When I fill in "Name" with "name 1"
    And I fill in "Short name" with "short_name 1"
    And I press "Save"
    Then I should see "name 1"
    And I should see "short_name 1"

  Scenario: Delete category
    And the following "category" factory_girl models:
      | name   | short_name   |
      | category 1 | category_short_name 1 |
      | category 2 | category_short_name 2 |
      | category 3 | category_short_name 3 |
      | category 4 | category_short_name 4 |
    And I am a new, authenticated user
    When I delete the 3rd category
    Then I should see the following categories:
      | Name   | Short name   |
      | category 1 | category_short_name 1 |
      | category 2 | category_short_name 2 |
      | category 4 | category_short_name 4 |
