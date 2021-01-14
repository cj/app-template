# frozen_string_literal: true

module FlashComponent
  class Base < AppComponent::Base
    def flash_messages
      flash.
        reject { |_type, message| message.to_s == "true" }.
        map do |type, message|
          if type == "timedout"
            [
              "info",
              {
                header: t(".timedout.header"), message: t(".timedout.message")
              },
            ]
          elsif message.is_a?(String)
            [
              type,
              {
                header: type.humanize,
                message: message,
              },
            ]
          else
            [type, message]
          end
        end
    end

    def alert_class(message_type)
      case message_type
      when "error"
        "danger"
      when "alert"
        "warning"
      when "notice"
        "info"
      else
        message_type
      end
    end
  end
end
