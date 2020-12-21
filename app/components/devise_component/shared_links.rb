# frozen_string_literal: true

module DeviseComponent
  class SharedLinks < Base
    attr_reader :options

    CLASSES = %w(d-flex flex-column)

    def initialize(**options)
      @options = options
      @options[:class] = Base.merge_classes(CLASSES, @options[:class])
    end
  end
end
