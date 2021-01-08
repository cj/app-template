# frozen_string_literal: true

class DashboardController < ApplicationController
  layout "dashboard"

  ROUTES = %i(index)

  ROUTES.each do |method|
    define_method method do
      render
    end
  end
end
