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
		
	Scenario: Each question name must be filled in
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		When I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "Save"
		Then I should see "Questions content can't be blank"
		And I should see "Questions answers content can't be blank"