# frozen_string_literal: true

module DropdownComponent
  class Base < AppComponent::Base
    attr_reader :tag_name

    renders_one :list, List

    renders_one :button, ->(**options, &block) do
      ButtonComponent::Base.new(options.deep_merge({
        class: Base.merge_classes(%w(dropdown-toggle), options[:class]),
        href: "#",
        role: "button",
        'aria-expanded': false,
        data: {
          'bs-toggle': "dropdown",
        },
      }), &block)
    end

    CLASSES = {
      base: %w(dropdown),
    }

    def initialize(tag: "div", **options)
      @tag_name = tag

      super(options)
    end
  end
end
