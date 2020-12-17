# frozen_string_literal: true

module ButtonComponent
  # Button Component
  class Base < AppComponent::Base
    attr_reader :options, :size, :color, :variant

    CLASSES = {
      base: %w(btn btn-primary shadow-sm),
      color: {
        solid: color_hash { |color| %W(btn-#{color}) },
        outline: color_hash { |color| %W(btn-outline-#{color}) },
      },
    }.freeze

    OPTIONS = { type: "button" }.freeze

    def initialize(variant: "solid", size: nil, color: "primary", **opts)
      @variant = variant.to_sym
      @color = color.to_sym
      @size = size
      @options = [*OPTIONS, *opts, *{
        class: Base.merge_classes(base_classes, size_classes, color_classes, opts[:class]),
      }].to_h
    end

    def button
      button_tag(options) { content }
    end

    def size_classes
      @size_classes ||= size ? "btn-#{size}" : nil
    end

    def color_classes
      @color_classes ||= CLASSES[:color][variant][color]
    end

    def base_classes
      @base_classes ||= CLASSES[:base]
    end
  end
end
