Feature: Manage quizzes
  In order to have quizzes defined
  An administrator 
  wants to be able to login and manage quizzes
  
  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript
  Scenario: Register new quiz
    And the following "category" factory_girl models:
		 | name       |
		 | category 1 |
		 | category 2 |
		And I am a new, authenticated user
		And I am on the new quiz page
    When I fill in "Name" with "name 1"
		And I fill in "Comment" with "comment 1"
		And I select "category 1" from "Categories"
		And I fill in "Sponsor" with "sponsor 1"
		And I fill in "Placement comment" with "placement comment 1" within "//fieldset[@class='placement_comment_container'][1]"
		And I fill in "Placement comment" with "placement comment 2" within "//fieldset[@class='placement_comment_container'][2]"
		And I fill in "Placement comment" with "placement comment 3" within "//fieldset[@class='placement_comment_container'][3]"
		And I fill in "Placement comment" with "placement comment 4" within "//fieldset[@class='placement_comment_container'][4]"
		And I fill in "Funny comment" with "something funny for the wize guy."
    And I press "Save"
		Then I should see "Successfully saved quiz. Please fill out questions for the quiz next."
		And I should see "Question"
	
  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript	
  Scenario: Edit a quiz should take me to questions edit page
		Given the following "quiz" factory_girl models:
		 | name  |
		 | quiz1 |
		And I am a new, authenticated user
		When I edit the 1st quiz
		And I press "Save"
		Then I should see "Successfully updated quiz. Please fill out questions for the quiz next."
		And I should see "Question"
		
	Scenario: Add additional placement comment
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I press "+"
		And I fill in "Placement comment" with "placement comment 5" within "//fieldset[@class='placement_comment_container'][5]"
		And I press "Save"
		Then the "Placement comment" field within "//fieldset[@class='placement_comment_container'][5]" should contain "placement comment 5"
		
	Scenario: Cannot add more than 6 placement comments
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I press "+"
		And I press "+"
		And I press "+"
		Then the page should not contain xpath "//fieldset[@class='placement_comment_container'][7]"
		
	Scenario: Remove additional placement comments
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I press "-"
		Then the page should not contain xpath "//fieldset[@class='placement_comment_container'][4]"
		
	Scenario: Cannot remove and have less than 3 placement comments
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I press "-"
		Then I should not see "-" within "//fieldset[@class='placement_comment_container']"

  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript
	Scenario: Add additional placement comment while editing quiz
		Given the following "quiz" factory_girl models:
		 | name   |
		 | quiz 1 |
		And I am a new, authenticated user
		When I edit the 1st quiz
		And I press "+"
		And I fill in "Placement comment" with "placement comment 5" within "//fieldset[@class='placement_comment_container'][5]"
		And I fill in "Name" with ""
		And I press "Save"
		Then the "Placement comment" field within "//fieldset[@class='placement_comment_container'][5]" should contain "placement comment 5"
	
  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript 
	Scenario: Remove additional placement comments
		Given the following "quiz" factory_girl models:
		 | name   |
		 | quiz 1 |
		And I am a new, authenticated user
		When I edit the 1st quiz
		When I press "-"
		# FIXME: replace the last line with this one when removing @javascript
    # Then the page should not contain xpath "//fieldset[@class='placement_comment_container'][4]"
    Then the page should not contain xpath "//fieldset[@class='placement_comment_container' and @style='display:none;']"
    # Then I should not see "Placement comment" within "//fieldset[@class='placement_comment_container'][4]"
		
	Scenario: Submit with validation failures should not disrupt placement comments
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I press "Save"
		Then I should see "Placement comment" within "//fieldset[@class='placement_comment_container'][1]"
		And I should see "Placement comment" within "//fieldset[@class='placement_comment_container'][2]"
		And I should see "Placement comment" within "//fieldset[@class='placement_comment_container'][3]"
		
	Scenario: Show errors when a blank form is submitted
	  Given I am a new, authenticated user
	  And I am on the new quiz page
		When I press "Save"
		Then I should see "Name can't be blank"
		
	Scenario: Specify additional information the user can fill out after submitting the quiz
		Given the following "quiz" factory_girl models:
		 | name   |
		 | quiz 1 |
		And I am a new, authenticated user
		And I am on the backend quizzes list page
		And I follow "Additional questions"
		And I fill in "Name" with "name"
		And I select "text" from "Input type"
		And I fill in "Values" with ""
		And I press "Save"
		Then I should see "Additional user questions successfully updated."
		
  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript	
	Scenario: Add published at date to quiz
    Given the following "quiz" factory_girl models:
		 | name   |
		 | quiz 1 |
		And I am a new, authenticated user
		And I edit the 1st quiz
		When I fill in "Published at" with "2010-02-28"
		And I press "Save"
		And I display the 1st quiz
		Then I should see "Published at: February 28, 2010"
	
  # FIXME: remove @javascript if/when they fix a bug with multiselect sending crap as category_ids "category_ids"=>["[\"1\"]"]
  @javascript
	Scenario: An active quiz must contain a publish date
	  Given the following "quiz" factory_girl models:
		 | name   |
		 | quiz 1 |
		And I am a new, authenticated user
		And I edit the 1st quiz
		And I check "Is active"
		And I press "Save"
		Then I should see "An active quiz must have a published date"
		
  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete quiz
    Given the following "quiz" factory_girl models:
      | name   |
      | name 1 |
      | name 2 |
      | name 3 |
      | name 4 |
		And I am a new, authenticated user
    When I delete the 3rd quiz
    Then I should see the following quizzes:
      | Name   |
      | name 1 |
      | name 2 |
      | name 4 |
