# frozen_string_literal: true

class AuthController < ApplicationController
  ROUTES = %i(login signup confirm)

  skip_before_action :authenticate_user!

  helper DeviseHelper

  helpers = %w(resource scope_name resource_name signed_in_resource
               resource_class resource_params devise_mapping)

  helper_method(*helpers)

  ROUTES.each do |method|
    define_method method do
      render
    end
  end

  def confirm
    render
  end
end
