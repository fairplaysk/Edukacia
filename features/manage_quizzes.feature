Feature: Manage quizzes
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new quiz
    Given the following "category" factory_girl models:
		 | name       |
		 | category 1 |
		 | category 2 |
		And I am on the new quiz page
    When I fill in "Name" with "name 1"
		And I fill in "Comment" with "comment 1"
		And I select "category 1" from "Categories"
		And I fill in "Sponsor" with "sponsor 1"
		And I fill in "Content" with "placement comment 1" within "/html/body/form/fieldset/ol/fieldset[1]"
		And I fill in "Content" with "placement comment 2" within "/html/body/form/fieldset/ol/fieldset[2]"
		And I fill in "Content" with "placement comment 3" within "/html/body/form/fieldset/ol/fieldset[3]"
		And I fill in "Content" with "placement comment 4" within "/html/body/form/fieldset/ol/fieldset[4]"
		And I fill in "Funny comment" with "something funny for the wize guy."
		# And I fill in "Question" with "question 1"
		# And I fill in "Answer" with "answer 1"
    And I press "Save"
    Then I should see "name 1"
		And I should see "comment 1"
		And I should see "category 1"
		And I should see "sponsor 1"
		And I should see "placement comment 1"
		And I should see "placement comment 2"
		And I should see "placement comment 3"
		And I should see "placement comment 4"
		And I should see "something funny for the wize guy."
		
		# And I should see "question 1"
		# And I should see "answer 1"

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
    Given the following quizzes:
      | name   |
      | name 1 |
      | name 2 |
      | name 3 |
      | name 4 |
    When I delete the 3rd quiz
    Then I should see the following quizzes:
      | Name   |
      | name 1 |
      | name 2 |
      | name 4 |
