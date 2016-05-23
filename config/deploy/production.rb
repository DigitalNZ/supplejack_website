server 'dnz01', user: 'deployer', roles: %w{app db web}
server 'dnz02', user: 'deployer', roles: %w{app db web}
server 'dnz04', user: 'deployer', roles: %w{app db web}

set :rbenv_ruby, '2.3.0'
set :branch, 'master'
set :deploy_to, '/data/sites/beta.digitalnz.org/rails'
set :httpdocs, '/data/sites/beta.digitalnz.org/httpdocs'

set :config_folder, '/data/sites/beta.digitalnz.org/conf'

before 'deploy:finished', 'deploy:payload'
before 'deploy:starting', 'deploy:validate_deployment_description'
