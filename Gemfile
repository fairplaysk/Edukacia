source 'http://rubygems.org'

gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', "~> 0.2.0"

gem 'jquery-rails'
gem "formtastic", "1.2.4"
gem 'compass', ">= 0.10.4"
gem 'haml-rails'
gem 'paperclip'
gem 'devise'
gem 'hpricot'
gem 'html5-boilerplate'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'formtastic_datepicker_inputs'
gem 'rake'
gem 'newrelic_rpm', '>= 3.1.1.beta3'
gem 'sass'

# pretty up the rails console
gem 'awesome_print', :require => 'ap'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# bundle with '--without macosx' if you are not not a good system :)
group :developemnt, :macosx do
  gem 'rb-fsevent', :require => false 
  gem 'growl'
end

group :development do
	gem 'bullet'
	gem 'rails_best_practices'
	gem "rails-erd"
	gem 'capistrano'
end

group :development, :test do
	gem 'cucumber-rails'
	gem 'rspec-rails'
	gem 'mocha'
	gem 'capybara', :git => 'https://github.com/jnicklas/capybara.git'
	gem 'database_cleaner'
	gem 'spork', '>= 0.9.0.rc2'
	gem 'launchy'    # So you can do Then show me the page
	gem 'factory_girl_rails'
	
	gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-cucumber'
  gem 'guard-spork'
end