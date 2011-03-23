Feature: Manage questions
  In order to add questions to a quiz
  An administrator
  wants to add questions with answers to a quiz
  
  Scenario: Show quiz info on the questions page
		Given the following "quiz" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		Then I should see "Chalenging history questions"

  Scenario: Register new question
    Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I follow "English"
		And I am editing question for the first quiz
		And I fill in "Question" with "question 1"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='answer_container'][1]"
		And I choose "quiz[questions_attributes][0][answers_attributes][is_correct]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='answer_container'][2]"
		And I choose "quiz[questions_attributes][0][answers_attributes][is_funny]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='answer_container'][4]"
		And I press "Save"
		Then I should see "Successfully updated questions for this quiz."
		And I should see "answer 1"
		And I should see "answer 2"
		And I should see "answer 3"
		And I should see "answer 4"
		
	Scenario: Add questions and answers saves everything
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "+ Question"
		And I fill in "Question" with "question 1" within "//fieldset[@class='question_container'][1]"
		And I fill in "Comment" with "comment 1" within "//fieldset[@class='question_container'][1]"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I fill in "Question" with "question 1" within "//fieldset[@class='question_container'][2]"
		And I fill in "Comment" with "comment 1" within "//fieldset[@class='question_container'][2]"
		And I press "+" within "//fieldset[@class='question_container'][2]"
		And I press "+" within "//fieldset[@class='question_container'][2]"
		And I press "+" within "//fieldset[@class='question_container'][2]"
		And I press "+" within "//fieldset[@class='question_container'][2]"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][4]"

  Scenario: Add graphic to question
   Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I fill in "Question" with "question"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I attach the file "features/support/files/web_sketch_v3.png" to "Graphic"
		And I choose "Correct"
		And I press "Save"
		Then I should not see "error"
		
	Scenario: Select 15 questions per page
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I fill in "Question" with "question"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I choose "Correct"
		And I select "15" from "Questions per page"
		And I press "Save"
		Then I should see "Questions per page: 15"
		
	Scenario: Show comment in quiz summary page
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I fill in "Question" with "question"
		And I fill in "Comment" with "comment for question 1"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I choose "Correct"
		And I select "15" from "Questions per page"
		And I press "Save"
		Then I should see "comment for question 1"
		
	Scenario: Each question name must be filled in
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "Save"
		Then I should see "Questions content can't be blank"
		And I should see "Questions answers content can't be blank"
		
	Scenario: Defaults to 99 in the question order box
		Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		Then the "Position" field should contain "99"
		
	Scenario: Order questions
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		And I fill in "Position" with "1"
		And I fill in "Question" with "question"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I choose "Correct"
		And I press "Save"
		Then I should see "Position: 1"
		
	Scenario: There cannot be more than one Question with the same position
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "+ Question"
		And I fill in "Position" with "1" within "//fieldset[@class='question_container'][1]"
		And I fill in "Position" with "1" within "//fieldset[@class='question_container'][2]"
		And I press "Save"
		Then I should see "Positions have to be unique"
		
  Scenario: There can be more than one Question with the 99 position
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "+ Question"
		And I fill in "Position" with "99" within "//fieldset[@class='question_container'][1]"
		And I fill in "Position" with "99" within "//fieldset[@class='question_container'][2]"
		And I press "Save"
		Then I should not see "Positions have to be unique"
		
	Scenario: Once a quiz is published allow only adding answers to questions
	  Given the following "quiz" factory_girl models:
		 | name | is_active | published_at |
		 | quiz | true      | 1-1-2010       |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		Then I should not be able to edit "Question"
		And I should not be able to edit "Comment"
		And I should not be able to edit "Answer"
		And I should not be able to edit "Correct"
		And I should not see "-" button
		And I should see "+" button
		And I should not see "+ Question"
		And I should not see "- Question"
