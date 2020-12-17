# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"

require "rails/test_help"
require "minitest/reporters"
require "minitest/spec"
require "mocha/minitest"

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new(color: true),
    ENV,
    Minitest.backtrace_filter,
)

ViewComponent::TestCase.class_eval do
  def render_inline(*)
    controller.stubs(:request).returns(OpenStruct.new({
      env: {},
      session: OpenStruct.new,
    }))

    super
  end
end

AppComponent::Base.class_eval do
  def self.generate_id
    "generate_id"
  end
end

module ActiveSupport
  class TestCase
    extend MiniTest::Spec::DSL

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
