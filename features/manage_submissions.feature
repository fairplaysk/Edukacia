Feature: Manage submissions
  In order to take a quiz
  A guest
  wants to fill out a quiz and see results
  
  Scenario: Fill out a quiz
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page |
		 | Chalenging history questions | 2                  |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 5"
		And I press "Submit"
		
	Scenario: Show quiz summary page if a quiz was previously submitted
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page |
		 | Chalenging history questions | 2                  |
		And I am on the submissions page
		And there should be 0 submissions
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Submit"
		And I go to the submissions page
		And I follow "last submission"
		Then there should be 1 submissions
		Then I should see image with "True" alt
		Then I should see image with "False" alt
		
	Scenario: Multiple submit pages for quiz
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page |
		 | Chalenging history questions | 1                  |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I press "Next question"
		And I choose "answer 6"
		And I press "Submit"
		Then there should be 1 submissions
		And I should see image with "True" alt
		And I should see image with "False" alt
		
	Scenario: Multiple submits by one user do not overwrite each other
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page |
		 | Chalenging history questions | 2                  |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Submit"
		And I am on the submissions page
		And I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Submit"
		Then there should be 2 submissions
		
	Scenario: I do not select any answers and submit
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page |
		 | Chalenging history questions | 2                  |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I press "Submit"
		Then I should see "Please select an answer."
	
