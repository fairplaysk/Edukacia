Feature: Manage submissions
  In order to take a quiz
  A guest
  wants to fill out a quiz and see results
  
  Background:
    Given I am on the homepage
    And I follow "English"
  
  Scenario: Fill out a quiz
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 2                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 5"
		And I press "Evaluate quiz"
		
	Scenario: Show quiz summary page if a quiz was previously submitted
		Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 2                  | 2011-01-01   | true      |
		And I am on the submissions page
		And there should be 0 submissions
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Evaluate quiz"
		And I go to the submissions page
		And I follow "Your result"
		Then there should be 1 submissions
		Then I should see image with "True" alt
		Then I should see image with "False" alt
		
	Scenario: Multiple submit pages for quiz
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 1                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I press "Next question"
		And I choose "answer 6"
		And I press "Evaluate quiz"
		Then there should be 1 submissions
		And I should see image with "True" alt
		And I should see image with "False" alt
		
	Scenario: Multiple submits by one user do not overwrite each other
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 2                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Evaluate quiz"
		And I am on the submissions page
		And I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Evaluate quiz"
		Then there should be 2 submissions
		
	Scenario: I do not select any answers and submit
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 2                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I press "Evaluate quiz"
		Then I should see "Please select an answer or click on \"Skip\""
	
	Scenario: I press the skip button and get to the results page
    Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 2                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I choose "answer 6"
		And I press "Skip"
  	Then I should see image with "False" alt
  
  Scenario: The form takes me to the correct evaluation page
    Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 1                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I press "Next question"
		And I press "Skip"
		Then there should be 1 submissions
		And I should see image with "True" alt
		And I should see image with "False" alt
		And I should see "You answered 1 out of 2 questions correctly."
		And I should see "50%"
		And I should see "0%"
		
	Scenario: Unpublished quizzes do not show up in the quiz list
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                                     | questions_per_page |
		 | Unpublished Chalenging history questions | 1                  |
	  And the following "quiz_with_questions" factory_girl models:
		 | name                                   | questions_per_page | published_at | is_active |
		 | Published Chalenging history questions | 1                  | 2011-01-01   | true      |
    When I go to the submissions page
    Then I should see "Published"
    And I should not see "Unpublished"
    
  Scenario: Homescreen links work
	  Given the following "quiz_with_category" factory_girl models:
		 | name                                   | questions_per_page | published_at | is_active |
		 | Published Chalenging history questions | 1                  | 2011-01-01   | true      |
		And I am on the homepage
		When I follow "category"
		Then I should see "Published Chalenging history questions"

  Scenario: Show placement comment for all correct answers on the summary
    When I submitted a quiz with all the right answers and am now on the summary page
    Then I should see "placement_comment 4"
  
  Scenario: Show placement comment for all incorrect answers on the summary
    When I submitted a quiz with all the wrong answers and am now on the summary page
    Then I should see "placement_comment 1"
    
  Scenario: Complete a random quiz
    Given the following "question_one_with_answers" factory_girl models:
      | random_enabled |
      | true           |
    When I go to the homepage
    And I follow "Random quiz"
    And I choose "answer 1"
    And I press "Evaluate quiz"
    Then I should see "100%"
    
  Scenario: Show only first 7 most popular categories on homepage
    Given 10 categories that have quizzes and submissions in ascending quantity
    And I am on the homepage
    And I should see "category 9"
    And I should see "category 8"
    And I should see "category 7"
    And I should see "category 6"
    And I should see "category 5"
    And I should see "category 4"
    And I should see "category 3"
    And I should not see "category 2"
    And I should not see "category 1"
    And I should not see "category 0"
    
  @javascript
  Scenario: Do not show missing when there is no image in the more info for a quetion on the summary page
    Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 1                  | 2011-01-01   | true      |
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I choose "answer 1"
		And I press "Next question"
		And I press "Skip"
	  And I follow "learn more"
	  Then I should not see image "Missing"
