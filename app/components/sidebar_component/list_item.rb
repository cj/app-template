# frozen_string_literal: true

module SidebarComponent
  class ListItem < AppComponent::Base
    attr_reader :tag_name, :component_tag_options

    def initialize(tag: "li", component: {}, **options)
      @tag_name = tag
      @component_tag_options = component

      super(options)
    end

    def call
      tag.public_send(tag_name, tag_options) { content }
    end

    def content
      if options.has_key?(:href)
        render(LinkComponent::Base.new(component_tag_options)) { super }
      else
        super
      end
    end
  end
end
