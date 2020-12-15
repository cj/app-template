# frozen_string_literal: true
module ButtonComponent
  # Button Component
  class Base < AppComponent::Base
    attr_reader :name, :options

    CLASSES = {
      base: %w(
        inline-flex items-center
        border border-transparent rounded shadow-sm
        focus:outline-none focus:ring-2 focus:ring-offset-2
        justify-center cursor-pointer
      ),

      size: {
        xs: {
          default: %w(text-xs leading-4),
          padding: %w(px-2.5 py-1.5),
        },
        sm: {
          default: %w(text-sm leading-4),
          padding: %w(px-3 py-2),
        },
        base: {
          default: %w(text-sm leading-5),
          padding: %w(px-4 py-2),
        },
        lg: {
          default: %w(text-base leading-6),
          padding: %w(px-4 py-2),
        },
        xl: {
          default: %w(text-base leading-7),
          padding: "%w(px-6 py-3)",
        },
      },

      color: {
        solid: color_hash do |color|
          if color == "white"
            return %w(
              text-gray-700 bg-white
              hover:bg-gray-50
              focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500
            )
          end

          %W(bg-#{color}-500 hover:bg-#{color}-400 focus:ring-#{color}-600 active:bg-#{color}-600 text-white)
        end,
      },
    }.freeze

    OPTIONS = { type: "button" }.freeze

    def initialize(name, variant: "solid", size: "base", color: "primary", **opts)
      @name = name
      @variant = variant.to_sym
      @color = color.to_sym
      @size = size.to_sym
      @options = [*OPTIONS, *opts, *{
        class: Base.merge_classes(
          base_classes,
          size_classes[:default],
          opts[:variant] != "plain" && size_classes[:padding],
          color_classes,
          opts[:class],
        ),
      }].to_h
    end

    def button
      button_tag(name, options)
    end

    def size_classes
      @size_classes ||= CLASSES[:size][@size]
    end

    def color_classes
      @color_classes ||= CLASSES[:color][@variant][@color]
    end

    def base_classes
      @base_classes ||= CLASSES[:base]
    end
  end
end
