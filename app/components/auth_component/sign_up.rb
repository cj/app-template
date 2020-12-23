# frozen_string_literal: true

module AuthComponent
  class SignUp < Base
    attr_reader :user, :options

    def initialize(resource: User.new, **options)
      @user = resource
      @options = { turbo_id: turbo_id }.merge(options)
    end

    def submit
      @user.assign_attributes(user_params)

      @user.valid?
    end

    def user_params
      return unless params[:user]

      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def before_render
      return unless user_params

      @user.assign_attributes(user_params)

      if @user.valid?
        @user.save
        sign_in(@user)
      end
    end
  end
end
