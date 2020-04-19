# fightingcovid server needs to be set up in your ~/.ssh/config file
server 'fightingcovid', user: 'deployuser', roles: %w{web app db}

set :deploy_to, '/var/www/fightingcovid'
set :containers, %w(fighting_covid_backend fighting_covid_database)

namespace :custom do
  task :setup_container do
    on roles(:web) do |host|
      puts "================Starting Docker setup===================="
      # Working directory hack
      # https://stackoverflow.com/questions/19452983/capistrano-3-execute-within-a-directory
      # https://stackoverflow.com/questions/758774/capistrano-bash-ignore-command-exit-status

      # build the new project
      execute "cd #{fetch(:deploy_to)}/current; docker-compose build; true"

      # kill the existing containers
      execute "cd #{fetch(:deploy_to)}/current; docker kill #{fetch(:containers).join(' ')}; true"
      # execute "cd #{fetch(:deploy_to)}/current; docker-compose down; true"
      execute "cd #{fetch(:deploy_to)}/current; docker rm #{fetch(:containers).join(' ')}; true"

      # restart
      # execute "cd #{fetch(:deploy_to)}/current; docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d"
      execute "cd #{fetch(:deploy_to)}/current; docker-compose -f docker-compose.yml run backend bundle exec rake webpacker:compile"
      execute "cd #{fetch(:deploy_to)}/current; docker-compose -f docker-compose.yml up -d"
      execute "docker network prune -f"

      # Run the daemons
      # execute "cd #{fetch(:deploy_to)}/current; sudo docker-compose run -d web bundle exec rake yield_curve_snapshots:run_update_daemon"
    end
  end
end

after "deploy:published", "custom:setup_container"