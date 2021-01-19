# frozen_string_literal: true

module SidebarComponent
  class List < AppComponent::Base
    attr_reader :tag_name, :item_tag_options

    CLASSES = {
      base: %w(ms-auto mb-2 mb-lg-0),
    }

    def initialize(tag: "ul", item: {}, **options)
      @tag_name = tag
      @item_tag_options = item

      super(options)
    end

    def item(**options, &block)
      items.push(
        render(ListItem.new(item_tag_options.deep_merge(options)), &block),
      )
    end

    def dropdown(**options, &block)
      items.push(
        render(DropdownComponent::Base.new(item_tag_options.deep_merge(options)), &block),
      )
    end

    def items
      @items ||= []
    end
  end
end
