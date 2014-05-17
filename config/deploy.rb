set :application, "fictief"
set :repo_url, "git@github.com:nreynen/fictief.git"
set :scm, :git
set :branch, "master"
set :deploy_to, "/var/www/fictief"
set :user, "nreynen"
set :admin_runner, "nreynen"
set :runner, "nreynen"
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  
  # after :restart, :clear_cache do
    # on roles(:web), in: :groups, limit: 3, wait: 10 do
      # within release_path do
        # with :rails_env => :production do
          # execute :rake, 'memcached:flush'
        # end
      # end
    # end
  # end
  after :finishing, 'deploy:cleanup'
end