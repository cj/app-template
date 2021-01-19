# frozen_string_literal: true

module FlashComponent
  class Template < Base
    attr_reader :type, :header, :message

    def initialize(type: nil, header: nil, message: nil, **options)
      @type = type
      @header = header
      @message = message

      super(options)
    end
  end
end
