# frozen_string_literal: true
module AuthComponent
  class Confirm < Base
    attr_reader :options, :email, :user

    def submit(params = nil)
      @params = params if params

      @user = User.new(user_params)

      if user_params.present?
        handle_sending_confirmation
      elsif token_params.present?
        handle_token_confirm
      end
    end

    def handle_sending_confirmation
      User.send_confirmation_instructions(user_params)

      @user = User.new
    end

    def handle_token_confirm
      @user = User.confirm_by_token(token_params[:token])

      errors = user.errors

      if errors.empty?
        flash[:notice] = t(".email_confirmed")

        user.update_attribute(:confirmation_token, nil)

        controller&.redirect_to(
          after_confirmation_path_for(:user),
        )
      elsif errors.has_key?(:confirmation_token)
        flash[:error] = t(".invalid_token")
      end
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name)
      if signed_in?(resource_name)
        authenticated_path
      else
        login_path
      end
    end

    def user_params
      params[:user]&.permit(:email)
    end

    def token_params
      params.permit(:type, :token)
    end

    def before_render
      submit
    end
  end
end
