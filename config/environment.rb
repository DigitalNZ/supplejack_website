# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

# Load the rails application
require File.expand_path('../application', __FILE__)

# Load local variables
if Rails.env.development?
  local_env = File.join(Rails.root.to_s, 'config', 'local_env.rb')
  load(local_env) if File.exists?(local_env)
end

# Initialize the rails application
Demo::Application.initialize!
