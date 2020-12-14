# frozen_string_literal: true
module AppComponent
  class Base < ViewComponent::Base
    include ViewComponent::SlotableV2

    TAILWINDCSS_COLORS = %i(primary gray blue teal green yellow orange red purple indigo white)

    def self.merge_classes(current_classes, *additional_classes)
      classess_to_merge = additional_classes.reject(&:nil?).map do |classes|
        if classes.is_a?(String)
          return classes.split(' ')
        end

        classes || []
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
  end
end
