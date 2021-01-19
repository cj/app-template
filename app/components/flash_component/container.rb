# frozen_string_literal: true

module FlashComponent
  class Container < AppComponent::Base
    attr_reader :id

    def initialize(id:, **options)
      @id = id

      super(options)
    end
  end
end
