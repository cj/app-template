# frozen_string_literal: true

module AuthComponent
  class Base < DeviseComponent::Base
    include Devise::Controllers::Helpers
    # def self.field_error_handler(name:, context:, **)
    #   context.helpers.rodauth.field_error(name)
    # end

    def authenticated_path
      dashboard_path
    end
  end
end
