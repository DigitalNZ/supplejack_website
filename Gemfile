# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are
# third party components that are licensed under the MIT license or other terms.
# See https://github.com/DigitalNZ/supplejack_website for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs.
# http://digitalnz.org/supplejack

source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'supplejack_client', git: 'https://github.com/DigitalNZ/supplejack_client.git'

gem 'mysql2', '~> 0.3.18'
gem 'json'
gem 'will_paginate'
gem 'jquery-rails'
gem 'lodash-rails'
gem 'activeresource'
gem 'devise'
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'haml', '~> 4.0.6'
gem 'haml-rails'
gem 'rubocop', require: false
gem 'therubyracer'
gem 'font-awesome-rails', '~> 4.3.0.0'
gem 'modernizr-rails'
gem "react_on_rails" 
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier', '>= 1.0.3'
gem 'foundation-rails', '~> 5.4.5.0'
gem 'airbrake', '~> 5.2'
gem 'figaro'
gem 'lograge'

group :development do
  gem 'better_errors'
  gem 'pry-rails'
  gem 'thin'
  gem 'quiet_assets'
  gem 'binding_of_caller'
  gem 'yard'
  gem 'rubocop-rspec'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.4'
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'capistrano-npm', '~> 1.0.2'
end

group :test, :development do
  gem 'spring-commands-rspec'
  gem 'spring'
  gem 'guard-rspec', require: false  
  gem "rspec-rails", "~> 3.0"
  gem 'oily_png'
  gem 'minitest'
  gem 'simplecov'
  gem 'ffaker',   '~> 2.1.0'
  gem 'pry-byebug'
end

group :test do
  gem 'webmock'
  gem 'factory_girl_rails', '~> 4.6'
  gem 'vcr', '~> 3.0'
  gem 'faker'
  gem 'rspec-activemodel-mocks'
  gem 'capybara'
  gem 'site_prism'
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "capybara-screenshot"
end
