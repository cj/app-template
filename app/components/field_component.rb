# frozen_string_literal: true

class FieldComponent < ViewComponent::Base
  attr_reader :name, :value

  def initialize(name, value, **options)
    @name = name
    @value = value
    @text_field_options = options
  end

  def text_field_options
    classes = [
      'shadow-sm focus:ring-primary-500 focus:border-primary-500 block w-full sm:text-sm border-gray-300 rounded-md',
      @text_field_options[:class],
    ]

    @text_field_options.merge(class: classes.join(' '))
  end
  private :text_field_options
end
