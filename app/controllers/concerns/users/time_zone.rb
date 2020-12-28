# frozen_string_literal: true

module Users
  module TimeZone
    extend ActiveSupport::Concern

    included do
      helper_method :browser_time_zone
    end

    # :reek:DuplicateMethodCall
    def browser_time_zone
      browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:browser_time_zone])
      ActiveSupport::TimeZone.all.detect { |zone| zone.tzinfo == browser_tz } || Time.zone
    rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
      Time.zone
    end
  end
end
