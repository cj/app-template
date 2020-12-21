# frozen_string_literal: true

module FieldComponent
  class Email < Base
    def base_options
      { type: "email", autocomplete: "email" }.merge(super)
    end
  end
end
