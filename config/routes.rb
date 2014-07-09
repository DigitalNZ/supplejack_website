# The majority of The Supplejack Website code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components that are licensed under the MIT license or other terms. 
# See https://github.com/DigitalNZ/supplejack_website for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

Demo::Application.routes.draw do
  root to: 'records#home'
  resources :records, only: [:index, :show]

  match 'about', to: 'static_pages#about'
  match 'contact', to: 'static_pages#contact'
  match 'become_a_partner', to: 'static_pages#become_a_partner'
  match 'terms', to: 'static_pages#terms'
  match 'base_template', to: 'static_pages#base_template'
end