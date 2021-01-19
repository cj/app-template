# frozen_string_literal: true

module HeaderComponent
  class Base < AppComponent::Base
    attr_reader :color, :show_info_bar, :sidebar_options

    CLASSES = {
      base: %w(navbar navbar-expand-lg shadow-sm navbar-light border-bottom),
    }.freeze

    DARK_COLORS = %w(primary).freeze

    def initialize(color: "light", show_info_bar: false, sidebar: {}, **options)
      super(options)

      @sidebar_options = sidebar
      @color = color
      @show_info_bar = show_info_bar

      set_color_classes
    end

    def set_color_classes
      classes.append("bg-#{color}") unless !!classes.grep(/bg-\w+/i)

      classes.append("navbar-dark") if DARK_COLORS.include?(color)
    end
  end
end
