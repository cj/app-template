# frozen_string_literal: true

class DeviseFailureApp < Devise::FailureApp
  def route(_scope)
    :login_path
  end
end
