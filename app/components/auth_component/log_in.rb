# frozen_string_literal: true

module AuthComponent
  class LogIn < Base
    include Devise::Controllers::Helpers

    attr_reader :email, :options

    def initialize(**options)
      @email = nil
      @options = options
    end

    def submit
      validate
    end

    def user_params
      return unless params[:user]

      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def validate
      @email = user_params[:email]

      user = User.find_for_authentication(email: email)

      if user&.valid_password?(user_params[:password])
        sign_in(:user, user)

        controller.redirect_to(secure_path)
      else
        flash[:error] = t("devise.failure.invalid", authentication_keys: Devise.authentication_keys.join(" "))
      end
    end

    def before_render
      return unless user_params

      validate
    end
  end
end
