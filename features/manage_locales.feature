Feature: Manage locales
  In order to change the language
  A guest
  wants to click on a language changer
  
  Scenario: Click on Slovak locale
		Given I am a new, authenticated user
		And I am on the homepage
		When I follow "Slovenčina"
		Then I should see "Odovzdania"
		And I should see "Kvízy"
		And I should see "Používatelia"
		
  Scenario: Click on English locale
		Given I am a new, authenticated user
		And I am on the homepage
		When I follow "English"
		Then I should see "Submissions"
		And I should see "Quizzes"
		And I should see "Users"