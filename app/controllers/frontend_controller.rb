# frozen_string_literal: true

class FrontendController < ApplicationController
  skip_before_action :authenticate_user!

  ROUTES = %i(home)

  ROUTES.each do |method|
    define_method method do
      render
    end
  end
end
