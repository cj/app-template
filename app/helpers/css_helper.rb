# frozen_string_literal: true

module CssHelper
  def body_css_classes
    @body_css_classes ||= \
      begin
        RequestStore.store[:body_css_classes] ||= []
      end
  end
end
