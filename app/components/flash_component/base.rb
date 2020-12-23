# frozen_string_literal: true

module FlashComponent
  class Base < AppComponent::Base
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

    # def before_render
    #   puts flash.to_json
    # end
  end
end
