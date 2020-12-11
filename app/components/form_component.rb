# frozen_string_literal: true

class FormComponent < ViewComponent::Base
  include ViewComponent::SlotableV2

  attr_reader :path, :params, :form_tag_options, :fields

  def initialize(path, params: {}, **form_tag_options)
    @path = path
    @params = params
    @form_tag_options = { method: :post }.merge(form_tag_options)
    @fields = []
  end

  def field(name, value: nil, **options)
    add_field(FieldComponent.new(name, value || params[name], options))
  end

  def email(name, value: nil, **options)
    add_field(FieldComponent.new(name, value || params[name], { type: :email, autocomplete: 'email' }.merge(options)))
  end

  def password(name, value: nil, **options)
    add_field(FieldComponent.new(name, value || params[name], {
      type: :password, autocomplete: 'new-password'
    }.merge(options)))
  end

  def add_field(field)
    fields.push(field)
  end
  private :add_field
end
