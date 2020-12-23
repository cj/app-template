# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  add_flash_types :alert, :notice, :info, :error, :warning

  protect_from_forgery with: :exception
end
