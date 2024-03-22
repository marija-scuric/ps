# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  resources :genres
  get "signup" => "users#new"
  resources :users
  root "movies#index"
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
end
