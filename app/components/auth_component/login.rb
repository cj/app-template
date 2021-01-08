# frozen_string_literal: true

module AuthComponent
  class Login < Base
    attr_reader :email, :options, :user

    def submit(params = nil)
      @params = params if params

      return user_errors unless valid?

      if user&.valid_password?(user_params[:password])
        sign_in(:user, user)

        controller&.redirect_to(dashboard_path)
      else
        user_errors
      end
    end

    def user_errors
      if controller
        controller.head(422)

        flash[:error] = {
          header: t(".error_header"),
          message: t(".invalid", authentication_keys: Devise.authentication_keys.join(" ")),
        }
      end

      user&.errors
    end

    def user_params
      params[:user]&.permit(:email, :password, :remember_me)
    end

    def valid?
      @email = user_params[:email]

      @user = User.find_for_authentication(email: email)

      user&.valid?
    end

    def before_render
      submit if user_params
    end
  end
end
