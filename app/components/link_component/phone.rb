# frozen_string_literal: true

module LinkComponent
  class Phone < Base
    def href
      "tel:#{content.gsub(/[^0-9]/, '')}"
    end

    def tag_options
      super.merge(target: "_blank")
    end

    def content
      number_to_phone(super, area_code: true)
    end
  end
end
