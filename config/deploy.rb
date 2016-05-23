# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'beta.digitalnz.org'
set :repo_url, 'https://github.com/DigitalNZ/supplejack_website'

set :rbenv_type, :system
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, ->() {"RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"}

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/files',
  'public/assets',
  'client/node_modules'
)

set :bundle_binstubs, -> { release_path.join('bin') }

set :runner, "deployer"
set :runner_group, "www-data"

set :dnz_component, 'kereru'

set :npm_target_path, -> { release_path.join('client') }
set :npm_flags, '--silent --no-progress'

set :config_folder, '/data/sites/beta.digitalnz.org/conf'
