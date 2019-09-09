# Load the Rails application.
require_relative 'application'

# Load local variables
if Rails.env.development?
  local_env = File.join(Rails.root.to_s, 'config', 'local_env.rb')
  load(local_env) if File.exists?(local_env)
end

# Initialize the Rails application.
Rails.application.initialize!
