# frozen_string_literal: true

module FormComponent
  # Component for handling forms
  class Base < AppComponent::Base
    attr_reader :resource, :parent_turbo_id, :scope, :url, :params, :base_options, :field_options, :fields, :classes,
:count

    CLASSES = %w(d-flex flex-column)

    ALLOWED_INPUT_TYPES = %i(text email password checkbox time_zone)
    ALLOWED_BUTTON_TYPES = %i(button submit)

    delegate :content_security_policy_nonce, to: :helpers

    def initialize(resource = nil, scope: resource.class.name.downcase, **options)
      @resource = resource
      @scope = scope
      @parent_turbo_id = options.fetch(:turbo_id)

      @classes = Base.merge_classes(
        CLASSES,
        # params.present? && "was-validated",
        options[:class],
      )

      data = [
        *options[:data],
        *{
          controller: "form-component--base",
          'turbo-frame': turbo_id,
        },
      ]

      @base_options = [*{ method: :post }, *options, *{
        novalidate: true,
        class: classes,
        model: resource,
        data: data.to_h,
      }].to_h

      @fields = []
    end

    def set_content_type
      return unless controller && request.headers["Accept"].include?("turbo-stream")

      controller.content_type = "text/html; turbo-stream"
    end

    def input(*args)
      render_input(*args)
    end

    def render_input(name, value: resource&.public_send(name), type: :text, **options)
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

    %i[checkbox time_zone].each do |method_name|
      define_method method_name do |name, **options, &block|
        render_input(name, options.merge(type: method_name), &block)
      end
    end

    %i[button submit].each do |method_name|
      define_method method_name do |type: method_name, **options, &block|
        component = "ButtonComponent::#{type.to_s.classify}".constantize

        render(component.new(options.merge({ type: type }), &block))
      end
    end

    def flash_messages
      # We do not want to render flash messages on initial load to avoid uplicate flash messages, we only want to
      # show the flash messages from the form submitted.
      return unless request.headers["Accept"].include?("turbo-stream")

      render(FlashComponent::Base.new)
    end

    def before_render
      @base_options[:url] ||= request.fullpath

      # set_content_type
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
