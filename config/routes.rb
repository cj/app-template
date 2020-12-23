# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, only: []
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "test#foo"
  post "/", to: "test#foo"

  match "/login", to: "auth#log_in", via: :all
  match "/signup", to: "auth#sign_up", via: :all

  get "/secure", to: "test#secure"
end
