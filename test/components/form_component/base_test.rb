# frozen_string_literal: true

require "test_helper"

class FormComponent::BaseTest < ViewComponent::TestCase
  test "rendering form" do
    render_inline(FormComponent::Base.new("/")) do |c|
      c.field("test")
      c.email("test")
      c.password("test")
      c.button { "Hello, World!" }
      c.submit { "Submit me" }
    end

    assert_match("form", rendered_component)
    assert_match(%(input type="text"), rendered_component)
    assert_match(%(input type="password"), rendered_component)
    assert_match(%(Hello, World!</button>), rendered_component)
    assert_match(/type="submit".*value="Submit me"/, rendered_component)

    assert_matches_snapshot rendered_component
  end
end
