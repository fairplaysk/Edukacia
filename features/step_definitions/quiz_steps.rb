Given /^the following quizzes:$/ do |quizzes|
  Quiz.create!(quizzes.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) quiz$/ do |pos|
  visit quizzes_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following quizzes:$/ do |expected_quizzes_table|
  expected_quizzes_table.diff!(tableish('table tr', 'td,th'))
end
