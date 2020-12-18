# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "test#foo"

  get "/secure", to: "test#secure"
end
