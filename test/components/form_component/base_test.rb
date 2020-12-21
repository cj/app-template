# frozen_string_literal: true

require "test_helper"

class FormComponent::BaseTest < ViewComponent::TestCase
  # test "rendering form" do
  #   render_inline(form) do |c|
  #     c.input(:email)
  #     c.input(:password)
  #     c.checkbox(:remember_me)
  #     c.button { "Hello, World!" }
  #     c.submit { "Submit me" }
  #   end
  #
  #   assert_match("form", rendered_component)
  #   assert_match(%(input type="text"), rendered_component)
  #   assert_match(%(input type="password"), rendered_component)
  #   assert_match(%(checkbox), rendered_component)
  #   assert_match(%(Hello, World!</button>), rendered_component)
  #   assert_match(/type="submit".*value="Submit me"/, rendered_component)
  #
  #   assert_matches_snapshot rendered_component
  # end

  %i(email password name).each do |input_name|
    test "rendering #{input_name} input" do
      render_inline(FormComponent::Base.new(User.new, url: "/")) do |c|
        c.input(input_name)
      end

      type = input_name === :name ? :text : input_name

      assert_match(%(input type="#{type}"), rendered_component)
      assert_matches_snapshot(rendered_component)
    end
  end
end
