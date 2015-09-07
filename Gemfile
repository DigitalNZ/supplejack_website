# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

source 'https://rubygems.org'

if RUBY_VERSION =~ /2/
  group :development do
    gem 'better_errors'
    gem 'pry-rails'
  end

  group :development, :test do
    gem 'pry-byebug'
  end
end

gem 'rails', '~> 4.1.0'
gem 'supplejack_client', git: 'https://github.com/DigitalNZ/supplejack_client.git'

gem 'mysql2'
gem 'json'
gem 'will_paginate'
gem 'jquery-rails'
gem 'activeresource'
gem 'devise'

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
  gem 'pry-rails'
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
  gem 'faker'
end

group :production do
  gem 'therubyracer'
end

