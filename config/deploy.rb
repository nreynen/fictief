require 'capistrano'
require "bundler/capistrano"

set :deploy_via, :remote_cache

set :application, "fictief"
set :deploy_to, "/var/www/#{application}"

role :app, "master.yato-extreme.com"
role :web, "master.yato-extreme.com"
role :db, "master.yato-extreme.com", :primary => true

set :port, 5555
set :branch, "master"

set :default_stage, "development"
set :stages, %w(production development)

set :repository, "git@github.com:nreynen/fictief.git"
#set :ssh_options, { :forward_agent => true }
set :scm, "git"

set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :user, "nreynen"
set :admin_runner, "nreynen"

set :runner, "nreynen"



namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

