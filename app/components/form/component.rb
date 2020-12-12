# frozen_string_literal: true

module Form
  # Component for handling forms
  class Component < ViewComponent::Base
    include ViewComponent::SlotableV2

    attr_reader :path, :params, :form_tag_options, :fields

    def initialize(path, params: {}, **form_tag_options)
      @path = path
      @params = params
      @form_tag_options = { method: :post }.merge(form_tag_options)
      @fields = []
    end

    %i[field email password].each do |method_name|
      define_method method_name do |name, value: params[name], **options|
        case method_name
        when 'email'
          options = { type: :email, autocomplete: 'email' }.merge(options)
        when 'password'
          options = { type: :password, autocomplete: 'new-password' }.merge(options)
        end

        fields.push(Field::Component.new(name, value, options))
      end
    end
  end
end
