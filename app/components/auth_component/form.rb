# frozen_string_literal: true

module AuthComponent
  class Form < FormComponent::Base
    def options
      super.merge({ field_error_handler: "AuthComponent::Base" })
    end
  end
end
