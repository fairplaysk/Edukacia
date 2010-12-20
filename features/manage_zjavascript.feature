Feature: Manage javascripts
  In order to take test javascript features
  A user
  wants to run javascript tests in a browser

	@javascript
	Scenario: Remove additional placement comments
		Given I am a new, authenticated user
		And I am on the new quiz page
		When I fill in "Placement comment" with "placement comment 1" within "//fieldset[@class='placement_comment_container'][1]"
		And I fill in "Placement comment" with "placement comment 2" within "//fieldset[@class='placement_comment_container'][2]"
		And I fill in "Placement comment" with "placement comment 3" within "//fieldset[@class='placement_comment_container'][3]"
		And I fill in "Placement comment" with "placement comment 4" within "//fieldset[@class='placement_comment_container'][4]"
		And I press "Remove placement comment"
		And I press "Save"
		Then I should not see "placement comment 4"
		And I should see "placement comment 1"
		And I should see "placement comment 2"
		And I should see "placement comment 3"

	@javascript
	Scenario: Show and hide answers for quiz question
		Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I follow "Show/Hide answers"
		Then the page should not contain xpath "//fieldset[style!='display:none']"
	
	@javascript
	Scenario: Add questions and answers saves everything
	  Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		And I am editing question for the first quiz
		And I press "Add question"
		And I fill in "Question" with "question 1" within "//fieldset[@class='question_container'][1]"
		And I fill in "Comment" with "comment 1" within "//fieldset[@class='question_container'][1]"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][1]//fieldset[@class='answer_container'][4]"
		And I fill in "Question" with "question 1" within "//fieldset[@class='question_container'][2]"
		And I fill in "Comment" with "comment 1" within "//fieldset[@class='question_container'][2]"
		And I press "Add answer" within "//fieldset[@class='question_container'][2]"
		And I press "Add answer" within "//fieldset[@class='question_container'][2]"
		And I press "Add answer" within "//fieldset[@class='question_container'][2]"
		And I press "Add answer" within "//fieldset[@class='question_container'][2]"
		And I fill in "Answer" with "answer 1" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][1]"
		And I fill in "Answer" with "answer 2" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][2]"
		And I fill in "Answer" with "answer 3" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][3]"
		And I fill in "Answer" with "answer 4" within "//fieldset[@class='question_container'][2]//fieldset[@class='answer_container'][4]"
		
	@javascript
	Scenario: Show quiz summary page if a quiz was previously submitted
		Given I am a new, authenticated user
		And a quiz "history" with 2 questions and 4 answers for each question was created
		When I fill in and submit the 1st quiz
		Then I should see "2 correct answer(s)"
		And I should see "answer 1 correct" within "//div[@class='result_container'][1]"
		And I should see "answer 2 incorrect" within "//div[@class='result_container'][2]"

	@javascript
	Scenario: Show result of a quiz
		Given I am a new, authenticated user
		And a quiz "healthcare" with 2 questions and 4 answers for each question was created
		When I fill in and submit the 1st quiz
		When I go to the homepage
		And I follow "show submission"