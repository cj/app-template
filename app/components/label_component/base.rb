# frozen_string_literal: true

module LabelComponent
  class Base < AppComponent::Base
    attr_reader :id, :text, :options, :has_error

    CLASSES = %w(form-label).freeze

    def initialize(id, text: nil, has_error: false, **options)
      @id = id
      @text = text
      @options = options
      @has_error = has_error

      @options[:class] = Base.merge_classes(
        CLASSES,
        error_classes,
        @options[:class],
      )
    end

    def error_classes
      if has_error
        %w(text-red-600)
      else
        []
      end
    end
  end
end
