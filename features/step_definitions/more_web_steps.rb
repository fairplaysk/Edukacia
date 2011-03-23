Then /^I should not see image "([^"]*)"$/ do |alt|
  if page.respond_to? :should
    page.should have_no_xpath("//img[@alt = '#{alt}']")
  else
    assert page.has_no_xpath?("//img[@alt = '#{alt}']")
  end
end
