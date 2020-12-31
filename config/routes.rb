# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "frontend#home"

  post "/", to: "test#foo"

  devise_scope :user do
    get "confirmation", to: "auth#confirm"
    get "root", to: "test#secure"
  end

  devise_for :users, only: []

  namespace :user do
    root "test#secure"
  end

  AuthController::ROUTES.each do |route|
    match "/#{route}", to: "auth##{route}", via: :all
  end

  get "/secure", to: "test#secure"
end
