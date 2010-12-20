Feature: Manage submissions
  In order to take a quiz
  A guest
  wants to fill out a quiz and see results
  
  Scenario: Fill out a quiz
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		When I take the 1st quiz
		And I choose "answer 1"
		And I press "Submit"
		Then I should see "1 correct answer(s)"
	
	@javascript
	Scenario: Show quiz summary page if a quiz was previously submitted
		Given a quiz with 2 questions and 4 answers for each question was created
		When I fill in and submit the 1st quiz
		Then I should see "2 correct answer(s)"
		
		