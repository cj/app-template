# frozen_string_literal: true

module AuthComponent
  class LogIn < Base
    attr_reader :user

    def initialize(resource: User.new, **options)
      @user = resource
      @options = options
    end

    def submit
      @user.assign_attributes(user_params)

      @user.valid?
    end

    def user_params
      params.require(:user).permit(:email, :password, :remember_me)
    end

    def options
      {
        url: session_path(resource_name),
        action: "post",
        data: {
          controller: "form-component--base",
          reflex: "submit->AuthComponent::SignUp#submit",
          key: key,
        },
      }.deep_merge(@options)
    end
  end
end
