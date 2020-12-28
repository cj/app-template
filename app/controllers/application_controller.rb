# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetLocale
  include Users::TimeZone

  before_action :check_for_spam

  before_action :authenticate_user!

  add_flash_types :alert, :notice, :info, :error, :warning

  protect_from_forgery with: :exception

  def check_for_spam
    # This trick is for Turbo forms so that it persists the flash error twice.
    if session[:spam_redirect]
      flash[:error] = flash[:error]
      session.delete(:spam_redirect)
    end

    return if request.method == "GET"

    detect_spam(on_timestamp_spam: :handle_spam)
  end

  def handle_spam
    session[:spam_redirect] = true

    redirect_back(fallback_location: root_path, flash: {
      error: InvisibleCaptcha.timestamp_error_message,
    })
  end
end
