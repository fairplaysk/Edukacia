Given /^the following questions:$/ do |questions|
  Question.create!(questions.hashes)
end

Given /^I am editing question for the first quiz$/ do
  visit kwizzer_quiz_questions_path(Quiz.first)
end


When /^I delete the (\d+)(?:st|nd|rd|th) question$/ do |pos|
  visit kwizzer_questions_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following questions:$/ do |expected_questions_table|
  expected_questions_table.diff!(tableish('table tr', 'td,th'))
end

Then /^I should not be able to edit "([^"]*)"$/ do |label|
  field_disabled = find_field(label)['disabled']
  if field_disabled.respond_to? :should
    field_disabled.should be_true, 'The field was not disabled'
  else
    assert field_disabled
  end
end

Then /^I should not see "([^"]*)" button$/ do |label|
  has_no_button?(label).should be_true
end

Then /^I should see "([^"]*)" button$/ do |label|
  has_button?(label).should be_true
end

