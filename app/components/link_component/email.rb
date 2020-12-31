# frozen_string_literal: true

module LinkComponent
  class Email < Base
    def href
      "mailto:#{content}"
    end

    def tag_options
      super.merge(target: "_blank")
    end
  end
end
