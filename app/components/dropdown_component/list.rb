# frozen_string_literal: true

module DropdownComponent
  class List < AppComponent::Base
    renders_many :items, Item

    CLASSES = {
      base: %w(dropdown-menu),
    }

    def tag_options
      {
        'aria-labelledby': "navbarDropdown",
      }.merge(super)
    end
  end
end
