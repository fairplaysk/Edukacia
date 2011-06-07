Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)" and username "([^\"]*)"$/ do |email, password, username|
  User.create(:email => email, :username => username, :password => password, :super => true)
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  username = 'testing'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}" and username "#{username}"}
  And %{I am not authenticated}
  And %{I follow "English"}
  And %{I go to login}
  And %{I fill in "Login" with "#{username}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end