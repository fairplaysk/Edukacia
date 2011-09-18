# -*- encoding : utf-8 -*-
# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

require 'bundler/capistrano'

set :rvm_ruby_string, '1.9.2'

set :stages, %w(staging production)
set :application, "kwizzer"

set(:deploy_to) { "/var/rails/#{application}" }

set :scm, :git
set :repository, "git://github.com/fairplaysk/Edukacia.git"
set :use_sudo, false
set :keep_releases, 4

set(:user) { Capistrano::CLI.ui.ask "user:" }
server "195.210.29.138", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/config/google.yml #{release_path}/config/google.yml"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/initializers/secret_token.rb"
    run "ln -nfs #{shared_path}/public/system #{release_path}/public/system"
  end
  
  desc 'Add seed data'
  task :seed, :roles => :app do
    run "cd #{release_path}; rake db:seed RAILS_ENV=production"
  end
  
end

after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:migrate', 'deploy:seed'
