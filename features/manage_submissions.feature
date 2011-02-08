Feature: Manage submissions
  In order to take a quiz
  A guest
  wants to fill out a quiz and see results
  
  Scenario: Fill out a quiz
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 5"
		And I press "Submit"
		
	Scenario: Show quiz summary page if a quiz was previously submitted
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Submit"
		And I go to the submissions page
		And I follow "last submission"
		Then I should see image with "True" alt
		Then I should see image with "False" alt
	