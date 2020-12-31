# frozen_string_literal: true

module IconComponent
  class Base < AppComponent::Base
    attr_reader :svg

    def initialize(svg:, **options)
      @svg = "#{svg}.svg"

      super(options)
    end

    def call
      inline_svg_pack_tag(svg, tag_options)
    end
  end
end
