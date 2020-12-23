# frozen_string_literal: true

module DeviseComponent
  class Base < AppComponent::Base
    include Devise::Controllers::Helpers
    # def self.field_error_handler(name:, context:, **)
    #   context.helpers.rodauth.field_error(name)
    # end
    def resource_name
      "user"
    end

    def resource_class
      ::User
    end

    # :reek:UtilityFunction
    def devise_mapping
      Devise::Mapping.new(:user, {})
    end
  end
end
