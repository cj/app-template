# frozen_string_literal: true

module SidebarComponent
  class Toggle < AppComponent::Base
    attr_reader :selector

    def initialize(selector: nil, **options)
      super(options)

      @selector = selector
    end

    def tag_options_open
      @tag_options_open ||= tag_options.deep_merge({
        color: "link",
        class: %w(fa-lg sidebar-component__toggle--close),
        aria: {
          controls: "navbarHeaderContent",
          expanded: true,
          label: "Toggle navigation",
        },
        data: {
          controller: "sidebar-component--base",
          "sidebar-component--base-id-value": selector,
          action: "click->sidebar-component--base#toggle",
        },
      })
    end

    def tag_options_close
      @tag_options_close ||= tag_options.deep_merge({
        color: "link",
        class: %w(fa-lg sidebar-component__toggle--open),
        aria: {
          controls: "navbarHeaderContent",
          expanded: true,
          label: "Toggle navigation",
        },
        data: {
          controller: "sidebar-component--base",
          "sidebar-component--base-id-value": selector,
          action: "click->sidebar-component--base#toggle",
        },
      })
    end
  end
end
