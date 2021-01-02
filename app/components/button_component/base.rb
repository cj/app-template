# frozen_string_literal: true

module ButtonComponent
  # Button Component
  class Base < AppComponent::Base
    attr_reader :options, :tag_name, :text, :size, :color, :variant

    CLASSES = {
      base: %w(btn),
    }.freeze

    OPTIONS = { type: "button" }.freeze

    def initialize(variant: "solid", tag: "button", size: nil, color: "primary", **opts, &block)
      @text = block.call
      @variant = variant.to_sym
      @color = color.to_sym
      @size = size
      @tag_name = tag
      @options = [*OPTIONS, *opts, *{
        class: Base.merge_classes(base_classes, color_classes, opts[:class]),
      }].to_h
    end

    def button
      tag.public_send(tag_name, options) { text }
    end

    def color_classes
      @color_classes ||= tag_name == "button" ? "btn-#{color}" : ""
    end

    def base_classes
      @base_classes ||= tag_name == "button" ? CLASSES[:base] : ""
    end
  end
end
