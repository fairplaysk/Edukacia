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
		
	Scenario: Quiz form in slovak
		Given I am a new, authenticated user
		And I follow "Slovenčina"
		When I am on the backend quizzes list page
		And I follow "Vytvoriť nový kvíz"
		Then I should see "Nový kvíz"
		And I should see "Názov"
		And I should see "Komentár"
		And I should see "Kategórie"
		And I should see "Sponzor"
		And I should see "Vtipný komentár"
		And I should see "Grafika"
		And I should see "Komentár k hodnoteniu"
		And I should see "Zrušiť"
		
	Scenario: Listing users in slovak
		Given I am a new, authenticated user
		And I follow "Slovenčina"
		When I am on the backend users list page
		Then I should see "Zoznam používateľov"
		And I should see "Používateľské meno"
		And I should see "Email"
		And I should see "Zobraziť"
		And I should see "Upraviť"
		And I should see "Vytvoriť nového používateľa"
		
  Scenario: Click on English locale
		Given I am a new, authenticated user
		And I am on the homepage
		When I follow "English"
		Then I should see "Submissions"
		And I should see "Quizzes"
		And I should see "Users"