# frozen_string_literal: true

module ButtonComponent
  class Submit < Base
    def base_options
      super.deep_merge({ type: "submit", data: { 'turbo-permanent': true } })
    end
  end
end
