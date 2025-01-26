# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  resources :items, only: %i[show]
  resources :tasks
  resources :cart_items, only: %i[index create destroy]

  patch 'cart_items/increase/:id', to: 'cart_items#increase', as: 'increase_cart_item'
  patch 'cart_items/decrease/:id', to: 'cart_items#decrease', as: 'decrease_cart_item'

  namespace :admin do
    resources :items, only: %i[index create show destroy update new edit]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
