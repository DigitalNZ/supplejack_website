# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

source 'https://rubygems.org'

gem 'rails', '~> 4.1.0'
gem 'supplejack_client', git: 'git@github.com:DigitalNZ/supplejack_client.git'

gem 'json'
gem 'will_paginate'
gem 'jquery-rails'
gem 'activeresource'

group :assets do
  gem 'sass-rails',   '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'zurb-foundation', '~> 4.0.0'
end

group :development do
  gem 'thin'
  gem 'quiet_assets'
  gem 'binding_of_caller'
end

group :test, :development do
  gem "rspec-rails", "2.14"
  gem 'oily_png'
  gem 'minitest'
  gem 'simplecov'
end

group :test do
  gem 'webmock'
  gem 'factory_girl_rails', "= 1.2.0"
  gem 'spork', '>= 1.0.0rc3'
  gem 'vcr', '2.9.0'
end

group :production do
  gem 'therubyracer'
end

if RUBY_VERSION =~ /2/
  gem 'better_errors', group: :development
  gem 'byebug', group: :development
elsif RUBY_VERSION =~ /1.9/
  gem 'debugger', group: :development
end

