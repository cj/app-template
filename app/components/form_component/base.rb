# frozen_string_literal: true

module FormComponent
  # Component for handling forms
  class Base < ViewComponent::Base
    include ViewComponent::SlotableV2

    attr_reader :path, :params, :options, :field_options, :fields

    def initialize(path, params: {}, field_error_handler: ->(*_args) {}, **options)
      @path = path
      @params = params
      @options = { method: :post }.merge(options)
      @field_options = { error_handler: field_error_handler }
      @fields = []
    end

    %i[field email password button].each do |method_name|
      define_method method_name do |name, value: params[name], **options|
        fields.push("FieldComponent::#{method_name.to_s.classify}".constantize.new(
          name, value, field_options.merge(options)
        ))
      end
    end

    def submit(name, **options)
      fields.push(ButtonComponent::Submit.new(name, options))
    end
  end
end
