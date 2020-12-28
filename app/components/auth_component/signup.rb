# frozen_string_literal: true

module AuthComponent
  class Signup < Base
    attr_reader :user, :options

    def initialize(resource: User.new, **options)
      @user = resource
      @options = { turbo_id: turbo_id }.merge(options)
    end

    def submit(params = nil)
      @params = params if params

      if validate
        user.save
        sign_in(user)
      end
    end

    def user_params
      params[:user]&.permit(:name, :email, :password, :password_confirmation, :time_zone)
    end

    def validate
      user.assign_attributes(user_params)
      user.valid?
    end

    def before_render
      submit if user_params
    end
  end
end
