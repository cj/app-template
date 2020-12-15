# frozen_string_literal: true

class TestController < ApplicationController
  before_action :authenticate, except: [:foo]

  def foo
    render
  end

  def secure
    render(plain: "logged in as #{current_account.email}")
  end
end
