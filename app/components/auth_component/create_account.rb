# frozen_string_literal: true

module AuthComponent
  class CreateAccount < Base
    attr_reader :params, :rodauth, :classes, :tag, :options

    CLASSES = %w(d-flex)

    def initialize(params, tag: "div", **options)
      @params = params
      @tag = tag
      @options = [*options, *{ class: Base.merge_classes(CLASSES, options[:class]) }].to_h
    end
  end
end
