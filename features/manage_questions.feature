Feature: Manage questions
  In order to add questions to a quiz
  An administrator
  wants to add questions with answers to a quiz
  
  Scenario: Show quiz info on the questions page
		Given the following "quiz" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		And I am editing question for the first quiz
		Then I should see "Chalenging history questions"

  Scenario: Register new question
    Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am editing question for the first quiz
		And I fill in "Question" with "question 1"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='answer_container'][1]"
		And I check "Correct" within "//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='answer_container'][2]"
		And I check "Funny" within "//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='answer_container'][4]"
		And I press "Save"
		Then I should see "Successfully updated questions for this quiz."
		And I should see "answer 1"
		And I should see "answer 2"
		And I should see "answer 3"
		And I should see "answer 4"
		
