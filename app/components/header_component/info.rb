# frozen_string_literal: true

module HeaderComponent
  class Info < Base
    CLASSES = {
      base: %w(bg-primary text-white p-2 d-flex),
    }

    def tag_options
      {
        class: Base.merge_classes(CLASSES[:base], options[:class]),
        data: {
          controller: "mask-component--base",
        },
      }
    end
  end
end
