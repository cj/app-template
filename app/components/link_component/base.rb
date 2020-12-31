# frozen_string_literal: true
module LinkComponent
  class Base < AppComponent::Base
    attr_reader :href, :color

    CLASSES = {
      base: %w(d-flex align-items-center),
      icon_left: %w(me-2),
      icon_right: %w(ms-2),
    }

    def initialize(href: nil, icon_left: nil, icon_right: nil, color: "primary", **options)
      @href = href
      @color = color
      @icon_left = icon_left
      @icon_right = icon_right

      super(options)
    end

    def icon_left
      @icon_left.merge({
        class: Base.merge_classes(CLASSES[:icon_left], @icon_left[:class]),
      })
    end

    def icon_right
      @icon_right.merge({
        class: Base.merge_classes(CLASSES[:icon_right], @icon_right[:class]),
      })
    end

    def tag_options
      options.merge({
        class: Base.merge_classes(CLASSES[:base], color_classes, options[:class]),
      })
    end

    def color_classes
      "link-#{color}"
    end
  end
end
