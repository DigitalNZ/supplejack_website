# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'records#home'

  resources :records, only: %i[index show]

  resources :user_sets, only: %i[show create index] do
    resources :set_items, only: [:create]
  end

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/become_a_partner', to: 'static_pages#become_a_partner'
  get '/terms', to: 'static_pages#terms'
  get '/base_template', to: 'static_pages#base_template'
end
