Feature: Manage locales
  In order to change the language
  A guest
  wants to click on a language changer
  
  Scenario: Click on Slovak locale
		Given I am a new, authenticated user
		When I follow "Slovenčina"
		And I go to the backend quizzes list page
		Then I should see "Úvod"
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
	
	Scenario: Form errors in slovak
		Given I am a new, authenticated user
		And I follow "Slovenčina"
		When I am on the backend quizzes list page
		And I follow "Vytvoriť nový kvíz"
		And I press "Uložiť"
		Then I should see "Názov je povinná položka"
		And I should see "Vyskytli sa 2 chyby pri ukladaní formulára."
		
	Scenario: Questions and answers in slovak
		Given the following "quiz" factory_girl models:
		 | name |
		 | quiz |
		And I am a new, authenticated user
		When I follow "Slovenčina"
		And I am editing question for the first quiz
		Then I should see "Otázky pre quiz"
		And I should see "Otázka"
		And I should see "Komentár"
		And I should see "Odpoveď"
		And I should see "Správna"
		And I should see "Vtipná"
		
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
		When I follow "English"
		And I go to the backend quizzes list page
		Then I should see "Home"
		And I should see "Quizzes"
		And I should see "Users"
		
	Scenario: Submit a quiz in slovak
	  Given the following "quiz_with_questions" factory_girl models:
		 | name                         | questions_per_page | published_at | is_active |
		 | Chalenging history questions | 1                  | 2011-01-01   | true      |
		And I am on the submissions page
		And I follow "Slovenčina"
		And I am on the submissions page
		When I follow "Chalenging history questions"
		And I press "Preskočiť"
		And I choose "answer 5"
		And I press "Vyhodnotiť kvíz"
		Then I should see "Vyhodnotenie kvízu"
		And I should see image with "True" alt
		And I should see image with "False" alt
		And I should see "Správna odpoveď"
		
	Scenario: Click on locale change takes me back to where I was
	  Given I am on login page
	  And I follow "English"
	  Then I should be on the login page
		