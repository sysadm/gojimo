# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'gojimo.sladkowski.com'
set :deploy_user, 'gojimo'
set :repo_url, 'git@github.com:sysadm/gojimo.git'
set :scm, :git
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info
set :tests, []
set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets public/assets)

# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
