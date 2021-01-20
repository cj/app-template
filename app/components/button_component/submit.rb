# frozen_string_literal: true

module ButtonComponent
  class Submit < Base
    def base_options
      super.deeper_merge({ type: "submit", data: { 'turbo-permanent': true } })
    end
  end
end
