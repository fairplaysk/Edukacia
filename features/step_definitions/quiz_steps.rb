Given /^the following quizzes:$/ do |quizzes|
  Quiz.create!(quizzes.hashes)
end

When /^I edit the (\d+)(?:st|nd|rd|th) quiz$/ do |pos|
  visit kwizzer_quizzes_path
  within("//table//tr[#{pos.to_i+1}]") do
    click_link "Edit"
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) quiz$/ do |pos|
  visit kwizzer_quizzes_path
  within("//table//tr[#{pos.to_i+1}]") do
    click_link "Destroy"
  end
end

Then /^I should see the following quizzes:$/ do |expected_quizzes_table|
  expected_quizzes_table.diff!(tableish('table tr', 'td,th'))
end

Then /^the page should not contain xpath "([^"]*)"$/ do |xpath|
  page.should_not have_xpath(xpath)
end

