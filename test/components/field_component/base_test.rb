# frozen_string_literal: true

require "test_helper"

class FieldComponent::BaseTest < ViewComponent::TestCase
  test "rendering text field" do
    render_inline(FieldComponent::Base.new("test"))

    assert_match(%(input type="text"), rendered_component)
    assert_matches_snapshot rendered_component
  end

  test "rendering email field" do
    render_inline(FieldComponent::Base.new("test", nil, type: :email))

    assert_match(%(input type="email"), rendered_component)
    assert_matches_snapshot rendered_component
  end

  test "rendering password field" do
    render_inline(FieldComponent::Base.new("test", nil, type: :password))

    assert_match(%(input type="password"), rendered_component)
    assert_matches_snapshot rendered_component
  end
end
