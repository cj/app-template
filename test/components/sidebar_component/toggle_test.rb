
# frozen_string_literal: true

require "test_helper"

class SidebarComponent::ToggleTest < ViewComponent::TestCase
  test "classes merging" do
    component = SidebarComponent::Toggle.new(class: %w(foo), data: { foo: "bar" })

    render_inline(component)

    assert_includes component.tag_options_open[:class], "foo"
    assert_includes component.tag_options_open[:class], "sidebar-component__toggle"

    # assert_match(%(input type="text"), rendered_component)
    assert_matches_snapshot rendered_component
  end
end
