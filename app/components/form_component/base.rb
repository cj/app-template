# frozen_string_literal: true

module FormComponent
  # Component for handling forms
  class Base < AppComponent::Base
    attr_reader :resource, :scope, :url, :params, :base_options, :field_options, :fields, :classes, :count

    CLASSES = %w(d-flex flex-column)

    ALLOWED_INPUT_TYPES = %i(text email password checkbox)
    ALLOWED_BUTTON_TYPES = %i(button submit)

    def initialize(resource, scope: resource.class.name.downcase, **options)
      @resource = resource
      @scope = scope

      @classes = Base.merge_classes(
        CLASSES,
        # params.present? && "was-validated",
        options[:class],
      )

      @base_options = [*{ method: :post }, *options, *{
        novalidate: true,
        class: classes,
        model: resource,
        data: [*options[:data], *{ controller: "form-component--base" }].to_h,
      }].to_h

      @fields = []
    end

    def input(*args)
      render_input(*args)
    end

    def render_input(name, type: :text, **options)
      value = resource[name]

      possible_type = :"#{name.to_s.sub(/_.*/, "")}"

      # resource.type_for_attribute(name).type

      if ALLOWED_INPUT_TYPES.include?(possible_type)
        type = possible_type
      elsif !ALLOWED_INPUT_TYPES.include?(type)
        raise Exception.new("#{type} is not in the ALLOWED_INPUT_TYPES.")
      end

      component = "FieldComponent::#{type.to_s.classify}".constantize

      render(
        component.new([scope, name], value, {
          type: type,
          resource: resource,
        }.merge(options)),
      )
    end

    %i[checkbox].each do |method_name|
      define_method method_name do |name, **options, &block|
        render_input(name, options.merge(type: method_name.to_sym), &block)
      end
    end

    def button(type: :button, **options, &block)
      unless ALLOWED_BUTTON_TYPES.include?(type)
        raise Exception.new("#{type} is not in the ALLOWED_BUTTON_TYPES.")
      end

      component = "ButtonComponent::#{type.to_s.classify}".constantize

      render(component.new(options, &block))
    end

    # def before_render
    #   init_key
    #
    #   @base_options[:data] = @base_options[:data].merge(key: key)
    #
    #   @base_options
    # end
  end
end
