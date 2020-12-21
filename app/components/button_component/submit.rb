# frozen_string_literal: true

module ButtonComponent
  class Submit < Base
    def base_options
      super.merge({ type: "submit" })
    end

    def button
      submit_tag(text, base_options)
    end
  end
end
