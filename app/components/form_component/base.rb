# frozen_string_literal: true

module FormComponent
  # Component for handling forms
  class Base < AppComponent::Base
    attr_reader :path, :params, :options, :field_options, :fields, :classes, :count

    CLASSES = %w()

    def initialize(path, params: {}, field_error_handler: nil, **opts)
      @clicked = false
      @path = path
      @params = params
      @classes = Base.merge_classes(
        CLASSES,
        # params.present? && "was-validated",
        opts[:class],
      )
      @options = [*{ method: :post }, *opts, *{
        novalidate: true,
        class: classes,
        field_error_handler: field_error_handler,
        data: [*opts[:data], *{ controller: "form-component--base" }].to_h,
      }].to_h
      @field_options = { error_handler: options[:field_error_handler] }
      @fields = []
      @count = 0
    end

    %i[base email password button].each do |method_name|
      component_name = method_name == :base ? "field" : method_name

      define_method component_name do |name = nil, value: params[name], **options, &block|
        fields.push(
          component: "FieldComponent::#{method_name.to_s.classify}".constantize,
          arguments: [name, value, field_options.merge(options)],
          content: block&.call,
        )
      end
    end

    %i[base submit].each do |method_name|
      component_name = method_name == :base ? "button" : method_name

      define_method component_name do |**options, &block|
        fields.push(
          component: "ButtonComponent::#{method_name.to_s.classify}".constantize,
          arguments: [options],
          content: block&.call,
        )
      end
    end

    def handle_click
      @clicked = true
      @count += 1

      refresh!("#testing-clicked")
    end
  end
end
