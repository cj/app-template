# frozen_string_literal: true

module FieldComponent
  class Checkbox < Base
    def options
      {
        class: %w(form-check-input),
      }.deeper_merge(super)
    end

    def label_options
      {
        class: %w(form-check-label),
      }.deeper_merge(super)
    end

    def checked
      value.present?
    end
  end
end
