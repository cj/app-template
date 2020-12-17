# frozen_string_literal: true

module ButtonComponent
  class Submit < Base
    def options
      super.merge({ type: "submit" })
    end

    def button
      submit_tag(content, options)
    end
  end
end
