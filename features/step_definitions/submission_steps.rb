When /^I take the (\d+)(?:st|nd|rd|th) quiz$/ do |pos|
  visit root_path
  within("//table//tr[#{pos.to_i+1}]") do
    click_link "take quiz"
  end
end