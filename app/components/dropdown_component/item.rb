# frozen_string_literal: true

module DropdownComponent
  class Item < AppComponent::Base
    attr_reader :divider, :tag_name

    CLASSES = {
      base: %w(dropdown-item),
    }

    def initialize(divider: nil, tag: "li", **options)
      @divider = divider
      @tag_name = tag

      super(options)
    end

    def call
      tag_options[:class].delete("dropdown-item") if divider

      tag.public_send(tag_name, tag_options) do
        if divider
          tag.hr(class: "dropdown-divider")
        else
          content
        end
      end
    end
  end
end
