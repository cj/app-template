# frozen_string_literal: true

module ButtonComponent
  # Button Component
  class Base < AppComponent::Base
    attr_reader :options, :text, :size, :color, :variant

    CLASSES = { base: %w(btn) }.freeze

    OPTIONS = { type: "button" }.freeze

    def initialize(variant: "solid", size: nil, color: "primary", **opts, &block)
      @text = block.call
      @variant = variant.to_sym
      @color = color.to_sym
      @size = size
      @options = [*OPTIONS, *opts, *{
        class: Base.merge_classes(base_classes, color_classes, opts[:class]),
      }].to_h
    end

    def button
      button_tag(options) { text }
    end

    def color_classes
      @color_classes ||= "btn-#{color}"
    end

    def base_classes
      @base_classes ||= CLASSES[:base]
    end
  end
end
