# frozen_string_literal: true

module FieldComponent
  class Checkbox < Base
    def options
      super.deeper_merge({
        class: %w(form-check-input),
      })
    end

    def label_options
      super.deeper_merge({
        class: %w(form-check-label),
      })
    end

    def checked
      value.present?
    end

    def before_render
      sap(options)
    end
  end
end
