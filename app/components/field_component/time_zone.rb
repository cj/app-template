# frozen_string_literal: true

module FieldComponent
  class TimeZone < Base
    delegate :browser_time_zone, to: :helpers

    # :reek:ControlParameter
    def field_tag(_name, field_value, **options)
      time_zone_select(
        resource.class.name.downcase, "time_zone",
        nil,
        { default: field_value || value || browser_time_zone.name },
        options.deeper_merge({
          # data: {
          #   controller: "field-component--autocomplete",
          # },
        })
      )
    end
  end
end
