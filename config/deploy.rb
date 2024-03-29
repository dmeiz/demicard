require 'bundler/capistrano'
load 'deploy/assets'

@rails_env = ENV['RAILS_ENV'] || 'stage'
@branch = ENV['BRANCH'] || 'master'

ssh_options[:forward_agent] = true

set :application, 'demicard'
set :repository, 'git@github.com:dmeiz/demicard.git'

# If you have previously been relying upon the code to start, stop 
# and restart your mongrel application, or if you rely on the database
# migration code, please uncomment the lines you require below

# If you are deploying a rails app you probably need these:

# load 'ext/rails-database-migrations.rb'
# load 'ext/rails-shared-directories.rb'

# There are also new utility libaries shipped with the core these 
# include the following, please see individual files for more
# documentation, or run `cap -vT` with the following lines commented
# out to see what they make available.

# load 'ext/spinner.rb'              # Designed for use with script/spin
# load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
# load 'ext/web-disable-enable.rb'   # Gives you web:disable and web:enable

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
# see a full list by running "gem contents capistrano | grep 'scm/'"

if @rails_env == 'stage'
  server "localhost:2222", :app, :web, :db, :primary => true
elsif @rails_env == 'production'
  server "demicard.methodhead.com", :app, :web, :db, :primary => true
else
  raise "Unexpected RAILS_ENV '#{@rails_env}'"
end

raise 'Can only deploy master to production!' if @rails_env == 'production' && @branch != 'master'
set :branch, @branch

set :use_sudo, false
set :user, 'deployer'
set :deploy_via, :remote_cache

after 'deploy:update_code', 'deploy:migrate'

namespace :deploy do
  desc "Restart application"  
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"  
  end
end

