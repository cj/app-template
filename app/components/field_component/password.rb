# frozen_string_literal: true
module FieldComponent
  class Password < Base
    def options
      { type: 'password', autocomplete: 'new-password' }.merge(super)
    end
  end
end
