# frozen_string_literal: true

module AuthComponent
  class Signup < Base
    attr_reader :user, :options

    def initialize(resource: User.new, **options)
      @user = resource

      super(options)
    end

    def submit(params = nil)
      @params = params if params

      if valid? && user.save
        sign_in(user)

        controller&.redirect_to(secure_path)
      end
    end

    def user_params
      params[:user]&.permit(:name, :email, :password, :password_confirmation, :time_zone)
    end

    def valid?
      user.assign_attributes(user_params)
      user.valid?
    end

    def before_render
      submit if user_params
    end
  end
end
