# frozen_string_literal: true

module FieldComponent
  class Base < AppComponent::Base
    attr_reader :name, :options, :value, :error_handler, :label_options, :label_id

    CLASSES = {
      base: %w(
        shadow-sm block w-full rounded-md
        sm:text-sm sm:leading-5
      ),
      no_error: %w(
        border-gray-300
        focus:ring-primary-500 focus:border-primary-500
      ),
      error: %w(
        text-red-900 placeholder-red-300 border-red-300
        focus:outline-none focus:ring-red-500 focus:border-red-500
      ),
    }.freeze

    # @param name:               name of the field
    # @param value:              value for input
    # @param label: {}:          {LabelComponent::Base}
    # @param error_handler: nil: method that handles errors, returns message
    # @param **options:          {ActionView::Helpers::FormTagHelper#text_field_tag}
    # @return: ViewComponent
    def initialize(name, value, label: {}, error_handler: nil, **options)
      @name = name
      @value = value
      @options = options
      @error_handler = error_handler
      @label_options = { has_error: has_error }.merge(label)
      @label_id = label_options[:id] || options[:id]

      # Used for accessibility
      @options[:id] = Nanoid.generate unless options.key?(:id)

      @options[:class] = Base.merge_classes(
        CLASSES[:base],
        CLASSES[has_error ? :error : :no_error],
        @options[:class],
      )
    end

    def error_message
      error_handler&.call(name)
    end

    def has_error
      error_message.present?
    end
  end
end
