# frozen_string_literal: true

module HeaderComponent
  class Base < AppComponent::Base
    CLASSES = {
      base: "navbar navbar-expand-lg shadow-sm navbar-light",
    }.freeze

    DARK_COLORS = %w(primary).freeze

    attr_reader :color

    def initialize(color: "light", **options)
      @color = color

      super(options)
    end

    def tag_options
      options.merge(
        class: Base.merge_classes(
          CLASSES[:base],
          color_classes,
          options[:class],
        ),
      )
    end

    def color_classes
      classes = %W[bg-#{color}]

      classes.append("navbar-dark") if DARK_COLORS.include?(color)

      classes
    end
  end
end
