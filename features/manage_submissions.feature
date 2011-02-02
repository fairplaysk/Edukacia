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
		And I press "Submit"
		Then I should see "1 correct answer(s)"
	