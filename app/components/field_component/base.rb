# frozen_string_literal: true

module FieldComponent
  class Base < AppComponent::Base
    attr_reader :name, :options, :value, :error_handler, :label_options, :label_id, :size, :error_message

    CLASSES = {
      base: %w(form-control),
      error: %w(is-invalid is-server-error),
      no_error: %w(is-valid),
    }.freeze

    # @param name:               name of the field
    # @param value:              value for input
    # @param label: {}:          {LabelComponent::Base}
    # @param error_handler: nil: method that handles errors, returns message
    # @param **options:          {ActionView::Helpers::FormTagHelper#text_field_tag}
    # @return: ViewComponent
    def initialize(name, value = nil, label: {}, size: nil, error_handler: nil, **opts)
      @name = name
      @value = value
      @size = size
      @error_handler = error_handler
      @label_options = { has_error: has_error }.merge(label)

      @options = opts.merge(
        # Used for accessibility
        id: label_options[:id] || Base.generate_id,
      )
    end

    def base_classes
      @base_classes ||= CLASSES[:base]
    end

    def size_classes
      @size_classes ||= size ? "form-control-#{size}" : nil
    end

    def error_classes
      @error_classes ||= CLASSES[error_message ? :error : (value && :no_error)]
    end

    def has_error
      error_message.present?
    end

    def before_render
      if error_handler
        @error_message = error_handler.constantize&.field_error_handler({ name: name, value: value, context: self })
      end

      @options = @options.merge(
        class: Base.merge_classes(
          base_classes,
          error_classes,
          @options[:class],
        ),
        'aria-invalid': has_error,
        data: [*@options[:data], *{
          'error-field-name': label_options[:text],
        }].to_h,
      )
    end
  end
end
