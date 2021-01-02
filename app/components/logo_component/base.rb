# frozen_string_literal: true

module LogoComponent
  class Base < AppComponent::Base
    attr_reader :logo, :logo_text

    CLASSES = {
      base: %w(d-flex align-items-center),
      logo: %w(text-uppercase),
      logo_text: %w(fs-4 fw-bolder ms-2 mb-0),
    }.freeze

    def initialize(logo: {}, logo_text: {}, **)
      @logo = logo
      @logo_text = logo_text

      super
    end

    def logo_tag_options
      logo.deep_merge({
        width: 60,
        class: Base.merge_classes(CLASSES[:logo], logo[:class]),
      })
    end

    def logo_text_tag_options
      logo_text.deep_merge({
        class: Base.merge_classes(CLASSES[:logo_text], logo_text[:class]),
      })
    end
  end
end
