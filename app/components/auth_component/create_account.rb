# frozen_string_literal: true

module AuthComponent
  class CreateAccount < Base
    attr_reader :params, :rodauth, :classes, :tag, :options

    CLASSES = %w(flex)

    def initialize(params, rodauth, tag: "div", **options)
      @params = params
      @rodauth = rodauth
      @tag = tag
      @options = options.merge(
        class: Base.merge_classes(CLASSES, options[:class]),
      )
    end

    def handle_email
      puts "moo"
    end
  end
end
