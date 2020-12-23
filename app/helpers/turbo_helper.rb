# frozen_string_literal: true

module TurboHelper
  def render(component)
    turbo_id = component.turbo_id

    parent_turbo_component = params[:parent_turbo_component]

    if !parent_turbo_component || parent_turbo_component == turbo_id
      super(component)
    end
  end
end
