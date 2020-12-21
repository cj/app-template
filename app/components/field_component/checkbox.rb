# frozen_string_literal: true

module FieldComponent
  class Checkbox < Base
    def options
      super.deep_merge({
        class: "form-check-input",
      })
    end

    def label_options
      super.deep_merge({
        class: "form-check-label",
      })
    end

    def checked
      value.present?
    end
  end
end
