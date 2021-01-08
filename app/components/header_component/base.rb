# frozen_string_literal: true

module HeaderComponent
  class Base < AppComponent::Base
    attr_reader :color, :show_info_bar

    CLASSES = {
      base: "navbar navbar-expand-lg shadow-sm navbar-light",
    }.freeze

    DARK_COLORS = %w(primary).freeze

    def initialize(color: "light", show_info_bar: false, **options)
      @color = color
      @show_info_bar = show_info_bar

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
