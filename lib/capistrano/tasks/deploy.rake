require 'stringio'
require 'rest-client'

namespace :deploy do
  DEPLOYMENT_DESCRIPTION_FILE = "./DEPLOYMENT_DESCRIPTION"

  before :updated, :load_correct_database_config
  before :updated, :link_tasks
  before :published, :reset_permissions
  before :published, :reset_deployment_permissions
  before :published, :restart_web_server

  desc 'Restarts Rails server'
  task :restart_web_server do
    on roles(:web), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Reset permissions of deployment folder'
  task :reset_deployment_permissions do
    on roles(:web) do
      execute "sudo chown -R #{fetch(:runner)}:root #{deploy_to}"
    end
  end

  desc 'Reset permissions of shared and current release path'
  task :reset_permissions do
    on roles(:web) do
      reset_permissions_sh = [shared_path, current_path].collect do |path|
        "sudo chown -R #{fetch(:runner)}:#{fetch(:runner_group)} #{path}; sudo chmod -R g+rw #{path}"
      end.join("; ")

      execute reset_permissions_sh
    end
  end

  desc 'Loads the correct database configuration for the current stage'
  task :load_correct_database_config do
    stage = fetch(:rails_env, "production")

    on roles(:web) do
      execute %{echo "-----> Copying database.yml for #{stage}"}
      execute "if [ -f \"#{shared_path}/database.yml.#{stage}\" ]; then cp #{shared_path}/database.yml.#{stage} ./config/database.yml; fi"
      execute "if [ -f \"#{release_path}/config/database.yml.#{stage}\" ]; then cp #{release_path}/config/database.yml.#{stage} #{release_path}/config/database.yml; fi"
    end
  end

  desc "Performs required linking steps"
  task :link_tasks do
    invoke 'deploy:link_httpdocs'
  end

  desc "Links public folder to httpdocs path"
  task :link_httpdocs do
    httpdocs = fetch(:httpdocs)

    if httpdocs
      on roles(:web) do
        execute "sudo rm -rf #{httpdocs} && sudo ln -s #{release_path}/public #{httpdocs}"
      end
    end
  end

  desc "Posts deployment information to dnz-changes app"
  task :payload do
    email = `git config user.email`.chomp
    component = fetch(:dnz_component)
    description = IO.read(DEPLOYMENT_DESCRIPTION_FILE)
    time = Time.now.getlocal('+13:00')
    environment = fetch(:rails_env)
    revision = `git rev-parse #{fetch(:branch)}`.chomp

    payload = {component: component, description: description, email: email, time: time, environment: environment, revision: revision}
    url = "http://changes.dnz0a.digitalnz.org/changes"
    puts '--------------------------------------------------------'
    puts payload
    puts '--------------------------------------------------------'
    RestClient::Request.execute(method: :post, url: url, payload: payload, user: "dnz_changes", password: "wac7iam3gom5hy7")

    `rm #{DEPLOYMENT_DESCRIPTION_FILE}`
  end

  desc "Ensures that DEPLOYMENT_DESCRIPTION is filled out"
  task :validate_deployment_description do
    unless File.exist? DEPLOYMENT_DESCRIPTION_FILE
      p "#{DEPLOYMENT_DESCRIPTION_FILE} must be filled out"
      exit 1
    end
  end
end
