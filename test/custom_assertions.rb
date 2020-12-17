# frozen_string_literal: true

require "minitest/assertions"

module Minitest::Assertions
  def assert_contains(expected_substring, string, *args)
    assert(string.include?(expected_substring), *args)
  end
end
