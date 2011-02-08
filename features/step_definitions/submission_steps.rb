Given /^I create a new quiz$/ do
  Factory(:category, :name => 'category 1')
	And %{I am on the new quiz page}
  When %{I fill in "Name" with "name 1"}
	And %{I fill in "Comment" with "comment 1"}
	And %{I select "category 1" from "Categories"}
	And %{I fill in "Sponsor" with "sponsor 1"}
	And %{I fill in "Placement comment" with "placement comment 1" within "//fieldset[@class='placement_comment_container'][1]"}
	And %{I fill in "Placement comment" with "placement comment 2" within "//fieldset[@class='placement_comment_container'][2]"}
	And %{I fill in "Placement comment" with "placement comment 3" within "//fieldset[@class='placement_comment_container'][3]"}
	And %{I fill in "Placement comment" with "placement comment 4" within "//fieldset[@class='placement_comment_container'][4]"}
	And %{I fill in "Funny comment" with "something funny for the wize guy."}
  And %{I press "Save"}
end

Given /^a quiz "([^"]*)" with (\d+) questions and (\d+) answers for each question was created$/ do |quiz_name, questions_count, answers_per_question|
  Factory(:category)
  Given %{I create a new quiz}
  And %{I select "15" from "Questions per page"}
  (1..questions_count.to_i).each do |question_index|
    And %{I press "+ Question"} if question_index < questions_count.to_i
    And %{I fill in "Question" with "question #{question_index}" within "//fieldset[@class='question_container'][#{question_index}]"}
    # And %{show me the page}
    (1..answers_per_question.to_i).each do |answer_index|
    	And %{I fill in "Answer" with "answer #{answer_index}" within "//fieldset[@class='question_container'][#{question_index}]//fieldset[@class='answer_container'][#{answer_index}]"}
      And %{I choose "Correct" within "//fieldset[@class='question_container'][#{question_index}]//fieldset[@class='answer_container'][#{answer_index}]"} if answer_index.to_i == 1
    	And %{I choose "Funny" within "//fieldset[@class='question_container'][#{question_index}]//fieldset[@class='answer_container'][#{answer_index}]"} if answer_index.to_i == 2
	  end
	end 
	And %{I press "Save"}
	And %{I should see "Successfully updated questions for this quiz."}
end

Then /^I should see image with "([^"]*)" alt$/ do |alt|
  find(:xpath, "//img[@alt='#{alt}']")
end

Then /^there should be (\d+) submissions$/ do |count|
  Submission.count.should == count.to_i
end

