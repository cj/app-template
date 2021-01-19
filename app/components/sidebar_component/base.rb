# frozen_string_literal: true

module SidebarComponent
  class Base < AppComponent::Base
    attr_reader :mask, :item_list, :animation

    renders_one :list, List

    CLASSES = {
      mask: %w(sidebar-component__mask),
    }

    def initialize(
      mask: {},
      item_list: {},
      animation: { type: :slide, direction: :left },
      **options
    )
      @mask = mask
      @item_list = item_list
      @animation = animation

      super(options.deep_merge(data: {
        animation: {
          type: animation_type,
          direction: animation_direction,
        },
      }))

      set_css_classes
    end

    def animation_type
      animation[:type]
    end

    def animation_direction
      animation[:direction] || :left
    end

    def set_css_classes
      add_classes("sidebar-component--#{animation_type}")

      if animation_type == :float
        add_classes("shadow closed")
      else
        add_classes("shadow-sm border-end")
      end
    end

    def mask_tag_options
      mask.merge(
        class: Base.merge_classes(CLASSES[:mask], mask[:class]),
      )
    end

    def before_render
      # helpers.body_css_classes.append("contains-sidebar-component--#{variant}")
    end
  end
end
