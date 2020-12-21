# frozen_string_literal: true

module AppComponent
  class Base < ViewComponentReflex::Component
    include ViewComponent::SlotableV2

    TAILWINDCSS_COLORS = %i(primary secondary success danger warning info light dark link)

    # :reek:UtilityFunction
    def main_app
      Rails.application.class.routes.url_helpers
    end

    def self.generate_id
      Nanoid.generate
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

    def self.color_hash(&block)
      Hash[
        TAILWINDCSS_COLORS.zip(
          TAILWINDCSS_COLORS.map.each { |color| block.call(color) },
        )
      ]
    end

    def method_missing(method, *_args, &_block)
      # We want to ignore the methods if called outside of a view as they are just view component reflex related.
      unless %i(refresh!).include?(method)
        super
      end
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
