server 'dnz0a.digitalnz.org', user: 'deployer', roles: %w{app db web}

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, '/data/sites/beta.dnz0a.digitalnz.org/rails'
set :rails_env, 'staging'
set :httpdocs, '/data/sites/beta.dnz0a.digitalnz.org/httpdocs'

# FIXME: The site should be moved on staging so it's the same path as production
set :config_folder, '/data/sites/beta.dnz0a.digitalnz.org/conf'
