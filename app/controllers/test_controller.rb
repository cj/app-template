# frozen_string_literal: true

class TestController < ApplicationController
  skip_before_action :authenticate_user!, only: [:foo]

  def foo
    render
  end

  def secure
    render(plain: "logged in as #{current_user.name}")
  end
end
