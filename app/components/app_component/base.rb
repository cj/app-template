# frozen_string_literal: true

module AppComponent
  class Base < ViewComponent::Base
    include ViewComponent::SlotableV2
    include Turbo::FramesHelper
    include Turbo::Streams::ActionHelper
    include Turbo::StreamsHelper

    attr_reader :options

    CLASSES = {}

    VIEW_METHODS = %i[refresh! controller].freeze

    def initialize(params: nil, **options)
      @params = params if params

      @options = { turbo_id: turbo_id }.merge(options)
    end

    def tag_options
      @tag_options ||= {
        class: Base.merge_classes(self.class::CLASSES[:base], options[:class]),
      }
    end

    # :reek:UtilityFunction
    def main_app
      Rails.application.class.routes.url_helpers
    end

    def params
      controller&.params || @params || {}
    end

    # :reek:DuplicateMethodCall
    def turbo_id
      @turbo_id ||= \
        begin
          class_name = self.class.to_s.delete(":")
          RequestStore.store[class_name] ||= 0
          class_count = RequestStore.store[class_name] += 1
          "#{class_name}#{class_count}"
        end
    end

    def self.generate_id
      # Nanoid.generate
      Cuid.generate
    end

    def self.merge_classes(current_classes, *additional_classes)
      classess_to_merge = additional_classes.reject(&:nil?).map do |classes|
        if classes.is_a?(String)
          classes.split(" ")
        else
          classes || []
        end
      end

      [Array(current_classes), *classess_to_merge].reduce([], :concat).map(&:strip).uniq
    end

    def method_missing(method, *_args, &_block)
      # We want to ignore the methods if called outside of a view as they are just view component reflex related.
      super unless VIEW_METHODS.include?(method)
    end

    def respond_to_missing?(*)
      true
    end

    def permit_parameter?(_initial_param, new_param)
      if new_param.is_a?(ActiveRecord::Base)
        false
      else
        super
      end
    end
  end
end
