# frozen_string_literal: true

module FormComponent
  # Component for handling forms
  class Base < AppComponent::Base
    attr_reader :path, :params, :options, :field_options, :fields, :classes

    def initialize(path, params: {}, field_error_handler: nil, **opts)
      @clicked = false
      @path = path
      @params = params
      @classes = Base.merge_classes(opts[:class])
      @options = [*{ method: :post }, *opts, *{ class: classes }].to_h
      @field_options = { error_handler: field_error_handler }
      @fields = []
      @count = 0
    end

    %i[field email password button].each do |method_name|
      define_method method_name do |name, value: params[name], **options|
        fields.push(
          component: "FieldComponent::#{method_name.to_s.classify}".constantize,
          arguments: [name, value, field_options.merge(options)],
        )
      end
    end

    def submit(name, **options)
      fields.push(
        component: ButtonComponent::Submit,
        arguments: [name, options],
      )
    end

    def handle_click
      @clicked = true
      @count += 1

      refresh!("#testing-clicked")
    end
  end
end
