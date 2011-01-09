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
		
	Scenario: Listing quizzes in slovak
		Given the following "quiz" factory_girl models:
		 | name                         |
		 | Chalenging history questions |
		And I am a new, authenticated user
		And I follow "Slovenčina"
		When I am on the backend quizzes list page
		Then I should see "Zoznam Kvízov"
		And I should see "Názov"
		And I should see "Ukázať"
		And I should see "Upraviť"
		And I should see "Dodatočné otázky"
		And I should see "Zmazať"
		And I should see "Vytvoriť nový kvíz"
		
  Scenario: Click on English locale
		Given I am a new, authenticated user
		And I am on the homepage
		When I follow "English"
		Then I should see "Submissions"
		And I should see "Quizzes"
		And I should see "Users"